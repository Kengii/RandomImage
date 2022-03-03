//
//  MapVC.swift
//  RandomImage
//
//  Created by Владимир Данилович on 3.03.22.
//

import UIKit
import MapKit

class MapVC: UIViewController {
 
    var user: User?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlaceMark()
    }
    
    private func setupPlaceMark() {
        guard let location = user?.address?.street else { return }

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { [self] (placemarks, error) in
            if let error = error {
                print(error)
                return
            }

            guard let placemarks = placemarks else { return }

            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = self.user?.address?.city
            annotation.subtitle = self.user?.address?.street
            
            guard let placemarkLocation = placemark?.location else { return }

            annotation.coordinate = placemarkLocation.coordinate
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
