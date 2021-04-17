/**
 * コインを投げる状態を表す
 * heads (表) / tail (裏)を表す
 */
public enum PTCGFlipCoin {
    case heads
    case tail

    public static func defaultGenerator() -> PTCGFlipCoin {
        [.heads, .tail].shuffled()[0]
    }

    public static func flip(_ generator: () -> PTCGFlipCoin = PTCGFlipCoin.defaultGenerator) -> PTCGFlipCoin {
        generator()
    }

    public static func repeatWith(_ generator: () -> PTCGFlipCoin = PTCGFlipCoin.defaultGenerator, _ count: Int) -> Array<PTCGFlipCoin> {
        (0 ..< count).reduce(Array<PTCGFlipCoin>()) { (result, _) in
            result + [generator()]
        }
    }

    public static func repeatUntil(_ generator: () -> PTCGFlipCoin = PTCGFlipCoin.defaultGenerator, _ untilFlip: PTCGFlipCoin) -> Array<PTCGFlipCoin> {
        var f = PTCGFlipCoin.flip(generator)
        var result = [f]
        while f != untilFlip {
            f = PTCGFlipCoin.flip(generator)
            result.append(f)
        }
        return result
    }
}
