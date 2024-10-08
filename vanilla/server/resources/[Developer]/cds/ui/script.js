const buttonClose = document.getElementById("btn-close");
const buttonCopy = document.getElementById("btn-copy");
const containercoords = document.querySelector(".container-coords");
const popup = document.getElementById('popup');

window.addEventListener("message", (event) => {
  const coords = document.getElementById("coords");
  if (event.data.open == true) {
    containercoords.style.display = "flex";
    coords.innerText = `${event.data.x}, ${event.data.y}, ${event.data.z}`;
  }
});

buttonClose.addEventListener("click", () => {
  closePopup();
});

document.addEventListener("keydown", (event) => {
  if (event.key === "Escape") {
    closePopup();
  }
});

function closePopup() {
  const coords = document.getElementById("coords");
  fetch(`https://${GetParentResourceName()}/closeCopy`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify({
      coords: coords.innerText,
    }),
  }).then((resp) => resp.json());

  containercoords.style.display = "none";
  var copyMessage = document.getElementById('copy-message');
  copyMessage.style.display = 'none';
}

buttonCopy.addEventListener("click", () => {
  const coords = document.getElementById("coords").innerText;

  const tempInput = document.createElement("input");
  tempInput.value = coords;
  document.body.appendChild(tempInput);
  tempInput.select();
  document.execCommand("copy");
  document.body.removeChild(tempInput);
  var copyMessage = document.getElementById('copy-message');
  copyMessage.style.display = 'inline-block';

  var copyMessage = document.getElementById('copy-message');
  copyMessage.style.display = 'inline-block';
   
  setTimeout(function() {
    copyMessage.style.display = 'none';
  }, 2000);
});

