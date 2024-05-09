draw_logo :-
    nl,
    write('  _____                                             _              '), nl,
    write(' |  __ \\                                           | |             '), nl,
    write(' | |__) | ___  _ __   _ __    __ _   __ _  _ __  __| |  ___  _ __  '), nl,
    write(' |  _  / / _ \\| `_ \\ | `_ \\  / _` | / _` || `__|/ _` | / _ \\| `_ \\ '), nl,
    write(' | | \\ \\|  __/| | | || |_) || (_| || (_| || |  | (_| ||  __/| | | |'), nl,
    write(' |_|  \\_\\\\___||_| |_|| .__/  \\__,_| \\__,_||_|   \\__,_| \\___||_| |_|'), nl,
    write('                     | |                                           '), nl,
    write('                     |_|                                           '), nl.

draw_options :-
    nl,
    write(' ----------------------------- '), nl,
    write('|                             |'), nl, 
    write('|    1 - Player Vs. Player    |'), nl, 
    write('|                             |'), nl,
    write('|-----------------------------|'), nl,
    write('|                             |'), nl, 
    write('|   2 - Player Vs. Computer   |'), nl, 
    write('|                             |'), nl,
    write('|-----------------------------|'), nl,
    write('|                             |'), nl, 
    write('|   3 - Computer Vs. Player   |'), nl, 
    write('|                             |'), nl,
    write('|-----------------------------|'), nl,
    write('|                             |'), nl, 
    write('|  4 - Computer Vs. Computer  |'), nl, 
    write('|                             |'), nl,
    write(' ----------------------------- '), nl, nl.

display_state([]) :- nl.
display_state([X|N]) :- write(X), nl, display_state(N).
