<!doctype html>
<html lang="ru">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

    <title>Кофемашина</title>
    <style>
      body{
        background: url("img/coffee_machine/coffee.jpg"); /*выводим на эран изображение*/
        background-size:cover; /* масштабирование изображения с сохранением пропорций (ширина и высота = высота и ширина блока) */
      }
      .container{
        border-radius:20px;
        background:rgb(0,0,0,0.6);
      }
      .coffee-btn{
        width:3.5rem;
        height:3.5rem;
        background:#EA4747;
        cursor:pointer;
        border:2px solid DarkRed;
        box-shadow: 0 0 3px 3px rgb(0,0,0,0.5);
      }
      .coffee-btn:hover{
        background:	#BF3838;
      }
      .coffee-btn:active{
        background:rgb(75, 0, 0);
        box-shadow:inset 0 0 3px rgb(0,0,0,0.5);
      }
      .coffee-btn-group{
        width:90%;
        background:LightSlateGrey;
        border-radius:1.75rem 1.75rem 1.75rem 1.75rem;
        box-shadow:inset 4px 4px 7px rgb(0,0,0,0.5); 
       }
      .coffee-btn-group > span{
        color:white;
        font-size:1.5rem;
        margin-top:0.5rem;
      }
      #display{
        width:100%;
        border:3px dotted black;
        background:#CCCCFF;
        color:black;
        margin-top:15px;
        height:10rem;
        padding:0.5rem;
      }
      #money{
        width:100%;
        margin-top:15px;
      }
      img[src$="0rub.jpg"]:hover{
        cursor:pointer;
        filter: contrast(150%);
      }
      #field_for_change{
        height:11rem;
        background:#FFEA73;
        border:2px solid yellow;
      }
      img[src$="rub.png"]{
        width:50px;
        position:absolute;
      }
      img[src$="rub.png"]:hover{
        cursor:pointer;
        filter: contrast(150%);
      }
      .mug-coffee{
        position:absolute;
        left:center;
        top:0;
      }
      .mug-coffee:hover{
        cursor:pointer;
        filter: contrast(150%);
      }
    </style>
  </head>
  <body>
    <audio src="audio/getCoffee_audio.mp3" id="getCoffee_audio"></audio>
    <audio src="audio/getChange_audio.mp3" id="getChange_audio"></audio>
    <div class="container mt-5 p-3"> 
      <div class="row p-3">
        <div class="col-6">
          <div class="coffee-btn-group row my-3 p-0">
            <div class="rounded-circle coffee-btn mr-3" onclick="getCoffee('Каппучино', 56)"></div>
            <span>Каппучино - 56 руб.</span>
            </div>
          <div class="coffee-btn-group row my-3 p-0">
            <div class="rounded-circle coffee-btn mr-3" onclick="getCoffee('Латте', 48)"></div>
            <span>Латте - 48 руб.</span>
          </div>
          <div class="coffee-btn-group row my-3 p-0">
            <div class="rounded-circle coffee-btn mr-3" onclick="getCoffee('Гляссе', 87)"></div>
            <span>Гляссе - 87 руб.</span>
          </div>
          <div class="coffee-btn-group row my-3 p-0">
            <div class="rounded-circle coffee-btn mr-3" onclick="getCoffee('Эспрессо', 43)"></div>
            <span>Эспрессоо - 43 руб.</span>
          </div>
          <div class="coffee-btn-group row my-3 p-0">
            <div class="rounded-circle coffee-btn mr-3" onclick="getCoffee('Моккачино',61)"></div>
            <span>Моккачино - 61 руб.</span>
          </div>
        </div>
        <div class="col-6">
          <div class="row">
            <div class="col-6 p-0">
              <div id="display">
                <p id="display_text">Закажите кофе</p>
                <p id="display_balance"></p>
                <div class="progress" hidden>
                  <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
              <button class="mt-3 btn btn-warning btn-block" onclick="getChange(money.value)">Получить сдачу</button>
              <div class="col-12 mt-2">
                <img src="img/coffee_machine/mug_coffee_PNG_empty.png" class="mug-coffee" width="80%" alt="">
                <img src="img/coffee_machine/mug_coffee_PNG.png" class="mug-coffee" width="80%" style="opacity:0;" alt="" id="mug_coffee">
              </div>
            </div>
            <div class="col-6 p-3 text-center">
              <input type="hidden" id="money"> 
              <img id="bill_acc" src="img/coffee_machine/bill_acc.png" alt="">
              <div id="field_for_change" class="col-12 mt-3"></div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-12 text-center">
        <img src="img/coffee_machine/money_PNG.png" style="margin-right:30px" alt="">
        <img src="img/coffee_machine/50rub.jpg" data-value = "50" alt="">
        <img src="img/coffee_machine/100rub.jpg" data-value = "100" alt="">
        <img src="img/coffee_machine/500rub.jpg" data-value = "500" alt="">
      </div>
    </div>

    <script>
      let bills = document.querySelectorAll('img[src$="0rub.jpg"]');          //* 
      let progressBar = document.getElementsByClassName('progress-bar')[0];   //* 
      function getCoffee(name,cost){                                          //* 
        if (cost <= money.value){                                             //* 
          getCoffee_audio.play();                                             //* 
          display_text.innerHTML = `Кофе ${name} готовится...`;               //* 
          progressBar.parentElement.hidden = false;                           //* 
          money.value -= cost;                                                //* 
          showBalance(money.value);                                           //* 
          let i = 0;
          let timerId = setInterval(()=>{                                     //* 
            i++;
            progressBar.style.width = i+"%";                                  //* 
            mug_coffee.style.opacity= i/100;                                  //* 
            if (i > 110){
              clearInterval(timerId);                                         //* 
              progressBar.parentElement.hidden = true;                        //* 
              display_text.innerHTML = `Кофе ${name} готов`;                  //* 
              i = 0;
              progressBar.style.width = i+"%";}                               //* 
          },100);
        }
        else
          display_text.innerHTML = "Недостаточно средств";                    //* Получение HTML-содержимого элемента в виде строки
      }
      
      function getChange(num){                                                //* Функция "выжать сдачу"
        let top = getRandom(0,field_for_change.offsetHeight-50);              //* Вызываем функцию и вычисляем поле, в котором рандомно падают монеты
        let left = getRandom(0,field_for_change.offsetWidth-50);              //* Вызываем функцию и вычисляем поле, в котором рандомно падают монеты
        if (num >= 10) {
          field_for_change.innerHTML += `<img style="top:${top}px; left:${left}px" onclick="this.hidden = true" src="img/coffee_machine/10rub.png">`  //* Получение HTML-содержимого элемента в виде строки, top и left задают случайное расположение
          getChange(num-10);
        }else if (num >= 5){
          field_for_change.innerHTML += `<img style="top:${top}px; left:${left}px" onclick="this.hidden = true" src="img/coffee_machine/5rub.png">`   //* Получение HTML-содержимого элемента в виде строки, top и left задают случайное расположение
          getChange(num-5);
        }else if (num >= 2){
          field_for_change.innerHTML += `<img style="top:${top}px; left:${left}px" onclick="this.hidden = true" src="img/coffee_machine/2rub.png">`   //* Получение HTML-содержимого элемента в виде строки, top и left задают случайное расположение
          getChange(num-2);
        }else if (num == 1){
          field_for_change.innerHTML += `<img style="top:${top}px; left:${left}px" onclick="this.hidden = true" src="img/coffee_machine/1rub.png">`   //* Получение HTML-содержимого элемента в виде строки, top и left задают случайное расположение
        }
        getChange_audio.play();                                               //* После нажатия появляется звук
        money.value = 0;                                                      //* Обнуляем после выдачи сдачи
        showBalance(money.value);                                             //* Показываем баланс
      }
      
      function showBalance(n){                                                
        display_balance.innerHTML = `Ваш баланс: ${n}руб.`;                   //* Получение HTML-содержимого элемента в виде строки
      }
      
      function getRandom(min,max){                                            //* Функция "генерировать псевдослучайное число"
        return Math.random()*(max-min)+min;                                   //* Возвравращает псевдослучайное число с плавающей запятой из диапазона [0,1}
      }
      
      for (let i = 0; i < bills.length; i++){                            
        bills[i].onmousedown = function(event){                               //* Устанавливаем для массива (купюр) событие "mousedown", которое готовит элемент к перемещению и задаем функцию события для уточнения деталей
          let bill = bills[i];                                                //* Устанавливаем переменную для каждого знаечния массива
          bill.style.position = 'absolute';                                   //* Для каждого элемента (купюры) устанавливаем способ позиционарирования элемента на веб-странице. "absolute" устанавливает позиционирование элемента поверх объектов на странице. Т.к. родительский элемент позиционируется как "static", то отсчет координат ведется от края окна браузера.
          bill.style.transform = 'rotate(90deg)';                             //* Трансформирует элемент, в частности позволяет масштабировать, вращать, сдвигать, наклонять, а также комбинировать виды трансформаций.
          
          moveAt(event.pageX, event.pageY);                                   //* Событие moveAt устанавливает элемент под курсор мыши
          
          function moveAt(pageX, pageY){                                      //* Функция moveAt передвигает элемент под координаты курсора
            bill.style.left = pageX - bill.offsetWidth / 2 + 'px';            //* Передвигаем элемент под курсор на половину его длины, чтобы отцентрировать
            bill.style.top = pageY - bill.offsetHeight / 2 + 'px';            //* Передвигаем элемент под курсор на половину его высоты, чтобы отцентрировать
          }
          
          function onMouseMove(event){                                        //* Задаем функцию движения мыши по странице и аргумент "event" для уточнения деталей
            moveAt(event.pageX, event.pageY);                                 //* Устанавливаем moveAt, чтобы элемент был под курсором и двигался вмесе с ним
          }
          
          document.addEventListener('mousemove', onMouseMove);                //* Задаем обработчика для перемешения элемента по экрану
          
         bill.onmouseup = function(){                                         //* Задаем функцию при поднятии конопки мыши
          document.removeEventListener('mousemove', onMouseMove);             //* Задаем обработчик при движении мыши по экрану
            let bill_acc_top  = bill_acc.getBoundingClientRect().top;         //* Метод возвращает размер элемента и его позицию относительно верхней границы браузера до верхней границы элемента
            let bill_acc_right = bill_acc.getBoundingClientRect().right;      //* Метод возвращает размер элемента и его позицию относительно левой границы браузера до правой границы элемента
            let bill_acc_left  = bill_acc.getBoundingClientRect().left;       //* Метод возвращает размер элемента и его позицию относительно левой границы браузера до левой границы элемента
            let bill_acc_bottom = bill_acc.getBoundingClientRect().bottom;    //* Метод возвращает размер элемента и его позицию относительно верхней границы браузера до нижней границы элемента
            let bill_acc_height = bill_acc.getBoundingClientRect().height;    //* Метод возвращает размер элемента и его позицию по высоте (для вычисления необходимой области\границы)
              
            let bill_top = bill.getBoundingClientRect().top;                  //* Метод возвращает размер элемента и его позицию относительно верхней границы браузера до верхней границы элемента
            let bill_right=bill.getBoundingClientRect().right;                //* Метод возвращает размер элемента и его позицию относительно левой границы браузера до правой границы элемента
            let bill_left= bill.getBoundingClientRect().left;                 //* Метод возвращает размер элемента и его позицию относительно левой границы браузера до левой границы элемента
            
            if (bill_top > bill_acc_top                                       //* Задаем условие при котором элемент будет исчезать (сверху)
              && bill_right < bill_acc_right                                  //* Задаем условие при котором элемент будет исчезать (справа)
              && bill_left > bill_acc_left                                    //* Задаем условие при котором элемент будет исчезать (слева)
              && bill_top < bill_acc_bottom-2*(bill_acc_height/3)){           //* Задаем условие при котором элемент будет исчезать (снизу)
              bill.hidden = true;                                             //* Элемент становится невидимым
              money.value = +money.value + +bill.dataset.value;               //* Отображение значения атрибута
              showBalance(money.value);                                       //* Показывает общий баланс
            }
            bill.onmouseup = null;                                            //* Обнуляем для оптимизации процессов
          };
        }
        bills[i].ondragstart = function(){                                    //* Отключаем встроенный Drag'n'Drop для изображений, чтобы избежать конфликта с заданными нами функциями перемещения элементов
          return false;                                                       //* 
        };
      }
      
      mug_coffee.onclick = function(){                                        //* Задаем функцию при клике мышкой на полную чашку, чтобы ее "забрать"
        if (this.style.opacity >=1){                                          //* Непрозрачная
          this.style.opacity = 0;                                             //* Прозрачная
        }
      }
    </script>


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  </body>
</html>
