//
//  MainViewController.swift
//  photo_pet_chef1
//
//  Created by Katherina Nguyen on 7/19/14.
//  Copyright (c) 2014 KNguyen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {


    @IBOutlet var panelContentView: UIView
    @IBOutlet var panelScrollView: UIScrollView
    @IBOutlet var menuView: UIImageView
    @IBOutlet var bellButton: UIButton
    @IBOutlet var painting: UIImageView
    @IBOutlet var response1: UILabel
    @IBOutlet var response2: UILabel
    @IBOutlet var response3: UILabel

    @IBOutlet var creature: UIImageView
    
    @IBOutlet var cornView: UIImageView
    @IBOutlet var carrotView: UIImageView
    @IBOutlet var beetView: UIImageView
    @IBOutlet var pearView: UIImageView
    
    
    var type : CGFloat?
    var panelStatus : Bool?
    var foodCollection : UIImageView[] = []
    var foodScore : CGFloat = 0
    var objectSizex : CGFloat = 50
    var newImageView : UIImageView?
    
    @IBAction func onDoubleTap(sender: UITapGestureRecognizer) {
        println(panelStatus)
        println("doubletap detected")
        
        panelStatus = true
        animateScrollPanel()
        
        println(panelStatus)
    }
    
    @IBAction func onMenuTap(sender: UITapGestureRecognizer) {
        
        println("menu tapped")
        println(panelStatus)
        
        panelStatus = false
        animateScrollPanel()
        
        println(panelStatus)
        
    }
    
    @IBAction func onMenuDrag(sender: UIPanGestureRecognizer) {
        
        var location = sender.locationInView(view)
        var distance = sender.translationInView(view)
        
        //move the menu anywhere on the scren and adapt the hidden opened panel's vertical position to match
        
        if (sender.state == UIGestureRecognizerState.Began) {
            
            println(panelScrollView.frame.origin.y)
            
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            
            menuView.center = location
            
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            panelScrollView.center.y = location.y
        }

    }
    
    
    @IBAction func onCornPanGesture(sender: UIPanGestureRecognizer) {
        
        println("corn panning detected")
        type = 1
        fromPanel(sender)
        
    }
    
    @IBAction func onCarrotPanGesture(sender: UIPanGestureRecognizer) {
        
        println("carrot panning detected")
        type = 2
        fromPanel(sender)
        
    }
    
    @IBAction func onBeetPanGesture(sender: UIPanGestureRecognizer) {
        
        println("beet panning detected")
        type = 3
        fromPanel(sender)
        
    }
    
    @IBAction func onPearPanGesture(sender: UIPanGestureRecognizer) {
        
        println("pear panning detected")
        type = 4
        fromPanel(sender)
        
    }
    
    
    @IBAction func onBellPress(sender: AnyObject) {
        
        loadCamera()
    }
    
    @IBAction func clearPlate(sender: AnyObject) {
        var count = foodCollection.count
        
        for i in 0..count {
            foodCollection[i].removeFromSuperview()
            //foodCollection[i].alpha = 0.0
        }
        
        foodCollection.removeAll(keepCapacity: true)
        foodScore = 0
        response1.alpha = 0.0
        response2.alpha = 0.0
        response3.alpha = 0.0
    }
    

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pageSetUp()
        panelStatus = false;
        println(panelStatus)
        
    }
    
    
    func fromPanel(sender:UIPanGestureRecognizer) {
        
        //location, translation variables tracking new Corn object
        var location = sender.locationInView(view)
        var distance = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        
        if sender.state == UIGestureRecognizerState.Began {
            println("gesture starts at %@", NSStringFromCGPoint(location))
            println("gesture translation at start: %@", NSStringFromCGPoint(distance))
            
            
            // Make new object when button is clicked. Put it into main view at size 50px by 50px at same y position as cursor, horizontally aligned with corn button
            
            var cornImage = UIImage(named: "food1")
            var carrotImage = UIImage(named: "food2")
            var beetImage = UIImage(named: "food3")
            var pearImage = UIImage(named: "food4")
            
            //add image view to main view
            newImageView = UIImageView()
            newImageView!.userInteractionEnabled = true
            view.addSubview(newImageView)
        
            
            //case specific image add & button formatting upon first click
            switch type! {
            case 1:
                println("corn")
                newImageView!.frame = CGRectMake(cornView.frame.origin.x, location.y, 50, 50)
                newImageView!.image = cornImage
                
                UIView.animateWithDuration(0, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.cornView.transform = CGAffineTransformMakeScale(1.3, 1.3)
                    }, completion: nil)
            case 2:
                println("carrot")
                newImageView!.frame = CGRectMake(carrotView.frame.origin.x, location.y, 50, 50)
                newImageView!.image = carrotImage
                
                UIView.animateWithDuration(0, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.carrotView.transform = CGAffineTransformMakeScale(1.3, 1.3)
                    }, completion: nil)
            case 3:
                println("beet")
                newImageView!.frame = CGRectMake(beetView.frame.origin.x, location.y, 50, 50)
                newImageView!.image = beetImage
                
                UIView.animateWithDuration(0, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.beetView.transform = CGAffineTransformMakeScale(1.3, 1.3)
                    }, completion: nil)
            case 4:
                println("pear")
                newImageView!.frame = CGRectMake(pearView.frame.origin.x, location.y, 50, 70)
                newImageView!.image = pearImage
                
                UIView.animateWithDuration(0, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.pearView.transform = CGAffineTransformMakeScale(1.3, 1.3)
                    }, completion: nil)
            default:
                println("oh noes")
            }
            
            //add pan gesture to new object
            
            var newPanGesture = UIPanGestureRecognizer(target: self, action: "onPan:")
            
            newImageView!.addGestureRecognizer(newPanGesture)
            
            //add pinch gesture to new object
            
            var newPinchGesture = UIPinchGestureRecognizer(target: self, action:"onPinch:")
            
            newImageView!.addGestureRecognizer(newPinchGesture)
            
            
            //add rotate gesture to new object
            
            var newRotateGesture = UIRotationGestureRecognizer(target: self, action: "onRotate:")
            
            newImageView!.addGestureRecognizer(newRotateGesture)
            
            // new object pop bigger upon first click
            UIView.animateWithDuration(0, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.newImageView!.transform = CGAffineTransformMakeScale(1.3, 1.3)
                }, completion: nil)
            
            //counting in foodscore and adding new object to food collection
            foodScore = foodScore + 1
            foodCollection.append(newImageView!)
            println(foodScore)

            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            println("gesture changing at %@", NSStringFromCGPoint(location))
            println("gesture translation changing: %@", NSStringFromCGPoint(distance))
            
            //makes new corn object draggable with cursor
            
            self.newImageView!.center = location
            
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            println("gesture end at %@", NSStringFromCGPoint(location))
            println("gesture translation end: %@", NSStringFromCGPoint(distance))
            
            //make new object smaller upon button release
            
            UIView.animateWithDuration(0, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.newImageView!.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: nil)
            
            calculate()
            
            //case specific button formatting upon release
            switch type! {
            case 1:
                UIView.animateWithDuration(0, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.cornView.transform = CGAffineTransformMakeScale(1.3, 1.3)
                    }, completion: nil)
            case 2:
                UIView.animateWithDuration(0, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.carrotView.transform = CGAffineTransformMakeScale(1.3, 1.3)
                    }, completion: nil)
            case 3:
                UIView.animateWithDuration(0, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.beetView.transform = CGAffineTransformMakeScale(1.3, 1.3)
                    }, completion: nil)
            case 4:
                UIView.animateWithDuration(0, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.pearView.transform = CGAffineTransformMakeScale(1.3, 1.3)
                    }, completion: nil)
            default:
                println("oh noes")
            }
            
        }

    }
    
    func onPan(newSender: UIPanGestureRecognizer) {
        
        var distance = newSender.translationInView(view)
        var location = newSender.locationInView(view);
        var widthOffset = newImageView!.frame.size.width * 0.5
        var heightOffset = newImageView!.frame.size.height * 0.5

        newImageView!.frame = CGRectMake(location.x - widthOffset, location.y - heightOffset, newImageView!.frame.size.width, newImageView!.frame.size.height)
        
        if (newSender.state == UIGestureRecognizerState.Began) {
            println("2 New gesture Began at %@", NSStringFromCGPoint(location))
            
            //makes object bigger upon re-click
            
            UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.newImageView!.transform = CGAffineTransformMakeScale(1.3, 1.3)
                }, completion: nil)
            
            
        } else if (newSender.state == UIGestureRecognizerState.Changed) {
            println("2 Gesture changed")
            
            //makes object draggable with cursor
            
            self.newImageView!.center = location
            
            
        } else if (newSender.state == UIGestureRecognizerState.Ended) {
            println("2 Gesture ended at %@", NSStringFromCGPoint(location))
            
            //make object resize upon release
            
            UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.newImageView!.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: nil)
            
        }
    }
    
    func onPinch(newSender: UIPinchGestureRecognizer) {
        
        var scale: CGFloat = newSender.scale
        println(scale)
        println(newImageView!.frame.size.width)
        objectSizex = newImageView!.frame.size.width
        
        //scale object

        self.newImageView!.transform = CGAffineTransformMakeScale(scale, scale)
        
        //record scale
        var extra = (scale - 1) * 4
        
        if (newSender.state == UIGestureRecognizerState.Ended) {
            foodScore = extra + foodScore
            println(foodScore)
            calculate()
        }
        

    }
    
    func onRotate(newSender: UIRotationGestureRecognizer) {
        var rotation: CGFloat = newSender.rotation
        println(rotation)
        
        //rotate object
        self.newImageView!.transform = CGAffineTransformMakeRotation(rotation)
    }
    
    func calculate() {
        if foodScore < 5 {
            response1.alpha = 1.0
            response2.alpha = 0.0
            response3.alpha = 0.0
            
            UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.creature.frame = CGRect(x: self.creature.frame.origin.x, y: 38, width: self.creature.frame.size.width, height: self.creature.frame.size.height)
                }, completion: nil)
            
            
        } else if foodScore >= 5 && foodScore < 10 {
            response1.alpha = 0.0
            response2.alpha = 1.0
            response3.alpha = 0.0
            
        } else {
            response1.alpha = 0.0
            response2.alpha = 0.0
            response3.alpha = 1.0
            
            UIView.animateWithDuration(2, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.creature.frame = CGRect(x: self.creature.frame.origin.x, y: 350, width: self.creature.frame.size.width, height: self.creature.frame.size.height)
                }, completion: nil)
        }
    }
    
    //panel config
    
    func pageSetUp() {
        
        panelScrollView.scrollEnabled = true
        panelScrollView.contentSize = CGSize(width:643, height:62)
        panelScrollView.alpha = 0.0
        
        response1.alpha = 0.0
        response2.alpha = 0.0
        response3.alpha = 0.0
        
    }
    
    
    func animateScrollPanel() {
        
        if panelStatus == true {
            
            println("panel now closing")
        
        UIView.animateWithDuration(0.9, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.panelScrollView.alpha = 0.0
            self.menuView.alpha = 1.0
            }, completion: nil)
            
            panelStatus = false
            
        } else {
            
            println("panel now opening")
            
            UIView.animateWithDuration(0.9, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.panelScrollView.alpha = 1.0
                self.menuView.alpha = 0.0
                }, completion: nil)
            
            panelStatus = true
        }
        
    }
    
    func loadCamera() {
        // Create image picker controller
        var imagePicker : UIImagePickerController = UIImagePickerController()
        
        
        // Set source to the camera
        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        
        // Delegate is self
        var delegate = imagePicker.delegate
        
        // Allow editing of image ?
        imagePicker.allowsEditing = false
        
        // Show image picker
        self.presentModalViewController(imagePicker, animated: true)

    }
    
    func imagePickerController(picker:UIImagePickerController!, didFinishPickingMediaWithInfo info:NSDictionary) {
        
            // Access the uncropped image from info dictionary
        
        
        var image : UIImage = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
        
        var photoImageView : UIImageView?
        photoImageView = UIImageView()
        painting.addSubview(photoImageView)
        photoImageView!.frame = CGRectMake(painting.frame.origin.x, painting.frame.origin.y, 100, 100)
        photoImageView!.image = image
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
