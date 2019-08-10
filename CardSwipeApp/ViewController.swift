//
//  ViewController.swift
//  CardSwipeApp
//
//  Created by 小野勇輔 on 2019/08/10.
//  Copyright © 2019 yo-project. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var baseCard: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    
    
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person3: UIView!
    @IBOutlet weak var person4: UIView!
    @IBOutlet weak var person5: UIView!
    
    
    // ベースカードの中心
    var centerOfCard: CGPoint!
    // ユーザーカードの配列
    var personList: [UIView] = []
    
    // 選択されたカードの数
    var selectedCardCount: Int = 0
    // ユーザーリスト
    let nameList: [String] =
        ["津田梅子", "ジョージワシントン", "ガリレオガリレイ", "板垣退助", "ジョン万次郎"]
    
    
    // いいねをされた名前の配列
    var likedName: [String] = []
    //viewのレイアウト処理が完了した時に呼ばれる　＊カリキュラムと違う CGpoint の処理を行う
    override func viewDidLayoutSubviews() {
        // ベースカードの中心を代入
        centerOfCard = baseCard.center
    }
    
    
    
    // セグエの処理　viewコントローラーが持っているファンクション
    // この中で対象のセグエを指定
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToLikedList" {
           // セグエの行き先をvcにキャストしている
            let vc = segue.destination as!
            TableViewController
            
            
            
            vc.likedName = likedName
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // personListにperson1から5を追加
        personList.append(person1)
        personList.append(person2)
        personList.append(person3)
        personList.append(person4)
        personList.append(person5)
    }
    
    
    
    
    // ベースカードを元に戻す
    // このようにまとめることでわざわざ位置を書く処理と角度を戻す処理を書かなくてすむ
    func resetCard(){
       // 位置を戻す
        baseCard.center = centerOfCard
        // 角度を戻す
        baseCard.transform = .identity
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   //  senderはつないだ情報を持ってきてくれるメソッド　// 引数

    
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        
        // ここのカードは　baseカードと全く同じ　透明なやつsenderはviewの情報
        let card = sender.view!
        // 動いた距離  .translation はどのくら動いたかを表す
        // ここでのviewは全体のviewのことを指している
        // viewからどのくらい動いたか
        let point = sender.translation(in: view)
        
        // ベースカードの動いた距離を取得できた　透明なやつ
        
                             // 今いる場所　　　　// xがどれくらい動いたか
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        //  カードの動いた距離を取得できた　津田梅子
        personList[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y:card.center.y + point.y)
    
      
        // 移動後のcardの中心のx座標」の「真ん中からの距離」を取得する定数を追加
        
        let xfromCenter = card.center.x - view.center.x
        
        // ベースカードに角度をつける処理
        card.transform =
            // CG~は引数にラジアンを入れるとその角度分だけ　　　　　// viewのフルの横幅を2で割っている
                                                        // view.frame.width はviewの横幅のこと
            CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
        
        
        
        //  カードの角度はtransformプロパティのidentityで元に戻すことができる！！！！！
        
        
        // ユーザーカードに角度をつける処理
        personList[selectedCardCount].transform =   CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
        
        
      
        
        
        // likeimage表示のための設定をしてあげる
        
        if xfromCenter > 0 {
            // goodを表示 右辺はimageliteralをタイプ ここまでは格納しただけ
            likeImage.image = #imageLiteral(resourceName: "いいね")
            // ここから表示させてあげる
            likeImage.isHidden = false
            
        } else if xfromCenter < 0 {
            // badを表示　ここまでは格納しただけ
            likeImage.image = #imageLiteral(resourceName: "よくないね")
            // 画像の表示のための処理をしてあげる
            likeImage.isHidden = false
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        // 指を離した場合の処理
        if sender.state == UIGestureRecognizer.State.ended {
            // 離した時点のカードの中心の位置が左から50以内のとき
            if card.center.x < 50 {
               
    // -----------左に大きくスワイプしたときの処理-------------------------
                UIView.animate(withDuration: 0.5, animations: {
                    // ベースカードを元の位置に戻す
                    // self.baseCard.center = self.centerOfCard
                    // ベースカードの角度を元の角度に戻す
                     // self.baseCard.transform = .identity
                    // 関数でまとめている
                    self.resetCard()
                    // likeimageを隠す
                    self.likeImage.isHidden = true
                    
                  
                    // 該当のユーザーカードを画面外(マイナス方向)へ飛ばす
                    self.personList[self.selectedCardCount].center = CGPoint(x:self.personList[self.selectedCardCount].center.x - 500, y: self.personList[self.selectedCardCount].center.y)
                    
                    // 次のカードに行く処理
                    self.selectedCardCount += 1
                    if self.selectedCardCount >= self.personList.count {
                    self.performSegue(withIdentifier: "ToLikedList", sender: self)
                    }
                })
                // 離した時点のカードの中心の位置が右から50以内のとき
            } else if card.center.x > self.view.frame.width - 50 {
// --------------------------右に大きくスワイプしたときの処理---------------------
                UIView.animate(withDuration: 0.5, animations: {
//                    // ベースカードを元の位置に戻す
//                    self.baseCard.center = self.centerOfCard
//                    // ベースカードの角度を元の角度に戻す
//                    self.baseCard.transform = .identity
                    // 上記の処理を関数でまとめている
                    self.resetCard()
                    
                    // likeimageを隠す
                    self.likeImage.isHidden = true
                    
                    //  いいねリストに追加　必ず次のカードに行く前にかく　でなければ次のカード
                    self.likedName.append(self.nameList[self.selectedCardCount])
                   
                    // 該当のユーザーカードを画面外(プラス方向)へ飛ばす
                    self.personList[self.selectedCardCount].center = CGPoint(x:self.personList[self.selectedCardCount].center.x + 500, y: self.personList[self.selectedCardCount].center.y)
                    
                    // 次のカードに行く処理
                    self.selectedCardCount += 1
                    if self.selectedCardCount >= self.personList.count {
                        self.performSegue(withIdentifier: "ToLikedList", sender: self)
                    }
                })
                // それ以外は元の位置に戻す
            } else {
                UIView.animate(withDuration: 0.5, animations: {
                    // ベースカードを元の位置に戻す
                    // self.baseCard.center = self.centerOfCard
                    // ベースカードの角度を元の角度に戻す
                    // self.baseCard.transform = .identity
                    // ユーザーカードを元の位置に戻す
                    self.personList[self.selectedCardCount].center = self.centerOfCard
                    // ユーザーカードの角度を元に戻す
                     self.personList[self.selectedCardCount].transform = .identity
                    // 角度の処理を関数でまとめている
                    self.resetCard()
                    // likeimageを隠す
                    self.likeImage.isHidden = true
                })
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        // 元の位置に戻す処理　つまりもし指を離した時に　という処理
        // ここでいうsenderはpangestureの意味　//         // stateは状態
//        if sender.state == UIGestureRecognizer.State.ended {
//
//
//            //左にスワイプした時の処理
//                // 離した時点のカードの中心の位置が左から50以内のとき
//                if card.center.x < 50 {
//                    // 左に大きくスワイプしたときの処理
//                    UIView.animate(withDuration: 0.5, animations: {
//
//                     // クロージャだからself がついてしまう　エラーで自動で直してくれる
//
//
//                        // 該当のユーザーカードを画面外(マイナス方向)へ飛ばす
//                        self.personList[self.selectedCardCount].center =             // マイナス500の位置まで飛ばす
//                            CGPoint(x:self.personList[self.selectedCardCount].center.x - 500, y: self.personList[self.selectedCardCount].center.y)
//
//                    self.baseCard.center = self.centerOfCard
//                    })
//
//
//                    // ベースカードを元の位置に戻す
//                    // ベースカードは常に所定の位置にもどる必要があるのでセンターにする
//                    // ベースカードをアニメーションの外に出すのはアニメーションの影響を受けないようにする為
//                    // アニメーションをしている時は感知しない為アニメーションに入れると動いている場合スワイプできない
//
//
//
//
//                    // 右にスワイプした時の処理
//                    // 離した時点のカードの中心の位置が右から50以内のとき
//                } else if card.center.x > self.view.frame.width - 50 {
//
//                    // 右に大きくスワイプしたときの処理
//                    UIView.animate(withDuration: 0.5, animations: {
//
//
//                        // 該当のユーザーカードを画面外(プラス方向)へ飛ばす
//                        self.personList[self.selectedCardCount].center = CGPoint(x:self.personList[self.selectedCardCount].center.x + 500, y:
//                            self.personList[self.selectedCardCount].center.y)
//
//
//                    })
//
//                    // ベースカードを元の位置に戻す
//                    self.baseCard.center = self.centerOfCard
//
//
//                    // それ以外は元の位置に戻る処理
//                } else {
//                    UIView.animate(withDuration: 0.5, animations: {
//                        // ベースカードを元の位置に戻す
//                        self.baseCard.center = self.centerOfCard
//                        // ユーザーカードを元の位置に戻す
//                        self.personList[self.selectedCardCount].center = self.centerOfCard
//                })
//
//
//
//
//            }
//
//
//
//
//
//
//
//
//
//            // アニメーション処理
//            UIView.animate(withDuration: 5, animations: {
//                // ベースカードを元の位置に戻す
//                self.baseCard.center = self.centerOfCard
//                // ユーザーカードを元の位置に戻す
//                 self.personList[self.selectedCardCount].center = self.centerOfCard
//
//                })
//
//
//
//
//
//
//            // ベースカードを元の位置に戻す
//            baseCard.center = centerOfCard
//            // ユーザーカードを元の位置に戻す
//            personList[selectedCardCount].center = centerOfCard
//        }
        
    }
    
    
    @IBAction func disLIkeButtonTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, animations: {
            //                    // ベースカードを元の位置に戻す
            //                    self.baseCard.center = self.centerOfCard
            //                    // ベースカードの角度を元の角度に戻す
            //                    self.baseCard.transform = .identity
            // 上記の処理を関数でまとめている
            self.resetCard()
            
            // likeimageを隠す
            self.likeImage.isHidden = true
            
            
            // 嫌いなボタンなのでリストにはいかないようにする
            //  いいねリストに追加　必ず次のカードに行く前にかく　でなければ次のカード
            //self.likedName.append(self.nameList[self.selectedCardCount])
            
            // 該当のユーザーカードを画面外(プラス方向)へ飛ばす
            self.personList[self.selectedCardCount].center = CGPoint(x:self.personList[self.selectedCardCount].center.x - 500, y: self.personList[self.selectedCardCount].center.y)
            
            // 次のカードに行く処理
            self.selectedCardCount += 1
            if self.selectedCardCount >= self.personList.count {
                self.performSegue(withIdentifier: "ToLikedList", sender: self)
            }
        })
        
        
        
        
        
    }
    
    
    @IBAction func likedButtonTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, animations: {
            //                    // ベースカードを元の位置に戻す
            //                    self.baseCard.center = self.centerOfCard
            //                    // ベースカードの角度を元の角度に戻す
            //                    self.baseCard.transform = .identity
            // 上記の処理を関数でまとめている
            self.resetCard()
            
            // likeimageを隠す
            self.likeImage.isHidden = true
            
            //  いいねリストに追加　必ず次のカードに行く前にかく　でなければ次のカード
            self.likedName.append(self.nameList[self.selectedCardCount])
            
            // 該当のユーザーカードを画面外(プラス方向)へ飛ばす
            self.personList[self.selectedCardCount].center = CGPoint(x:self.personList[self.selectedCardCount].center.x + 500, y: self.personList[self.selectedCardCount].center.y)
            
            // 次のカードに行く処理
            self.selectedCardCount += 1
            if self.selectedCardCount >= self.personList.count {
                self.performSegue(withIdentifier: "ToLikedList", sender: self)
            }
        })
        
    }
    
}


