import UIKit
import FirebaseStorage

struct FirestoreImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        ref.putData(imageData, metadata: nil) { _, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            
            ref.downloadURL { url, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }
                guard let url = url?.absoluteString else { return }
                completion(url)
            }
        }
    }
}
