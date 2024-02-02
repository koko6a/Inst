import Foundation

extension Decodable {
    static func decodeToType<T: Decodable>(_ data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

extension Encodable {
    static func encodeToData<T: Encodable>(_ model: T) -> Data? {
        return try? JSONEncoder().encode(model)
    }
}
