
import UIKit

class RecipeCell: UITableViewCell {
    
    let titleColor = UIColor(red: 0/255.0, green: 153/255.0, blue: 76/255.0, alpha: 1.0)
    let subtitleColor = UIColor.whiteColor()
    let overlayColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    var backgroundImg: UIImageView!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 180)
        self.selectionStyle = .None
        
        backgroundImg  = UIImageView(frame: self.contentView.frame)
        contentView.addSubview(backgroundImg)
        
        let extraColor : UIView = UIView(frame: backgroundImg.frame);
        extraColor.backgroundColor = overlayColor
        backgroundImg.addSubview(extraColor)
        
        titleLabel = UILabel(frame: CGRect(x: 20, y: (self.contentView.frame.size.height/5)*3, width: UIScreen.mainScreen().bounds.size.width - 20, height: 0))
        titleLabel.textColor = titleColor
        titleLabel.alpha = 1.0
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = UIFont(name: "Arial-BoldMT", size: 20)
        titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        titleLabel.numberOfLines = 2
        backgroundImg.addSubview(titleLabel)
        backgroundImg.bringSubviewToFront(titleLabel)
        
        subtitleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 0))
        subtitleLabel.textColor = subtitleColor
        subtitleLabel.alpha = 1.0
        subtitleLabel.backgroundColor = UIColor.clearColor()
        subtitleLabel.font = UIFont(name: "Arial", size: 16)
        subtitleLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        subtitleLabel.numberOfLines = 1
        backgroundImg.addSubview(subtitleLabel)
        backgroundImg.bringSubviewToFront(subtitleLabel)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
