
import UIKit
import MapKit
import MBProgressHUD

class CenterMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var mapCenters = [MapCenter]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.loadCenters()
        self.navigationItem.title = "Centros"
        self.addLeftBarButtonWithImage(UIImage(named: "Menu_Icon")!)
    }

    func loadCenters() {
        
        let hub = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hub.mode = .Indeterminate
        hub.dimBackground = true
        hub.labelText = "Cargando"
        let handler = ConnectionHandler()
        handler.fetchCenters({ (centers, error) -> Void in
            if let centers = centers {
                self.populateMapCenters(centers)
            }
            hub.hide(true)
        })
    }
    
    func populateMapCenters(centers: [Center]) {
        
        for center in centers {
            let mapCenter = MapCenter(center)
            mapCenters.append(mapCenter)
        }
        self.projectCentersOnMap()
    }
    
    func projectCentersOnMap() {
        
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegion(center: mapCenters[0].coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        self.mapView.addAnnotations(mapCenters)
    }
    
    func mapView (mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is MapCenter) {
            return nil
        }
        let identifier = "annotationIdentifier"
        var annotationView = MKPinAnnotationView()
        if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as! MKPinAnnotationView! {
            annotationView.annotation = annotation
        }
        else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
            annotationView.pinTintColor = UIColor(red: 214/255.0, green: 138/255.0, blue: 142/255.0, alpha: 1)
            annotationView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIButton
        }
        return annotationView
    }

    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            self.performSegueWithIdentifier("ShowCenterFromMapSegue", sender: view)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "ShowCenterFromMapSegue") && (sender is MKAnnotationView)  {
            if let destination = segue.destinationViewController as? CenterViewController, let centerAnnotation = sender.annotation as? MapCenter {
                destination.center = centerAnnotation.centerInfo
            }
        }
    }
}
