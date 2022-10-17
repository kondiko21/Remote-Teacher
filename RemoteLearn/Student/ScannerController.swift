import AVFoundation
import UIKit
import Firebase
import MessageUI

class ScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, MFMailComposeViewControllerDelegate {
    
    var viewWidth : CGFloat = 0
    var viewHeight : CGFloat = 0
    let userID = Auth.auth().currentUser?.uid
        
    var barcode : String = ""
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var ref : DatabaseReference?
    
    private var previewView : UIView = {
        var view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = .blue
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var barcodeText : UITextView = {
        var text = UITextView()
        text.text = "Umieść kod qr w środku"
        text.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        text.textColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        text.backgroundColor = .clear
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        viewHeight = UIScreen.main.bounds.height
        viewWidth = UIScreen.main.bounds.width
        
        print("Width: \(viewWidth) Height: \(viewHeight)")
        
        ref = Database.database().reference(withPath: "products")

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName:"square.and.pencil" ), style: UIBarButtonItem.Style.plain, target: self, action: #selector(typedBarcode))
        
        navigationItem.title = "Dodaj zestaw"
        view.backgroundColor = .black
        view.addSubview(previewView)
        view.addSubview(barcodeText)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[v0(\(UIScreen.main.bounds.width - 100))]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": previewView]))
        view.addConstraint(NSLayoutConstraint.init(item: previewView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: (CGFloat((viewWidth/5)*4))))
        view.addConstraint(NSLayoutConstraint.init(item: previewView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: (CGFloat((viewWidth/5)*4))))
        previewView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addConstraint(NSLayoutConstraint.init(item: barcodeText, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25.0))
        view.addConstraint(NSLayoutConstraint.init(item: barcodeText, attribute: .top, relatedBy: .equal, toItem: previewView, attribute: .bottom, multiplier: 1.0, constant: 25.0))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0(\(UIScreen.main.bounds.width))]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": barcodeText]))
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        print("Width: \(viewWidth) Height: \(viewHeight)")
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x: 0, y: 0, width: (viewWidth/5)*4, height: (viewWidth/5)*4)
        previewLayer.backgroundColor = UIColor.black.cgColor
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame.size = CGSize(width: CGFloat((viewWidth/5)*4), height: CGFloat((viewWidth/5)*4))
        previewView.layer.addSublayer(previewLayer)
        
        
        captureSession.startRunning()
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
        
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        self.barcode = code
                print("CODE: \(code)")
            var listView = StudentController()
            listView.navigationController?.isNavigationBarHidden = false
            Database.database().reference().child("users").child(self.userID!).child("sets").updateChildValues([String(code) : true])
            self.navigationController?.pushViewController(listView, animated: true)

        
    }
    
    @objc func typedBarcode() {
                let alert = UIAlertController(title: "Dodaj kod ", message: "Jeśli nie możesz zeskanować kodu od nauczyciela wprowadź go ręcznie", preferredStyle: .alert)
                alert.addTextField { (textField) in
                    textField.placeholder = "Kod kreskowy"
                
                alert.addAction(UIAlertAction.init(title: "Szukaj", style: .default, handler: { (action) in
                    
                    if let code = textField.text {
                        self.barcode = code
                            
                            var listView = StudentController()
                            listView.navigationController?.isNavigationBarHidden = false
                            Database.database().reference().child("users").child(self.userID!).child("sets").updateChildValues([String(code) : true])
                            self.navigationController?.pushViewController(listView, animated: true)

            }
        })

        )}
        self.present(alert, animated: true, completion: nil)

}
}
