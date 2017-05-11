extension Collection {
    public func eachWithObject<T>(_ object: T, _ f: @escaping (inout T, Self.Iterator.Element) -> Void) -> T {
        var obj = object
        forEach { f(&obj, $0) }
        return obj
    }
}
