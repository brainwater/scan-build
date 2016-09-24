: RUN: intercept-build -vvv --override-compiler --cdb %t.json.wrapper %s
: RUN: cdb_diff %t.json.wrapper %T\successful_build.json.expected

set output="%test_output_dir%\successful_build.json.expected"
del /f %output%

cd "%test_input_dir%"
%CC%  -c -o "%test_output_dir%\main.o" main.c
cdb_expect ^
    --cdb %output% ^
    --command "cc -c -o %test_output_dir%\main.o main.c" ^
    --file "%test_input_dir%\main.c"

cd "%test_input_dir%\clean"
%CC%  -c -o "%test_output_dir%\clean_one.o" -Iinclude one.c
cdb_expect ^
    --cdb %output% ^
    --command "cc -c -o %test_output_dir%\clean_one.o -Iinclude one.c" ^
    --file "%test_input_dir%\clean\one.c"

cd "%test_input_dir%"
%CXX% -c -o "%test_output_dir%\clean_two.o" -I .\clean\include clean\two.c
cdb_expect ^
    --cdb %output% ^
    --command "cc -c -o %test_output_dir%\clean_two.o -I .\clean\include clean\two.c" ^
    --file "%test_input_dir%\clean\two.c"

cd "%test_input_dir%\dirty"
%CC%  -c -o "%test_output_dir%\dirty_one.o" -Wall one.c
cdb_expect ^
    --cdb %output% ^
    --command "cc -c -o %test_output_dir%\dirty_one.o -Wall one.c" ^
    --file "%test_input_dir%\dirty\one.c"

cd "%test_input_dir%"
%CXX% -c -o "%test_output_dir%\dirty_two.o" -Wall dirty\two.c
cdb_expect ^
    --cdb %output% ^
    --command "cc -c -o %test_output_dir%\dirty_two.o -Wall dirty\two.c" ^
    --file "%test_input_dir%\dirty\two.c"