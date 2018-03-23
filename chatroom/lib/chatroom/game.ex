defmodule Chatroom.Game do
 alias Chatroom.{Repo, Quest} 
 import Ecto.Query

#Initial state of game
 def load() do
 %{
   active_quests: getAllQuestions(),
   questions: getAllQuestions(),
   p1_score: 0,
   p2_score: 0,
   p1_chance: 1,
   p2_chance: 1
   
 }
 end

#get two random questions for each topic given a difficulty level
 def twoRandomQuests(topic, difficulty) do

    questions = Repo.all(from u in "quests", 
                   where: u.topic == ^topic and u.difficulty == ^difficulty, 
                   select: u.question)    
    Enum.take_random(questions, 2)     
 end

#get answer to a given question
 def getAnswer(qid) do
   Repo.all(from u in "quests", where: u.id == ^qid, select: u.answer)
 end

# get alternatives to given question
 def getAlternatives(qid) do
   Repo.all(from u in "quests", where: u.id == ^qid, select: u.alternatives) 
   |> List.flatten
   |> Enum.shuffle
 end

#get all questions of the game
 def getAllQuestions()do
   quests = []
   quests = quests ++ twoRandomQuests("space", "easy")
   quests = quests ++ twoRandomQuests("technology", "easy")
   quests = quests ++ twoRandomQuests("animals", "easy")
   quests = quests ++ twoRandomQuests("food", "easy")
   quests = quests ++ twoRandomQuests("art", "easy")
   
   quests = quests ++ twoRandomQuests("space", "medium")
   quests = quests ++ twoRandomQuests("technology", "medium")
   quests = quests ++ twoRandomQuests("animals", "medium")
   quests = quests ++ twoRandomQuests("food", "medium")
   quests = quests ++ twoRandomQuests("art", "medium")
   
   quests = quests ++ twoRandomQuests("space", "hard")
   quests = quests ++ twoRandomQuests("technology", "hard")
   quests = quests ++ twoRandomQuests("animals", "hard")
   quests = quests ++ twoRandomQuests("food", "hard")
   quests = quests ++ twoRandomQuests("art", "hard")

 end

#check if answer is correct and increment score

 def matchQuests(prev, question, answer) do
   active_quests = prev.active_quests
   questions = prev.questions
   p1_score = prev.p1_score
   p2_score = prev.p2_score
   p1_chance = prev.p1_chance
   p2_chance = prev.p2_chance
 

 {active_quests, p1_score, p2_score, p1_chance, p2_chance} = cond do
# {active_quests, p1_score,p2_score, p1_chance, p2_chance} = cond do  
 p1_chance == 1 and getAnswer(questionId(question)) == answer 
   -> {List.delete(active_quests, question), p1_score + getScore(question), p2_score, 0, 1}

    p1_chance == 1 and getAnswer(questionId(question)) != answer and Enum.member?(active_quests, question) -> {List.delete(active_quests, question), p1_score, p2_score, 0, 1}

 p2_chance == 1 and getAnswer(questionId(question)) == answer and Enum.member?(active_quests, question) -> 
  {List.delete(active_quests, question), p1_score, p2_score + getScore(question), 1,0}

# p2_chance == 1 and getAnswer(questionId(question)) != answer and Enum.member?
#(active_quests, question) -> {List.delete(active_quests, question), p1_score, p#2_score, 1, 0}

 p2_chance == 1 and getAnswer(questionId(question)) != answer and Enum.member?(active_quests, question) -> {List.delete(active_quests, question), p1_score, p2_score, 1, 0}


 true ->  {active_quests, p1_score, p2_score, p1_chance, p2_chance}

 end
   
end

#get question id from question
 def questionId(question ) do
    Repo.all(from u in "quests", where: u.question == ^question, select: u.id)
 end


#get score of a given question
 def getScore(question) do
  difficulty = Repo.all(from u in "quests", where: u.question == ^question,select: u.difficulty)

IO.inspect(difficulty)
 cond do 
  difficulty == ["easy"] -> 10
  difficulty == ["medium"]-> 20
  difficulty == ["hard"] -> 30
 end

 end

end
