# Movie Recommendation Expert System (SWI-Prolog)

An artificial intelligence expert system developed using **SWI-Prolog** to provide personalized movie recommendations based on user preferences, current mood, viewing history, and local cinema logistics. 

## 🚀 Key Features & AI Logic
* **Inference Engine & Backtracking:** Leverages Prolog's built-in backtracking mechanism to search through a structured knowledge base (`movie/5` facts) until matching constraints are fully satisfied.
* **Constraint Filtering:** Simultaneously evaluates multiple parameters including **Genre, Duration, Mood, and Star Ratings (4.5+)**.
* **Logical Negation & History Tracking:** Implements recursive rules (`watched/1` and negation `\+`) to dynamically exclude previously viewed movies from recommendations during the user session[cite: 6, 7].
* **Control & Cut Operators:** Utilizes the Prolog cut operator (`!`) to optimize the search process and ensure concise, single-best recommendations.
* **Cinema Logistics Mapping:** Bridges content selection with physical availability by linking movie titles to local cinema chains (Empire, AMC, and MUVI Cinemas)[cite: 6, 7].
* **Robust Menu Loop:** Employs recursive state-like menu structures (`run_main_menu/1`) to handle continuous user interactions and input validation without system crashes[cite: 6, 7].

## 🛠️ Tech Stack & Concepts
* **Language:** SWI-Prolog[cite: 6]
* **Paradigms:** Logic Programming, Artificial Intelligence, Expert Systems
* **Key Constructs:** Facts, Rules, Recursion, Lists, Cut (`!`), Logical Negation (`\+`), Backtracking[cite: 6, 7]

## 📂 Project Structure
* `movie_system.pl` - Complete Prolog source code containing the knowledge base (facts), recommendation rules, and interactive menu loop.
* `ARTI106 Project.pdf` - Comprehensive academic report detailing system objectives, architecture, and testing results[cite: 6].
