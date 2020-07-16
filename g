
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
        background: url("img/coffee_background.jpg");
        background-size: cover;
      }
      .container{
        background:rgb(0,0,0,.5);
      }
      .coffee-btn{
        width:3.5rem;
        height:3.5rem;
        background:Brown;
        cursor:pointer;
        border:2px solid DarkRed;
        box-shadow: 0 0 3px 3px rgba(0,0,0,0.5);
      }
      .coffee-btn:hover{
        background:maroon;
      }
      .coffee-btn:active{
        background:rgb(75, 0, 0);
        box-shadow:inset 0 0 3px 3px rgba(0,0,0,0.5);
      }
      .coffee-btn-group{
        width:90%;
        background:LightSlateGrey;
        border-radius:1.75rem 0 0 1.75rem;
      }
      .coffee-btn-group > span {
        color:white;
        font-size:1.5rem;
        margin-top:0.25rem;
      }
      #display{
        width:90%;
        border:5px groove black;
        background:Navy;
        color:white;
        padding:1rem;
      }
      img[src$="0rub.jpg"]:hover{
        cursor:pointer;
        filter: contrast(150%);
      }
      #field_for_change{
        height:11rem;
        background:LightSalmon;
        border:3px solid black;
      }
      img[src$="rub.png"]{
        width:70px;
        position:absolute;
      }
      img[src$="rub.png"]:hover{
        cursor:pointer;
        filter: contrast(150%);
      }
      .mug-coffee{
        position:absolute;
        left:0;
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
          <div class="coffee-btn-group row my-3">
            <div class="rounded-circle coffee-btn mr-3" onclick="getCoffee('Капучино',56)"></div>
            <span>Капучино - 56р.</span>
          </div>
          <div class="coffee-btn-group row my-3">
            <div class="rounded-circle coffee-btn mr-3" onclick="getCoffee('Латте',48)"></div>
            <span>Латте - 48р.</span>
          </div>
          <div class="coffee-btn-group row my-3">
            <div class="rounded-circle coffee-btn mr-3" onclick="getCoffee('Гляссе',87)"></div>
            <span>Гляссе - 87р.</span>
          </div>
          <div class="coffee-btn-group row my-3">
            <div class="rounded-circle coffee-btn mr-3" onclick="getCoffee('Эспрессо',43)"></div>
            <span>Эспрессо - 43р.</span>
          </div>
          <div class="coffee-btn-group row my-3">
            <div class="rounded-circle coffee-btn mr-3" onclick="getCoffee('Моккачино',61)"></div>
            <span>Моккачино - 61р.</span>
          </div>
        </div>
        <div class="col-6">
          <div class="row">
            <div class="col-6 text-center">
              <div id="display">
                <p id="display_text">Закажите кофе</p>
                <p id="display_balance"></p>
                <div class="progress" hidden>
                  <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
              <button class="mt-3 btn btn-warning" onclick="getChange(money.value)">Получить сдачу</button>
              <div class="col-12">
                <img src="img/coffee/mug_coffee_PNG_empty.png" class="mug-coffee" width="100%" alt="">
                <img src="img/coffee/mug_coffee_PNG.png" class="mug-coffee" width="100%" style="opacity:0;" alt="" id="mug_coffee">
              </div>
            </div>
            <div class="col-6">
              <input type="hidden" id="money">
              <img id="bill_acc" src="img/coffee/bill_acc.png" alt="">
              <div id="field_for_change" class="col-12 mt-3 p-0"></div>
            </div>
          </div>
        </div>
      </div>
      
      <img src="img/coffee/50rub.jpg"  data-value="50"  alt="">
      <img src="img/coffee/100rub.jpg" data-value="100" alt="">
      <img src="img/coffee/500rub.jpg" data-value="500" alt="">
    </div>
    
    <script>
      let bills = document.querySelectorAll('img[src$="0rub.jpg"]');
      let progressBar = document.getElementsByClassName('progress-bar')[0];
      function getCoffee(name,cost){
        if (cost <= money.value){
          getCoffee_audio.play();
          display_text.innerHTML = "Кофе "+ name +" готовится...";
          progressBar.parentElement.hidden = false;
          money.value -= cost;
          showBalance(money.value);
          let i = 0;
          let timerId = setInterval(()=>{
            i++;
            progressBar.style.width = i+"%";
            mug_coffee.style.opacity= i/100;
            if (i>110) {
              clearInterval(timerId);
              progressBar.parentElement.hidden = true;
              display_text.innerHTML = `Кофе ${name} готов`;
              i=0;
              progressBar.style.width = i+"%";}
          },100);
        }
        else
          display_text.innerHTML = "Недостаточно средств";
      }
      
      function getChange(num){
        let top = getRandom(0,field_for_change.offsetHeight-70);
        let left= getRandom(0,field_for_change.offsetWidth-70);
        if (num>=10){
          field_for_change.innerHTML += `<img style="top:${top}px;left:${left}px" onclick="this.hidden = true" src="img/coffee/10rub.png">`
          getChange(num-10);
        }else if (num>=5){
          field_for_change.innerHTML += `<img style="top:${top}px;left:${left}px" onclick="this.hidden = true" src="img/coffee/5rub.png">`
          getChange(num-5);
        }else if (num>=2){
          field_for_change.innerHTML += `<img style="top:${top}px;left:${left}px" onclick="this.hidden = true" src="img/coffee/2rub.png">`
          getChange(num-2);
        }else if (num==1){
          field_for_change.innerHTML += `<img style="top:${top}px;left:${left}px" onclick="this.hidden = true" src="img/coffee/1rub.png">`
        }
        getChange_audio.play();
        money.value = 0;
        showBalance(money.value);
      }
      
      function showBalance(n){
        display_balance.innerHTML = `Ваш баланс: ${n}руб.`
      }
      
      function getRandom(min,max){
        return Math.random()*(max-min)+min;
      }
      
      for (let i=0; i<bills.length; i++){
        bills[i].onmousedown = function(event){
          let bill = bills[i];
          bill.style.position = 'absolute';
          bill.style.transform = 'rotate(90deg)';
          moveAt(event.pageX, event.pageY);
          
          function moveAt(pageX, pageY) {
            bill.style.left = pageX - bill.offsetWidth / 2 + 'px';
            bill.style.top = pageY - bill.offsetHeight / 2 + 'px';
          }
          function onMouseMove(event) {
            moveAt(event.pageX, event.pageY);
          }
          
          document.addEventListener('mousemove', onMouseMove);
          
          bill.onmouseup = function() {
              document.removeEventListener('mousemove', onMouseMove);
              let bill_acc_top  = bill_acc.getBoundingClientRect().top; 
              let bill_acc_right= bill_acc.getBoundingClientRect().right;
              let bill_acc_left = bill_acc.getBoundingClientRect().left;
              let bill_acc_bottom=bill_acc.getBoundingClientRect().bottom;
              let bill_acc_height=bill_acc.getBoundingClientRect().height;
              
              let bill_top = bill.getBoundingClientRect().top;
              let bill_right=bill.getBoundingClientRect().right;
              let bill_left= bill.getBoundingClientRect().left;
              
              if (bill_top>bill_acc_top && bill_right<bill_acc_right && bill_left>bill_acc_left && bill_top<bill_acc_bottom-(bill_acc_height/3)){
                bill.hidden = true;
                money.value = +money.value + +bill.dataset.value;
                showBalance(money.value);
              }
              
              bill.onmouseup = null;
          };
        }
        bills[i].ondragstart = function() {
          return false;
        };
      }
      
      mug_coffee.onclick = function(){
        if(this.style.opacity >= 1){
          this.style.opacity = 0;
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
