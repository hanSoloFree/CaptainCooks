

import UIKit

class MainViewController: BaseVC {
    
    @IBOutlet weak var firstImageWithSlots: UIImageView!
    @IBOutlet weak var secondImageWithSlots: UIImageView!
    @IBOutlet weak var thirdImageWithSlots: UIImageView!
    
    @IBOutlet weak var numberOfCoinsInMainMenu: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    @IBOutlet weak var progressLevelInMenu: LevelProgressBar!
    
    private var level: Int = Int(Level.shared.level) {
        didSet {
            Level.shared.level = level
        }
    }
    
    @IBOutlet weak var bonusButton: UIButton!
    @IBOutlet weak var questsButton: UIButton!
    
    private var imageCollectionViewCellID = "ImageCollectionViewCell"
    private var imageCollectionViewCellID2 = "ImageCollectionViewCellID2"
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"insidebg")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var slotsElementsPack1: [String] = [ "Element1",
                                         "Element2",
                                         "Element3",
                                         "Element4",
                                         "Element5",
                                         "Element6"]
    
    var slotsElementsPack2: [String] = [ "Element7",
                                         "Element8",
                                         "Element9",
                                         "Element10",
                                         "Element11",
                                         "Element12"]
    
    var slotsElementsPack3: [String] = [ "Element13",
                                         "Element14",
                                         "Element15",
                                         "Element16",
                                         "Element17",
                                         "Element18"]
    
    var imagesArray = [
        UIImage(named: "1"),
        UIImage(named: "2"),
        UIImage(named: "3")
    ]
    
    var imagesArray2 = [
        UIImage(named: "4"),
        UIImage(named: "5"),
        UIImage(named: "6")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfCoinsInMainMenu.text = Level.shared.coinsPool.withCommas()
        
        addTapGestures()
        setMusic()
    }
    
    private func setMusic() {
        if Level.shared.musicOn == false {
            soundBtn.setImage(UIImage(named: "soundOn"), for: .normal)
        }else {
            soundBtn.setImage(UIImage(named: "soundOff"), for: .normal)
        }
    }
    
    private func addTapGestures() {
        //TODO: - refactoring
        let firstTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleMoveToBestSlot))
        firstImageWithSlots.isUserInteractionEnabled = true
        firstImageWithSlots.addGestureRecognizer(firstTapGestureRecognizer)
        let secondTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleMoveToBestSlot2))
        secondImageWithSlots.isUserInteractionEnabled = true
        secondImageWithSlots.addGestureRecognizer(secondTapGestureRecognizer)
        let thirdTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleMoveToBestSlot3))
        thirdImageWithSlots.isUserInteractionEnabled = true
        thirdImageWithSlots.addGestureRecognizer(thirdTapGestureRecognizer)
    }
    
    @objc private func handleMoveToBestSlot() {
        moveToSlot(with: slotsElementsPack1)
    }
    
    @objc private func handleMoveToBestSlot2() {
        moveToSlot(with: slotsElementsPack2)
    }
    
    @objc private func handleMoveToBestSlot3() {
        moveToSlot(with: slotsElementsPack3)
    }
    
    private func moveToSlot(with elementsPack: [String]) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SlotViewController") as! SlotViewController
        names = elementsPack
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBOutlet weak var levelImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        numberOfCoinsInMainMenu.text = Level.shared.coinsPool.withCommas()
        progressLevelInMenu.progress = CGFloat(Level.shared.progress) / 1000
        if Level.shared.level == 2 {
            levelImage.image = UIImage(named: "star3")
        }
        if Level.shared.musicOn == false {
            soundBtn.setImage(UIImage(named: "soundOff"), for: .normal)
        }else {
            soundBtn.setImage(UIImage(named: "soundOn"), for: .normal)
        }
    }
    
    @IBAction func buyCoins(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    let imageViewBackTomorrow = UIImage(named: "backTomorrow")
    let imageViewLuckyYou = UIImage(named: "luckyYou")
    
    @IBOutlet weak var soundBtn: UIButton!
    
    @IBAction func musicIsTapped(_ sender: Any) {
        if Level.shared.musicOn == false {
            backgroundPlayer.cheer()
            soundBtn.setImage(UIImage(named: "soundOn"), for: .normal)
            Level.shared.musicOn = true
        }else {
            backgroundPlayer.stop()
            soundBtn.setImage(UIImage(named: "soundOff"), for: .normal)
            Level.shared.musicOn = false
        }
    }
    
    
    private var coinsPool = Level.shared.coinsPool {
        didSet {
            Level.shared.coinsPool = coinsPool
            numberOfCoinsInMainMenu.text = "\(coinsPool.withCommas())"
        }
    }
    
    
    @IBOutlet weak var getBonusButton: UIButton!
    
    @IBAction func getBonusTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        if let date = Level.shared.dateGetBonus, let willDate = Calendar.current.date(byAdding: .day, value: 1, to: date) {
            if willDate <= Date() {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FortunePopUpViewController") as! FortunePopUpViewController
                coinsPool += 1000000
                Level.shared.getBonus = true
                Level.shared.dateGetBonus = Date()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            } else {
                vc.imageView = imageViewBackTomorrow!
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FortunePopUpViewController") as! FortunePopUpViewController
            coinsPool += 1000000
            Level.shared.getBonus = true
            Level.shared.dateGetBonus = Date()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    
    @IBAction func openQuests(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "QuestsViewController") as! QuestsViewController
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == secondCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCollectionViewCellID2, for: indexPath) as! ImageCollectionViewCell
            cell.slotsImage.image = imagesArray2[indexPath.row]
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCollectionViewCellID, for: indexPath) as! ImageCollectionViewCell
            cell.slotsImage.image = imagesArray[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //MARK:- TODO Send an array of elements to vc
        if Level.shared.level == 2 {
            if collectionView == collectionView {
                if indexPath.item == 0 {
                    handleMoveToBestSlot()
                }
            }
        }
    }
}
