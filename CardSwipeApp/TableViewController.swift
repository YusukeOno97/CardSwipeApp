//
//  TableViewController.swift
//  CardSwipeApp
//
//  Created by 小野勇輔 on 2019/08/10.
//  Copyright © 2019 yo-project. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    
    // viewコントローラーでいいねされたやつが流れてくる箱を作っている
    var likedName: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    // MARK: - Table view data source
   
    

    
    
    // テーブルビューは下の2つが理解して、できていれば良い！！
    
     // セクションの数　デフォルトで0になっているので、変える
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //デフォルトで0になっているので、変える
        // いいねされたユーザーの数　カウントは数えるメソッド
        return likedName.count
    }

  // 元々コメントアウトされているが絶対に必要なやつ
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // セルのIdentifierを入れる　テーブルビュではなくセルのIdentifier忘れず！間違えず！
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
      
        // いいねされた名前を表示
        cell.textLabel?.text = likedName[indexPath.row]
    

        return cell
    }


   
}
