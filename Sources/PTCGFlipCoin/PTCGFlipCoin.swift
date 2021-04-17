/**
 * PTCGFlipCoinSummary
 * コインを投げた表・裏の集計結果
 */
public struct PTCGFlipCoinSummary: CustomStringConvertible {

    /**
     * 表の出た数の合計
     */
    var headsCount: Int

    /**
     * 裏の出た数の合計
     */
    var tailCount: Int

    init(_ heads: Int = 0, _ tail: Int = 0) {
        headsCount = heads
        tailCount = tail
    }

    public var description: String {
        "PTCGFlipCoin - (heads: \(headsCount), tail: \(tailCount))"
    }
}

public extension Array where Element == PTCGFlipCoin {
    /**
     * コインを投げた表と裏の合計を表す構造体を返す
     */
    func reducedFlipSummary() -> PTCGFlipCoinSummary {
        return self.reduce(into: PTCGFlipCoinSummary()) { ( summary: inout PTCGFlipCoinSummary, fliped: PTCGFlipCoin) in
            switch fliped {
            case .heads:
                summary.headsCount += 1
            case .tail:
                summary.tailCount += 1
            }
        }
    }
}

/**
 * コインを投げる状態を表す
 * heads or tail
 */
public enum PTCGFlipCoin {
    /**
     コインの表
     */
    case heads
    
    /**
     コインの裏
     */
    case tail

    public static func defaultGenerator() -> PTCGFlipCoin {
        [.heads, .tail].shuffled()[0]
    }

    /**
     * コインを1回投げ、その結果を返す
     */
    public static func flip(_ generator: () -> PTCGFlipCoin = PTCGFlipCoin.defaultGenerator) -> PTCGFlipCoin {
        generator()
    }

    /**
     * コインを指定された回数投げ、その結果をまとめて返す
     * - Parameters:
     *   - count: 連続してコインを投げる回数
     */
    public static func repeatWith(_ generator: () -> PTCGFlipCoin = PTCGFlipCoin.defaultGenerator, _ count: Int) -> Array<PTCGFlipCoin> {
        (0 ..< count).reduce(Array<PTCGFlipCoin>()) { (result, _) in
            result + [generator()]
        }
    }

    /**
     * 指定したコインの向きが出るまで繰り返しコインを投げ、その結果をまとめて返す
     * - Parameters:
     *   - untilFlip: 連続で投げ続ける条件となる指定したコインの向き
     */
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

