//
//  TaxiMapViewRepresentable.swift
//  PointTaxi
//
//  Created by zedsbook on 24.01.2023.
//

import SwiftUI
import MapKit

struct TaxiMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager.shared
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isPitchEnabled = true
        mapView.isRotateEnabled = true
        mapView.showsCompass = false
        mapView.tintColor = .black
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationSearchViewModel.selectedTaxiLocation?.coordinate {
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        case .polylineAdded:
            break
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension TaxiMapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        
        //MARK: - Properties
        
        let parent: TaxiMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        var cameraCentered = false
        
        //MARK: - Lifecycle
        
        init(parent: TaxiMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        //MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            guard !cameraCentered else { return }
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05,longitudeDelta: 0.05)
            )
            self.currentRegion = region
            parent.mapView.setRegion(region, animated: true)
            cameraCentered = true
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? MKPointAnnotation else { return nil }
            let identifier = "Annotation"
            var view: MKMarkerAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
            }
            view.markerTintColor = UIColor(named: "blackWhiteColor")
            return view
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = UIColor(named: "blackWhiteColor")
            polyline.lineWidth = 3
            return polyline
        }
        
        //MARK: - Helpers
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            self.parent.mapView.removeAnnotations(self.parent.mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            self.parent.mapView.addAnnotation(annotation)
            self.parent.mapView.selectAnnotation(annotation, animated: true)
            self.parent.mapView.showAnnotations(self.parent.mapView.annotations, animated: true)
            
        }
        
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            self.parent.mapView.removeOverlays(self.parent.mapView.overlays)
            self.parent.locationSearchViewModel.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { [ weak self ] route in
                guard let strongSelf = self else { return }
                strongSelf.parent.mapView.addOverlay(route.polyline)
                strongSelf.parent.mapState = .polylineAdded
                let rect = strongSelf.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(
                    top: 64, left: 32, bottom: 350, right: 32))
                strongSelf.parent.mapView.setRegion(MKCoordinateRegion(rect ), animated: true)
            }
        }
        
        func clearMapViewAndRecenterOnUserLocation() {
            self.parent.mapView.removeAnnotations(self.parent.mapView.annotations)
            self.parent.mapView.removeOverlays(self.parent.mapView.overlays)
            if let currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
                cameraCentered = false
            }

        }
    }
}
