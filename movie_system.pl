/* 
   -----------------------------------------------------------
   Project: Movie Recommendation Expert System
   Course: ARTI 106 - Artificial Intelligence: Principles and Techniques
   Academic Year: 2025-2026 (2nd Semester)
   University: Imam Abdulrahman bin Faisal University (IAU)
   College of Computer Science & Information Technology (CCSIT)
   
   Team Members: Aseel Ahmed,Shahad Khalid,Leen Alaskr,Yara Yarub,Solaf Maan.
   -----------------------------------------------------------
*/

/* 
   The 'start' predicate initializes the Expert System.
   Requirement: Display welcome message, purpose, and instructions.
*/
start :-
    write('-----------------------------------------------------------'), nl,
    write('      Welcome to the Movie Recommendation System           '), nl,
    write('-----------------------------------------------------------'), nl,
    write('PURPOSE: This Expert System uses AI reasoning to suggest '), nl,
    write('movies based on your preferences, mood, and watched history.'), nl,
    nl,
    write('OUR CURRENT MOVIES:'), nl,
    list_all_movies, % This calls the new predicate defined below
    nl,
    write('INSTRUCTIONS:'), nl,
    write('1. Enter your inputs followed by a period (.)'), nl,
    write('2. Write movie names EXACTLY as formatted in the list above(.)'), nl,
    write('3. Movie names and atoms must be in \'single quotes\'.'), nl,
    write('4. To begin, let us know what you have already watched.'), nl,
    write('   (Type \'end.\' when finished or if you have none)'), nl,
    nl,
    watched(Movies),
    run_main_menu(Movies).
/* 
   MAIN MENU LOOP
   Uses a recursive structure to keep the system running until the user exits.
   This fulfills the requirement for an appropriate looping predicate.
*/
run_main_menu(Movies) :-
    nl, write('Main Menu:'), nl,
    write('1. Get a personalized movie recommendation'), nl,
    write('2. View top-rated movies (4.5+)'), nl,
    write('3. Find where a movie is currently airing'), nl,
    write('4. Exit the system'), nl,
    write('Selection: '), read(Option),
    (   Option == 4 -> write('Thank you for using the system. Goodbye!'), nl; 
        (execute_option(Option, Movies)),
        run_main_menu(Movies) % Recursive call to loop back
    ).

/* 
   FACTS SECTION
   Representing the knowledge base of the system.
   Format: movie(Name, Genre, Duration, Mood, Rating).
*/

/* 
   list_all_movies: Logic to display all available movies in the knowledge base.
   Uses backtracking to iterate through all movie facts.
*/
list_all_movies :-
    movie(Title, _, _, _, _),
    write('- \''), write(Title), write('\''), nl,
    fail.
list_all_movies :- true. % This ensures the predicate finishes successfully after the list is done.

/* Sci-fi Movies */
movie('Inception', sci_fi, long, thoughtful, 4.5).
movie('Interstellar', sci_fi, long, thoughtful, 4).
movie('The Matrix', sci_fi, short, excited, 3.5).
movie('Blade Runner 2049', sci_fi, long, thoughtful, 5).
 
/* Comedy Movies */
movie('The Hangover', comedy, short, cheerful, 4.5).
movie('Rush Hour', comedy, short, cheerful, 5).
movie('Step Brothers', comedy, long, cheerful, 4.5).
movie('The Dictator', comedy, short, excited, 4.6).

/* Animation Movies */
movie('Toy Story', animation, short, cheerful, 5).
movie('Spirited Away', animation, long, cheerful, 4).
movie('Finding Nemo', animation, short, excited, 3.5).
movie('Up', animation, short, thoughtful, 4).
movie('Spider-Man: Into the Spider-Verse', animation, long, excited, 5).

/* Horror Movies */
movie('The Conjuring', horror, short, scared, 2.7).
movie('It', horror, long, scared, 4.7).
movie('A Quiet Place', horror, short, scared, 5).
movie('Get Out', horror, long, thoughtful, 4).
movie('The Invisible Man', horror, short, excited, 5).

/* Action Movies */
movie('The Dark Knight', action, long, thoughtful, 4.3).
movie('Mad Max: Fury Road', action, short, excited, 3).

/* Romance Movies */
movie('Titanic', romance, long, scared, 4).
movie('The Notebook', romance, long, thoughtful, 5).
movie('Me Before You', romance, long, thoughtful, 4.1).
movie('How to Lose a Guy in 10 Days', romance, short, cheerful, 4).
movie('La La Land', romance, long, cheerful, 5).

/* 
   CINEMA LOCATIONS (Mapping Facts)
   Relates a movie entity to a specific cinema string.
*/
in_cinema('Inception', 'Empire Cinemas').
in_cinema('Interstellar', 'Empire Cinemas').
in_cinema('The Matrix', 'Empire Cinemas').
in_cinema('Blade Runner 2049', 'Empire Cinemas').
in_cinema('Toy Story', 'Empire Cinemas').
in_cinema('Spirited Away', 'Empire Cinemas').
in_cinema('The Dark Knight', 'Empire Cinemas').
in_cinema('The Hangover', 'AMC Cinemas').
in_cinema('Rush Hour', 'AMC Cinemas').
in_cinema('Step Brothers', 'AMC Cinemas').
in_cinema('The Dictator', 'AMC Cinemas').
in_cinema('Finding Nemo', 'AMC Cinemas').
in_cinema('Titanic', 'AMC Cinemas').
in_cinema('The Notebook', 'AMC Cinemas').
in_cinema('Spider-Man: Into the Spider-Verse', 'MUVI Cinemas').
in_cinema('The Conjuring', 'MUVI Cinemas').
in_cinema('It', 'MUVI Cinemas').
in_cinema('A Quiet Place', 'MUVI Cinemas').
in_cinema('Get Out', 'MUVI Cinemas').
in_cinema('The Invisible Man', 'MUVI Cinemas').
in_cinema('Mad Max: Fury Road', 'MUVI Cinemas').
in_cinema('Me Before You', 'MUVI Cinemas').
in_cinema('How to Lose a Guy in 10 Days', 'MUVI Cinemas').
in_cinema('La La Land', 'MUVI Cinemas').

/* 
   RULES SECTION
   Expresses logical relationships and reasoning[cite: 1].
*/

/* 
   find_movie/4: Logic to match movie attributes.
   Uses the cut (!) operator to stop searching once a recommendation is found.
   Uses logical negation (\+) to ensure the movie hasn't been watched[cite: 1].
*/
find_movie(G, L, M, Movies) :-
    movie(Title, G, L, M, _),
    (\+ member(Title, Movies)),
    nl, write('Based on your mood and preferences, we recommend: '), write(Title), nl, !.

% Fallback rule if no matches are found
find_movie(_, _, _, _) :- 
    nl, write('Sorry, no movie matches those criteria or you have seen them all.'), nl.

/* 
   best_rating/4: Identifies high-quality content.
   Filters movies with a rating of 4.5 or higher.
*/
best_rating(Title, Rating, Genre, Movies) :-
    movie(Title, Genre, _, _, Rating),
    (\+ member(Title, Movies)),
    Rating >= 4.5.

/* 
   watched/1: Collection rule.
   Recursive rule using lists to gather user input until 'end' is typed[cite: 1].
*/
watched(Movies) :-
    write('Enter movie name: '), read(Film),
    (   Film == end ->
        Movies = []
    ;   watched(Rest),          
        Movies = [Film | Rest]  
    ).

/* 
   execute_option/2: Menu controller.
   Facilitates dialogue between the user and the system using read() and write()[cite: 1].
*/
execute_option(1, Movies) :- 
    nl, write('--- Personal Recommendation ---'), nl,
    write('Genre (sci_fi, comedy, animation, horror, action, romance): '), read(G), 
    write('Duration (short/long): '), read(L),
    write('Mood (thoughtful, cheerful, scared, excited): '), read(M),
    find_movie(G, L, M, Movies).

execute_option(2, Movies) :-
    nl, write('--- Top Rated (4.5+) ---'), nl,
    (   best_rating(Title, Rating, Genre, Movies),
        write('- '), write(Title), write(' ['), write(Genre), write('] - Rating: '), write(Rating), nl,
        fail % Forces backtracking to find ALL top rated movies
    ;   true
    ).

execute_option(3,_) :-
    nl, write('Which movie are you looking for? '), read(Title1),
    (   in_cinema(Title1, Cinema) ->
        nl, write(Title1), write(' is playing at: '), write(Cinema), nl
    ;   nl, write('Sorry, that movie is not currently in our local cinema database.'), nl
    ).

% Handles input errors[cite: 1]
execute_option(_, _) :-  nl, write('Invalid selection. Please try again.'), nl.