% Copyright

implement main
    open core, stdio

domains 
    стран_кон = стран_кон(string Часть_Света, string СТРАНА).
    правители_на_континенте = правители_на_континенте(string Часть_Света, string Имя).

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
    континент : (integer ID_часть_света, string Часть_Света, integer Площадь_Континента, integer Население_Континента).
    находится_на_континенте : (integer ID_страны, integer ID_часть_света).
    крупнейший_континент : (integer ID_часть_света, string Название_Страны).
    страна_с_населением_более_100млн : (string Название_Страны).

calss predicates %Вспомогательные предикаты
    длина : (A*) -> integer N.
    сумма_элем : (real* List) -> real Sum.
    среднее_списка : (real* List) -> real Average determ.

clauses
    длина([]) = 0.
    длина([_ | T]) = длина(T) + 1.

    сумма_элем([]) = 0.
    сумма_элем([H | T]) = сумма_элем(T) + H.

    среднее_списка(L) = сумма_элем(L) / длина(L) :-
        длина(L) > 0.

class predicates %Основные предикаты2	
    страны_на_континенте: (string Часть_Света) -> string* СТРАНЫ determ.
    колич_стран_на_континенте: (string Часть_Света) -> integer N determ.

clauses
    СТРАНЫ(X) = Ccount :-
        государство(N,_, X, _),
        !,
        Ccount =
            [ NameCo ||
                государство(N,NameCo, _, _),
            ].

    колич_стран_на_континенте:(X) = длина(СТРАНЫ(X)).
    
class predicates %Вывод на экран стран на континенте   
    write_count_cont : (стран_кон* Страны_на_конт).

clauses
    write_count_cont(L) :-
        foreach стран_кон(NameЧСВТ, NameCo) = list::getMember_nd(L) do
            writef("\t%\t%\n", NameCo)
        end foreach.
clauses
    run() :-
        console::init(),
        file::consult("..\\kul.txt", kulinarDB),
        fail.
    run() :-
        succeed.
    run() :-
        X = "Азия",
        L = СТРАНЫ(X),
        write(L),
        write("\tКоличество стран на континенте = "),
        write(колич_стран_на_континенте(X)),
        nl,
        fail.

end implement main

goal
    console::run(main::run).	
		