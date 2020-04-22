protocol IManageWalletsView: class {
    func set(featuredViewItems: [CoinToggleViewItem], viewItems: [CoinToggleViewItem])
}

protocol IManageWalletsViewDelegate {
    func onLoad()

    func onEnable(viewItem: CoinToggleViewItem)
    func onDisable(viewItem: CoinToggleViewItem)
    func onSelect(viewItem: CoinToggleViewItem)

    func onTapCloseButton()
}

protocol IManageWalletsInteractor {
    var coins: [Coin] { get }
    var featuredCoins: [Coin] { get }
    var accounts: [Account] { get }
    var wallets: [Wallet] { get }

    func save(wallet: Wallet)
    func delete(wallet: Wallet)

    func derivationSetting(coinType: CoinType) -> DerivationSetting?
    func save(derivationSetting: DerivationSetting)
}

protocol IManageWalletsInteractorDelegate: AnyObject {
    func didUpdateAccounts()
}

protocol IManageWalletsRouter {
    func show(derivationSetting: DerivationSetting, coin: Coin, delegate: IDerivationSettingDelegate)
    func showNoAccount(coin: Coin)
    func close()
}

protocol IManageWalletsPresenterState {
    var allCoins: [Coin] { get set }
    var wallets: [Wallet] { get set }
    var coins: [Coin] { get }
    func enable(wallet: Wallet)
    func disable(index: Int)
    func move(from: Int, to: Int)
}

class CoinToggleViewItem {
    let coin: Coin
    var state: CoinToggleViewItemState

    init(coin: Coin, state: CoinToggleViewItemState) {
        self.coin = coin
        self.state = state
    }
}

enum CoinToggleViewItemState: CustomStringConvertible {
    case toggleHidden
    case toggleVisible(enabled: Bool)

    var description: String {
        switch self {
        case .toggleHidden: return "hidden"
        case .toggleVisible(let enabled): return "visible_\(enabled)"
        }
    }

}
