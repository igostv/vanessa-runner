# language: ru

Функционал: Обновление конфигурации базы данных
    Как разработчик
    Я хочу иметь возможность обновить базу данных
    Чтобы отдельно загружать конфигурацию и потом обновлять ее

Контекст: Подготовка репозитория и рабочего каталога проекта 1С
    Допустим  я включаю отладку лога с именем "oscript.app.vanessa-runner"
    И Я очищаю параметры команды "oscript" в контексте

    Допустим Я создаю временный каталог и сохраняю его в контекст
    И Я устанавливаю временный каталог как рабочий каталог
    И Я инициализирую репозиторий git в рабочем каталоге
    Допустим Я создаю каталог "build/out" в рабочем каталоге
    И Я копирую каталог "cf" из каталога "tests/fixtures" проекта в рабочий каталог

    И Я установил рабочий каталог как текущий каталог

Сценарий: Обновление dev базы по умолчанию в ./build/ibservice
    Когда Я сохраняю каталог проекта в контекст
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os init-dev --src ./cf --nocacheuse --dev --language ru"
    И Я очищаю параметры команды "oscript" в контексте

    Тогда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os updatedb --ibconnection /F./build/ibservice --uccode test --language ru"
    И Я сообщаю вывод команды "oscript"
    Тогда Вывод команды "oscript" содержит "Обновление конфигурации базы данных успешно завершено"
    И Код возврата команды "oscript" равен 0

Сценарий: Обновление dev-базы ./build/ibservice на сервере в режиме реструктуризации -v2
    Когда Я сохраняю каталог проекта в контекст
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os init-dev --src ./cf --nocacheuse --dev --language ru"
    И Я очищаю параметры команды "oscript" в контексте

    Тогда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os updatedb --ibconnection /F./build/ibservice --uccode test --v2 --language ru"
    И Я сообщаю вывод команды "oscript"
    Тогда Вывод команды "oscript" содержит "Обновление конфигурации базы данных успешно завершено"
    И Код возврата команды "oscript" равен 0
