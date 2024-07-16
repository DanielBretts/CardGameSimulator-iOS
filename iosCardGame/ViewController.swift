import UIKit

class ViewController: UIViewController, Callback {
    var isFlipped = false
    var cards : [Card] = []
    var firstCard: Card?
    var secondCard: Card?
    var firstScore:Int = 0
    var secondScore:Int = 0
    var winner: Card?
    var username: String!
    var playerSide: Direction!
    var playersMap: [Direction: String] = [:]
    
    @IBOutlet weak var LBL_playerEast: UILabel!
    @IBOutlet weak var LBL_playerWest: UILabel!
    @IBOutlet weak var firstCardScore_LBL: UILabel!
    @IBOutlet weak var secondCardScore_LBL: UILabel!
    @IBOutlet weak var IMG_secondCard: UIImageView!
    @IBOutlet weak var IMG_firstCard: UIImageView!
    
    @IBOutlet weak var start_BTN: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlayerSide()
        cards =  getCardsList()
        // Initial setup
        IMG_firstCard.image = UIImage(named: "CardBack")
        IMG_secondCard.image = UIImage(named: "CardBack")
        let startGameScheduler = Scheduler(job: self,rounds: Constants.GameScreen.ROUNDS)
        startGameScheduler.startSchedule()
    }
    
    func setPlayerSide(){
        username = UserDefaults.standard.string(forKey: Constants.WelcomeScreen.USER_DEFAULTS_KEY)
        let value = UserDefaults.standard.integer(forKey: Constants.WelcomeScreen.PLAYER_SIDE_KEY)
        if let direction = Direction(rawValue: value){
            if direction == Direction.west{
                LBL_playerWest.text = username
                playersMap[Direction.west] = username
                playersMap[Direction.east] = Constants.GameScreen.AI_LABEL
            }else{
                LBL_playerEast.text = username
                playersMap[Direction.east] = username
                playersMap[Direction.west] = Constants.GameScreen.AI_LABEL
            }
            playerSide = direction
        }
        
        
    }
    
    func doOperation(){
        firstCard = getRandomCard()
        secondCard = getRandomCard()
        
        animateFlipCard(IMG_firstCard,.transitionFlipFromLeft)
        animateFlipCard(IMG_secondCard,.transitionFlipFromRight)
        // Set and display images for first and second card
        IMG_firstCard.image = firstCard?.imageUI
        IMG_secondCard.image = secondCard?.imageUI
        
        setRoundWinner();
        setScore();
    }
    
    func stopOperation(){
        animateFlipCard(IMG_firstCard,.transitionFlipFromLeft)
        animateFlipCard(IMG_secondCard,.transitionFlipFromRight)

        IMG_firstCard.image = UIImage(named: "CardBack")
        IMG_secondCard.image = UIImage(named: "CardBack")
        
    }
    
    func onFinish(){
        setGameWinner()
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let secondController = storyboard.instantiateViewController(withIdentifier: "EndView")
        self.present(secondController, animated: true,completion: nil)
    }
    
    func setGameWinner() {
        let winnerName: String?

        if (firstScore > secondScore) {
            winnerName = playersMap[Direction.west]
        } else if secondScore > firstScore {
            winnerName = playersMap[Direction.east]
        } else {
            // It's a tie
            winnerName = "No one (Tie)"
        }
        // Save the winner's name
        UserDefaults.standard.set(winnerName, forKey: Constants.GameScreen.WINNER_KEY)
    }

    
    func setScore(){
        if winner == firstCard{
            firstScore += 1
            firstCardScore_LBL.text = firstScore.description
        }else if winner == secondCard{
            secondScore += 1
            secondCardScore_LBL.text = secondScore.description
        }
    }
    
    func setRoundWinner(){
        if firstCard!.power > secondCard!.power {
            winner = firstCard;
        } else if (firstCard!.power < secondCard!.power){
            winner = secondCard;
        }else{
            winner = nil
        }
    }
    
    func animateFlipCard(_ imageView: UIImageView, _ animationOption: UIView.AnimationOptions) {
        UIView.transition(with: imageView, duration: 0.3, options: animationOption, animations: nil)
    }

    
    func getRandomCard() -> Card {
        return cards.randomElement()!
    }
}




func getCardsList() -> [Card] {
    return [
        Card(imageUI: UIImage(named: "1.png") ?? UIImage(), power: 1),
        Card(imageUI: UIImage(named: "2.png") ?? UIImage(), power: 2),
        Card(imageUI: UIImage(named: "3.png") ?? UIImage(), power: 3),
        Card(imageUI: UIImage(named: "4.png") ?? UIImage(), power: 4),
        Card(imageUI: UIImage(named: "5.png") ?? UIImage(), power: 5),
        Card(imageUI: UIImage(named: "6.png") ?? UIImage(), power: 6),
        Card(imageUI: UIImage(named: "7.png") ?? UIImage(), power: 7),
        Card(imageUI: UIImage(named: "8.png") ?? UIImage(), power: 8),
        Card(imageUI: UIImage(named: "10.png") ?? UIImage(), power: 10),
        Card(imageUI: UIImage(named: "10_1.png") ?? UIImage(), power: 10),
        Card(imageUI: UIImage(named: "19.png") ?? UIImage(), power: 19),
        Card(imageUI: UIImage(named: "20.png") ?? UIImage(), power: 20)
    ]
}
