﻿% Copyright

implement main
    open core, file, stdio

domains = Европа; Южная Америка; Северная Америка; Африка; Азия.

class facts - country
    государство : (integer ID_страны, string Название_Страны, string Часть_Света, integer Население_Страны).
    столица : (integer ID_столицы, string Название_Столицы, integer Население_Столицы).
    представляет : (integer ID_страны, integer ID_столицы).
    глава : (integer ID_главы, string Имя, integer Возраст, integer ID_страны).
    валюта : (integer ID_страны, string Название_Валюты, integer ID_страны).
    язык : (integer ID_языка, string Название_Языка).
    говорят_на : (integer ID_языка, integer ID_страны).
    оружие : (integer ID_оружия, string Наличие).
    ядерное_оружие_наличие : (integer ID_оружия, integer ID_страны).
    площадь : (integer ID_страны, string Площадь).

class facts
    s : (real Sum) single.

clauses
    s(0).

class predicates
    генерация_столиц_для_заданной_части_света : (string Часть_Света) nondeterm.
    кто_правит_и_столица_заданного_государства : (string Название_Страны) nondeterm.
    площадь_население_плотность : (string Название_Страны) nondeterm.
    количество_стран_с_ядерным_оружием : (sring Наличие) nondeterm.

% ГЕНЕРАЦИЯ СТОЛИЦ(Ы) ДЛЯ ЗАДАННОЙ ЧАСТИ СВЕТА
    генерация_столиц_для_заданной_части_света(ЧС) :-
        государство(ID_Г, _, ЧС, _),
        столица(ID_С, НС, _),
        представляет(ID_Г, ID_С),
        write("Часть света ", ЧС, " и  столица: ", НС),
        nl,
        fail.
    генерация_столиц_для_заданной_части_света(ЧС) :-
        государство(_, _, ЧС, _),
        write("\n"),
        nl.

% КТО ПРАВИТ И СТОЛИЦА ЗАДАННОГО ГОСУДАРСТВА
    кто_правит_и_столица_заданного_государства(НГ) :-
	  государство(ID_Г, НГ, _, _),
	  столица(ID_С, НС, _),
	  представляет(ID_Г, ID_С),
	  глава(_, ИМЯ, _, ID_Г),
	  write(ИМЯ, " правит ", НГ, ", а столица", НС),
	  nl,
	  fail.
    кто_правит_и_столица_заданного_государства(НГ) :-
	  государство(_, НГ, _, _),
	  write("\n"),
        nl.

% ПЛОЩАДЬ, НАСЕЛЕНИЕ И РАСЧЁТ ПЛОТНОСТИ НАСЕЛЕНИЯ (чел/площ) ЗАДАННОГО ГОСУДАРСТВА
    площадь_население_плотность(НГ) :-
	  государство(ID_Г, НГ, _, НасС),
	  площадь(ID_Г, П),
	  write(НГ, " население: ", НасС, ", площадь: ", П, ", плотность: ", НасС/П),
	  nl,
	  fail.
    площадь_население_плотность(НГ) :-
	  государство(_, НГ, _, _),
	  write("\n"),
        nl.    

% КОЛИЧЕСТВО СТРАН, У КОТОРЫХ ЕСТЬ ЯДЕРНОЕ ОРУЖИЕ
    количество_стран_с_ядерным_оружием(ЯО) :-
	  оружие : (ID_ЯО, ЯО),
   	  ядерное_оружие_наличие : (ID_ЯО, _),
	  s(Sum),
        assert(s(Sum + 1)),
	  fail.
    количество_стран_с_ядерным_оружием(ЯО) :-
        оружие : (_, ЯО),
        s(Sum),
        write(Sum, "\n"),
        nl.
    количество_стран_с_ядерным_оружием(ЯО) :-
	  оружие : (_, ЯО),
	  write("\n"),
        nl. 

    run() :-
        console::init(),
        reconsult("..\\countr.txt", country),
        write("Правило: ГЕНЕРАЦИЯ СТОЛИЦ(Ы) ДЛЯ ЗАДАННОЙ ЧАСТИ СВЕТА\n"),
        генерация_столиц_для_заданной_части_света("Африка"),
        fail.

    run() :-
        console::init(),
        reconsult("..\\countr.txt", country),
        write("Правило: КТО ПРАВИТ И СТОЛИЦА ЗАДАННОГО ГОСУДАРСТВА\n"),
        кто_правит_и_столица_заданного_государства("Япония"),
        fail.

    % ПЛОЩАДЬ, НАСЕЛЕНИЕ И РАСЧЁТ ПЛОТНОСТИ НАСЕЛЕНИЯ (чел/площ) ЗАДАННОГО ГОСУДАРСТВА
    run() :-
        console::init(),
        reconsult("..\\countr.txt", country),
        stdio::write("Введите название государства: "),
        X = stdio::read(),
        площадь_население_плотность(X),
        fail.

    run() :-
        console::init(),
        reconsult("..\\countr.txt", country),
        write("Правило: КОЛИЧЕСТВО СТРАН, У КОТОРЫХ ЕСТЬ ЯДЕРНОЕ ОРУЖИЕ\n"),
        количество_стран_с_ядерным_оружием("Есть ядерное оружие"),
        fail.

    run() :-
        succeed.

end implement main

goal
    console::run(main::run).	
		
