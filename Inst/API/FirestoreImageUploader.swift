import UIKit
import FirebaseStorage

enum UploadType {
    case profile
    case post
    
    func path(for fileName: String) -> StorageReference {
        switch self {
        case .profile:
            return Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        case .post:
            return Storage.storage().reference(withPath: "/post/\(fileName)")
        }
    }
}

struct FirestoreImageUploader {
    static func uploadImage(image: UIImage, type: UploadType, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let fileName = NSUUID().uuidString.lowercased()
        let ref = type.path(for: fileName)
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
