//
//  MainViewController2.swift
//  WatsonVR
//
//  Created by user on 2017/11/11.
//


import Foundation
import SwiftyJSON
import Photos

class MainViewController2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // ガイド文言Label
  @IBOutlet weak var guideLabel2: UILabel!
  // 選択された画像
  @IBOutlet weak var selectedImageView2: UIImageView!
  // 解析中のインジケータ
  @IBOutlet weak var activityIndicator2: UIActivityIndicatorView!
  
  // MARK: UIViewController - Event
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: IBAction
  
  /**
   カメラ起動ボタンTap
   */
  @IBAction func launchCameraButtonTapped(_ sender: Any) {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      self.launchImagePicker(type: .camera)
    }
  }
  
  /**
   写真選択ボタンTap
   */
  @IBAction func launchPhotoButtonTapped(_ sender: Any) {
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      self.launchImagePicker(type: .photoLibrary)
    }
  }
  
  /**
   解析開始ボタンTap
   */
  @IBAction func analyzeButtonTapped(_ sender: Any) {
    self.performSegue(withIdentifier: "ShowResultFood", sender: self)

/*    guard let selectedImage = self.selectedImageView2.image else {
      return
    }
    // API仕様の画像サイズを超えないようにリサイズしてからAPIコールする
    guard let resizedImage = self.resizeJpeg(image: selectedImage) else {
      return
    }
    self.callApi(image: resizedImage)
*/
  }

 
  // MARK: Delegate
  
  /**
   UIImagePickerControllerDelegate：画像選択時
   */
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    picker.dismiss(animated: true, completion: nil)
    guard let image = info[UIImagePickerControllerOriginalImage] else {
      return
    }
    // 選択画像をImageViewに表示
    self.selectedImageView2.image = image as? UIImage
    // ガイドLabelを非表示に
    self.guideLabel2.isHidden = true
  }
  
  // MARK: Method
  
  /**
   カメラ/フォトライブラリの起動
   - parameter type: カメラ/フォトライブラリ
   */
  func launchImagePicker(type: UIImagePickerControllerSourceType) {
    let controller = UIImagePickerController()
    controller.delegate = self
    controller.sourceType = type
    self.present(controller, animated: true, completion: nil)
  }
  
  /**
   画像圧縮処理
   - WatsonVR detect_faces APIの仕様により画像サイズは最大2MG（2016年12月現在）
   - サイズが収まるまで再帰的にサイズを縮小する
   - parameter image: ソース画像
   - returns: UIImage
   */
  func resizeJpeg(image: UIImage) -> UIImage? {
    let maxSize: Int = 1480000  // このぐらいのピクセル数だと2MBを超えないようだ(実験値)
    if Int(image.size.width * image.size.height) <= maxSize {
      return image
    }
    // 圧縮
    let size: CGSize = CGSize(width: (image.size.width * 0.8), height: (image.size.height * 0.8))
    UIGraphicsBeginImageContext(size)
    image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    guard let resizeImage = UIGraphicsGetImageFromCurrentImageContext() else {
      return nil
    }
    UIGraphicsEndImageContext()
    // 再帰処理
    return self.resizeJpeg(image: resizeImage)
  }
  
  /**
   API連携
   - parameter image: 解析対象画像イメージ
   */
/*  func callApi(image: UIImage) {
    // 解析結果はAppDelegateの変数を経由してSubViewに渡す
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // API呼び出し準備
    let APIKey = "57148e0be0e6b81abf7d7a003ae29bbf234900b6" // APIKeyを取得してここに記述
    let url = "https://gateway-a.watsonplatform.net/visual-recognition/api/v3/detect_faces?api_key=" + APIKey + "&version=2016-05-20"
    guard let destURL = URL(string: url) else {
      print ("url is NG: " + url) // debug
      return
    }
    var request = URLRequest(url: destURL)
    request.httpMethod = "POST"
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpBody = UIImageJPEGRepresentation(image, 1)
    
    // activityIndicator始動
    self.activityIndicator2.startAnimating()
    
    // WatsonAPIコール
    let task = URLSession.shared.dataTask(with: request) {
      data, response, error in
      
      if error == nil {
        // APIレスポンス：正常
        let json = JSON(data: data!)
        print(json) // debug
        
//        appDelegate.analyzedFood = self.interpretJson(image: image, json: json)
        
        // リクエストは非同期のため画面遷移をmainQueueで行わないとエラーになる
        OperationQueue.main.addOperation(
          {
            //　activityIndicator停止
            self.activityIndicator2.stopAnimating()
            if appDelegate.analyzedFood.count > 0 {
              // 解析結果あり
              self.performSegue(withIdentifier: "ShowResultFood", sender: self)
            } else {
              // 解析結果なし
              let actionSheet = UIAlertController(title:"エラー", message: "検出されませんでした", preferredStyle: .alert)
              let actionCancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: {action in
              })
              actionSheet.addAction(actionCancel)
              self.present(actionSheet, animated: true, completion: nil)
            }
          }
        )
      } else {
        // APIレスポンス：エラー
        print(error.debugDescription)   // debug
      }
      //　activityIndicator停止
      if self.activityIndicator2.isAnimating {
        self.activityIndicator2.stopAnimating()
      }
    }
    
    task.resume()
  }
*/
  /**
   解析結果のJSONを解釈してAnalyzedFace型の配列で返す
   - parameter image: 元画像
   - parameter json: JSONデータ
   - returns: AnalyzedFood型の配列
   */
/*  func interpretJson(image: UIImage, json: JSON) -> Array<AnalyzedFace> {
    var analyzedFaces: Array<AnalyzedFace> = []
    let facesJson = json["images"][0]["faces"].arrayValue
    // レスポンスのimageFaces要素は配列となっている（複数人が映った画像の解析が可能）
    for faceJson in facesJson {
      let face = AnalyzedFace()
      // 性別およびスコア
      guard let gender = faceJson["gender"]["gender"].string else {
        continue
      }
      if gender == "MALE" {
        face.gender = "男性"
      } else {
        face.gender = "女性"
      }
      guard let genderScore = faceJson["gender"]["score"].double else {
        continue
      }
      face.genderScore = String(floor(genderScore * 1000) / 10)
      // 年齢およびスコア
      if let ageMin = faceJson["age"]["min"].int {
        face.ageMin = String(ageMin)
      }
      if let ageMax = faceJson["age"]["max"].int {
        face.ageMax = String(ageMax)
      }
      guard let ageScore = faceJson["age"]["score"].double else {
        continue
      }
      face.ageScore = String(floor(ageScore * 1000) / 10)
      // Identity
      if let identity = faceJson["identity"]["name"].string {
        face.identity = identity
      }
      // 検出された顔の矩形
      guard let left = faceJson["face_location"]["left"].int else {
        continue
      }
      guard let top = faceJson["face_location"]["top"].int else {
        continue
      }
      guard let width = faceJson["face_location"]["width"].int else {
        continue
      }
      guard let height = faceJson["face_location"]["height"].int else {
        continue
      }
      // 元画像から切り抜いて変数にセット
      face.image = self.cropping(image: image, left: CGFloat(left), top: CGFloat(top), width: CGFloat(width), height: CGFloat(height))
      // 抽出完了
      analyzedFaces.append(face)
    }
    return analyzedFaces
  }
  
  /**
   元画像から矩形を切り抜く
   - parameter image: 元画像
   - parameter left: x座標
   - parameter top: y座標
   - parameter width: 幅
   - parameter height: 高さ
   - returns: UIImage
   */
  func cropping(image: UIImage, left: CGFloat, top: CGFloat, width: CGFloat, height: CGFloat) -> UIImage? {
    let imgRef = image.cgImage?.cropping(to: CGRect(x: left, y: top, width: width, height: height))
    return UIImage(cgImage: imgRef!, scale: image.scale, orientation: image.imageOrientation)
  }
  */
}
