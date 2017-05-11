Simulate the card game "Shed"

IMPORTANT:
Because Swift doesn't support separate test-only dependencies, this package is
limiting because it will require XCTest to be linked into any executables you
create down the line.  That's not particularly pleasant.

Note that the Quick testing framework doesn't fully work with Swift Package
Manager, so I'm using my own Spec library, which is close to being
interface-compliant with Quick, but subclasses XCTest directly.
