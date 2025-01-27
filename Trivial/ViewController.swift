//
//  ViewController.swift
//  Trivial
//
//  Created by Tardes on 27/1/25.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var QuestionTxt: UILabel!
    
    @IBOutlet weak var Chesse_1: UIImageView!
    @IBOutlet weak var Chesse_2: UIImageView!
    @IBOutlet weak var Chesse_3: UIImageView!
    @IBOutlet weak var Chesse_4: UIImageView!
    @IBOutlet weak var Chesse_5: UIImageView!
    @IBOutlet weak var Chesse_6: UIImageView!
    
    @IBOutlet weak var txtAnswer: UILabel!
    var list:[DataQuestion] = getAll()
    var QuestionSelect:Int = 0
    var QuestionUsed:[Int] = []
    var CategorysGet:[CategoryQuestionEnum]=[]
    var CategorySelected:CategoryQuestionEnum = CategoryQuestionEnum.Geografia
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableView.delegate = self
        TableView.dataSource = self
        QuestionTxt.text = list[QuestionSelect].QuestionText
        txtAnswer.text = "Para la categoria de: " + String(describing:CategorySelected)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Reset()
    }
    
    func Reset()
    {
        QuestionSelect = 0
        QuestionUsed = []
        CategorysGet = []
        Chesse_1.backgroundColor = UIColor.clear
        Chesse_2.backgroundColor = UIColor.clear
        Chesse_3.backgroundColor = UIColor.clear
        Chesse_4.backgroundColor = UIColor.clear
        Chesse_5.backgroundColor = UIColor.clear
        Chesse_6.backgroundColor = UIColor.clear
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("The value of QuestionSelect is \(QuestionSelect)")
        print("The number of Answers is \(list[QuestionSelect].Answers.count)")
        
        return list[QuestionSelect].Answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "cell" ,for: indexPath)
        cell.textLabel?.text = list[QuestionSelect].Answers[indexPath.row].AnswerText
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if( ItsCorrectQuestion(indexPath.row) == true)
        {
            txtAnswer.text = list[QuestionSelect].CorrectAnswerTxt
            ChangeColorChesse(CategorySelected)
            QuestionUsed.append(QuestionSelect)
            CategorysGet.append(CategorySelected)
            GoToNextView()
        }else
        {
            txtAnswer.text = list[QuestionSelect].FailAnswerTxt
        }
    }
    
    func GoToNextView()
    {
        
        
        if(CategorysGet.count >= 6)
        {
            performSegue(withIdentifier: "showVictory", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //let detailViewController = segue.destination as! VictoryViewController
            //TableView.deselectItem(at: indexPath, animated: true)
        }
    
    
    @IBAction func RandomCategory(_ sender: Any) {
        
       
        GetRandomCategory()
        
    }
    func ItsCorrectQuestion(_ index:Int)->Bool
    {
        
        return list[QuestionSelect].Answers[index].ItsCorrect
    }
    func ChangeColorChesse(_ category:CategoryQuestionEnum)
    {
        switch category {
        case .Geografia:
            Chesse_1.backgroundColor = UIColor.blue
        case .ArtAndLiterature:
            Chesse_2.backgroundColor = UIColor.purple
        case .History:
            Chesse_3.backgroundColor = UIColor.yellow
        case .Entertainment:
            Chesse_4.backgroundColor = UIColor.red
        case .Science:
            Chesse_5.backgroundColor = UIColor.green
        case .Sports:
            Chesse_6.backgroundColor = UIColor.orange
        }
    }
    func GetNewQuestion()
    {
        
        var QuestionUsedNew:[DataQuestion] = []
        
        for question in list {
            if(QuestionUsed.contains(question.id) || CategorysGet.contains(question.CategoryQuestion))
            {
                //Error esta pregunta ya fue utilizada.
            }else
            {
                QuestionUsedNew.append(question)
                /*
                QuestionSelect = question.id
                TableView.reloadData()
                QuestionTxt.text = list[QuestionSelect].QuestionText
                txtAnswer.text = "Para la categoria de: " + String(describing:CategorySelected)
                 
                break
                 */
            }
        }
        
        QuestionSelect = QuestionUsedNew.randomElement()!.id
        TableView.reloadData()
        QuestionTxt.text = list[QuestionSelect].QuestionText
        txtAnswer.text = "Para la categoria de: " + String(describing:CategorySelected)
    }
    func GetRandomCategory()
    {
        let RandomCategory = Int.random(in: 0..<6)
        let NewCategory = GetCategory(RandomCategory)
        var CategoryRepeat = false
        for category in CategorysGet {
            if(NewCategory == category || CategorysGet.contains(NewCategory))
            {
                CategoryRepeat = true
                break
            }
        }
        if(CategoryRepeat == true)
        {
            GetRandomCategory()
        }
        else
        {
            CategorySelected =  NewCategory
            GetNewQuestion()
        }
        
    }
    func GetCategory(_ numberPass:Int)->CategoryQuestionEnum
    {
        switch numberPass {
        case 0:
            return CategoryQuestionEnum.Geografia
        case 1:
            return CategoryQuestionEnum.ArtAndLiterature
        case 2:
            return CategoryQuestionEnum.History
        case 3:
            return CategoryQuestionEnum.Entertainment
        case 4:
            return CategoryQuestionEnum.Science
        case 5:
            return CategoryQuestionEnum.Sports
        default:
            return CategoryQuestionEnum.Geografia
        }
    }
    
    static func getAll()->[DataQuestion]
       {
           //Geografia
           
           let Answers1: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Nilo",ItsCorrect: false),
            DataAnswer(AnswerText: "Amazonas",ItsCorrect: true),
            DataAnswer(AnswerText: "Yangtsé",ItsCorrect: false),
            DataAnswer(AnswerText: "Misisipi",ItsCorrect: false)
           ];
           let Answers2: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Asia",ItsCorrect: false),
            DataAnswer(AnswerText: "América",ItsCorrect: false),
            DataAnswer(AnswerText: "África",ItsCorrect: true),
            DataAnswer(AnswerText: "Australia",ItsCorrect: false)
           ];
           let Answers3: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Filipinas",ItsCorrect: false),
            DataAnswer(AnswerText: "Suecia",ItsCorrect: true),
            DataAnswer(AnswerText: "Indonesia",ItsCorrect: false),
            DataAnswer(AnswerText: "Canadá",ItsCorrect: false)
           ];
           
           //Art And Literature
           
           let Answers4: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Suzanne Collins",ItsCorrect: false),
            DataAnswer(AnswerText: "J.K. Rowling",ItsCorrect: true),
            DataAnswer(AnswerText: "Stephen King",ItsCorrect: false),
            DataAnswer(AnswerText: "George R.R. Martin",ItsCorrect: false)
           ];
           let Answers5: Array<DataAnswer> = [
            DataAnswer(AnswerText: "La Última Cena",ItsCorrect: false),
            DataAnswer(AnswerText: "La Noche Estrellada",ItsCorrect: true),
            DataAnswer(AnswerText: "El Grito",ItsCorrect: false),
            DataAnswer(AnswerText: "La Mona Lisa",ItsCorrect: false)
           ];
           let Answers6: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Moby Dick",ItsCorrect: false),
            DataAnswer(AnswerText: "Cumbres Borrascosas",ItsCorrect: false),
            DataAnswer(AnswerText: "Historia de dos ciudades ",ItsCorrect: true),
            DataAnswer(AnswerText: "El gran Gatsby",ItsCorrect: false)
           ];
           
           //historia
           
           let Answers7: Array<DataAnswer> = [
            DataAnswer(AnswerText: "1959",ItsCorrect: false),
            DataAnswer(AnswerText: "1969",ItsCorrect: true),
            DataAnswer(AnswerText: "1975",ItsCorrect: false),
            DataAnswer(AnswerText: "1980",ItsCorrect: false)
           ];
           let Answers8: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Abraham Lincoln",ItsCorrect: false),
            DataAnswer(AnswerText: "John Adams",ItsCorrect: false),
            DataAnswer(AnswerText: "George Washington",ItsCorrect: true),
            DataAnswer(AnswerText: "Thomas Jefferson",ItsCorrect: false)
           ];
           let Answers9: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Imperio Griego",ItsCorrect: false),
            DataAnswer(AnswerText: "Imperio Egipcio",ItsCorrect: false),
            DataAnswer(AnswerText: "Imperio Romano ",ItsCorrect: true),
            DataAnswer(AnswerText: "Imperio Persa",ItsCorrect: false)
           ];
           
           //VideoGames
           
           let Answers10: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Luigi",ItsCorrect: false),
            DataAnswer(AnswerText: "Mario",ItsCorrect: true),
            DataAnswer(AnswerText: "Sonic",ItsCorrect: false),
            DataAnswer(AnswerText: "Toad",ItsCorrect: false)
           ];
           let Answers11: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Call of Duty",ItsCorrect: false),
            DataAnswer(AnswerText: "Assasins Creed",ItsCorrect: false),
            DataAnswer(AnswerText: "Halo",ItsCorrect: true),
            DataAnswer(AnswerText: "Destiny",ItsCorrect: false)
           ];
           let Answers12: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Roblox",ItsCorrect: false),
            DataAnswer(AnswerText: "Terraria",ItsCorrect: false),
            DataAnswer(AnswerText: "Minecraft",ItsCorrect: true),
            DataAnswer(AnswerText: "Fortnite",ItsCorrect: false)
           ];
           
           //Ciencia
           
           let Answers13: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Júpiter",ItsCorrect: false),
            DataAnswer(AnswerText: "Marte",ItsCorrect: true),
            DataAnswer(AnswerText: "Saturno",ItsCorrect: false),
            DataAnswer(AnswerText: "Venus",ItsCorrect: false)
           ];
           let Answers14: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Oro",ItsCorrect: false),
            DataAnswer(AnswerText: "Osmio",ItsCorrect: false),
            DataAnswer(AnswerText: "Oxígeno",ItsCorrect: true),
            DataAnswer(AnswerText: "Oxalato",ItsCorrect: false)
           ];
           let Answers15: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Pulmones",ItsCorrect: false),
            DataAnswer(AnswerText: "Hígado",ItsCorrect: false),
            DataAnswer(AnswerText: "Corazón",ItsCorrect: true),
            DataAnswer(AnswerText: "Riñones",ItsCorrect: false)
           ];
           
           
           //Sports
           
           let Answers16: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Argentina",ItsCorrect: false),
            DataAnswer(AnswerText: "Brasil",ItsCorrect: true),
            DataAnswer(AnswerText: "Alemania",ItsCorrect: false),
            DataAnswer(AnswerText: "Italia",ItsCorrect: false)
           ];
           let Answers17: Array<DataAnswer> = [
            DataAnswer(AnswerText: "Skateboarding",ItsCorrect: false),
            DataAnswer(AnswerText: "Snowboarding",ItsCorrect: false),
            DataAnswer(AnswerText: "Surf",ItsCorrect: true),
            DataAnswer(AnswerText: "Windsurf",ItsCorrect: false)
           ];
           let Answers18: Array<DataAnswer> = [
            DataAnswer(AnswerText: "4",ItsCorrect: false),
            DataAnswer(AnswerText: "7",ItsCorrect: false),
            DataAnswer(AnswerText: "5",ItsCorrect: true),
            DataAnswer(AnswerText: "6",ItsCorrect: false)
           ];
           
           
           let list = [
            DataQuestion(id: 0, CategoryQuestion: CategoryQuestionEnum.Geografia , QuestionText: "¿Cuál es el río más largo del mundo?", Answers:Answers1, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            DataQuestion(id: 1, CategoryQuestion: CategoryQuestionEnum.Geografia , QuestionText: "¿En qué continente se encuentra el desierto del Sahara?", Answers:Answers2, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            DataQuestion(id: 2, CategoryQuestion: CategoryQuestionEnum.Geografia , QuestionText: "¿Qué país tiene la mayor cantidad de islas en el mundo?", Answers:Answers3, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            
            DataQuestion(id: 3, CategoryQuestion: CategoryQuestionEnum.ArtAndLiterature , QuestionText: "¿Quién escribió Harry Potter?", Answers:Answers4, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            DataQuestion(id: 4, CategoryQuestion: CategoryQuestionEnum.ArtAndLiterature , QuestionText: "¿Cuál es la pintura más famosa de Vincent van Gogh?", Answers:Answers5, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            DataQuestion(id: 5, CategoryQuestion: CategoryQuestionEnum.ArtAndLiterature , QuestionText: "¿Qué novela comienza con “Era el mejor de los tiempos, era el peor de los tiempos”?", Answers:Answers6, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            
            DataQuestion(id: 6, CategoryQuestion: CategoryQuestionEnum.History , QuestionText: "¿En qué año llegó el hombre a la Luna?", Answers:Answers7, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            DataQuestion(id: 7, CategoryQuestion: CategoryQuestionEnum.History , QuestionText: "¿Quién fue el primer presidente de los Estados Unidos?", Answers:Answers8, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            DataQuestion(id: 8, CategoryQuestion: CategoryQuestionEnum.History , QuestionText: "¿Qué imperio construyó el Coliseo?", Answers:Answers9, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            
            DataQuestion(id: 9, CategoryQuestion: CategoryQuestionEnum.Entertainment , QuestionText: "¿Cuál es el nombre del fontanero más famoso de los videojuegos?", Answers:Answers10, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            DataQuestion(id: 10, CategoryQuestion: CategoryQuestionEnum.Entertainment , QuestionText: "¿En qué videojuego aparece el personaje “Master Chief”?", Answers:Answers11, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            DataQuestion(id: 11, CategoryQuestion: CategoryQuestionEnum.Entertainment , QuestionText: "¿Qué videojuego popular consiste en construir estructuras con bloques?", Answers:Answers12, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            
            DataQuestion(id: 12, CategoryQuestion: CategoryQuestionEnum.Science , QuestionText: "¿Qué planeta es conocido como el planeta rojo", Answers:Answers13, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            DataQuestion(id: 13, CategoryQuestion: CategoryQuestionEnum.Science , QuestionText: "¿Cuál es el elemento químico representado por la letra O?", Answers:Answers14, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            DataQuestion(id: 14, CategoryQuestion: CategoryQuestionEnum.Science , QuestionText: "¿Qué órgano del cuerpo humano es responsable de bombear la sangre?", Answers:Answers15, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            
            DataQuestion(id: 15, CategoryQuestion: CategoryQuestionEnum.Sports , QuestionText: "¿Qué país ha ganado más Copas del Mundo de fútbol masculino?", Answers:Answers16, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            DataQuestion(id: 16, CategoryQuestion: CategoryQuestionEnum.Sports , QuestionText: "¿En qué deporte se utiliza una tabla y olas?", Answers:Answers17, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            DataQuestion(id: 17, CategoryQuestion: CategoryQuestionEnum.Sports , QuestionText: "¿Cuántos jugadores hay en un equipo de baloncesto en la cancha?", Answers:Answers18, CorrectAnswerTxt: "Que bien lo has hecho", FailAnswerTxt: "Tienes menos cultura que un burro"),
            
            ]
           
           return list
       }

}

