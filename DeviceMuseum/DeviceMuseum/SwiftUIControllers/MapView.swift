//
//  MapView.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 9.05.22.
//

import SwiftUI
import MapKit

// Вариант карты без булавки
//struct MapView: View {
//    @State private var region = MKCoordinateRegion(
//        center:
//            CLLocationCoordinate2D(latitude: 50.086, longitude: 14.41798),
     // span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Map(coordinateRegion: $region)
//            }
//            .navigationTitle("MapKit")
//            .ignoresSafeArea()
//        }
//    }
//}

struct MapView: UIViewRepresentable {

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        let annotation = MKPointAnnotation()
        annotation.title = "Apple Museum "
        annotation.subtitle = "Husova 21, 110 00 Staré Město, Чехия"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 50.086, longitude: 14.41798)
        mapView.addAnnotation(annotation)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: 50.086, longitude: 14.41798)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }

        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
