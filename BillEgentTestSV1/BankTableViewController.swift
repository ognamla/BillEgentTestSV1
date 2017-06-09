//
//  BankTableViewController.swift
//  BillEgentTestSV1
//
//  Created by kuan-yu Chiang on 08/06/2017.
//  Copyright © 2017 kuan-yu Chiang. All rights reserved.
//

import UIKit

class BankTableViewController: UITableViewController, URLSessionDelegate, URLSessionDownloadDelegate {
    
    var barcodeArray = [Dictionary<String,Any>]()
    var address = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(BankTableViewController.parseData), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        // parseData()
    }
    
    func parseData() {
        
        // Delegate appDelegate( urlScheme )
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.schemeCode != nil {
            address = appDelegate.schemeCode
            print("Scheme Pass Success : \(appDelegate.schemeCode)")
        }
        
        let fileListAPI = URL(string: "https://spreadsheets.google.com/feeds/list/" + "\(address)" + "/od6/public/values?alt=json")!
        
        // let fileListAPI = URL(string: "https://spreadsheets.google.com/feeds/list/15JjSTdtjJl292GLGXbstWS-92MHqR5a0xw5yzZf5rg8/od6/public/values?alt=json")!
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: .main)
        let dataTask = session.downloadTask(with: fileListAPI)
        dataTask.resume()
        
        
        
        var request = URLRequest(url: fileListAPI)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        var returnDict:Dictionary = [String:String]()
        
        do {
            
            let jsonDict = try JSONSerialization.jsonObject(with: Data(contentsOf: location), options: .allowFragments) as! [String: Any]
            
            let jsonDictForFeed = jsonDict["feed"] as! [String: AnyObject]
            let jsonArray = jsonDictForFeed["entry"] as! [[String: AnyObject]]
            
            for codeDict in jsonArray {
                
                let code1 = codeDict["gsx$code1"]!["$t"]! as! String
                returnDict["code1"] = code1
                let code2 = codeDict["gsx$code2"]!["$t"]! as! String
                returnDict["code2"] = code2
                let code3 = codeDict["gsx$code3"]!["$t"]! as! String
                returnDict["code3"] = code3
                
                self.barcodeArray.append(returnDict)
            }
            
            tableView.reloadData()

            
        } catch {
            
            print(error)
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return barcodeArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BankTableViewCell
        
        let bank = barcodeArray[indexPath.row]["code1"]
        cell.bankLabel.text = bank as? String
        let money = barcodeArray[indexPath.row]["code2"]
        cell.moneyLabel.text = money as? String
        let month = barcodeArray[indexPath.row]["code3"]
        cell.monthLabel.text = month as? String
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "barcode" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = barcodeArray[indexPath.row]
                let barcodeViewController = segue.destination as! BarCodeViewController
                barcodeViewController.barcodeArray = object
                
            }
        }
    }
    
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
