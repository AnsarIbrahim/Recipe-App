// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

function toggleMenu() {
  const menu = document.getElementById("navbarSupportedContent9");
  const hamburgerButton = document.querySelector(".hamburger-button");
  const closeBtn = document.querySelector(".close-button");

  if (
    menu.style.display === "block" ||
    getComputedStyle(menu).display === "block"
  ) {
    menu.style.display = "none";
    hamburgerButton.style.display = "block";
    closeBtn.style.display = "none";
  } else {
    menu.style.display = "block";
    hamburgerButton.style.display = "none";
    closeBtn.style.display = "block";
  }
}

function closeMenu() {
  const menu = document.getElementById("navbarSupportedContent9");
  const hamburgerButton = document.querySelector(".hamburger-button");
  const closeBtn = document.querySelector(".close-button");

  menu.style.display = "none";
  hamburgerButton.style.display = "block";
  closeBtn.style.display = "none";
}

document.addEventListener("turbo:load", function () {
  const hamburgerButton = document.querySelector(".hamburger-button");
  if (hamburgerButton) {
    hamburgerButton.addEventListener("click", toggleMenu);
  }

  const closeBtn = document.querySelector(".close-button");
  if (closeBtn) {
    closeBtn.addEventListener("click", closeMenu);
  }

  const openPopupButton = document.getElementById("open-popup");
  const recipePopup = document.getElementById("recipe-popup");

  openPopupButton.addEventListener("click", function () {
    recipePopup.classList.remove("hidden");
    toggleMenu();
  });
});

document.addEventListener("turbo:load", function () {
  const openPopupButton = document.getElementById("open-popup");
  const recipePopup = document.getElementById("recipe-popup");

  openPopupButton.addEventListener("click", function () {
    recipePopup.classList.remove("hidden");
    toggleMenu(); // Call this function to close the menu when opening the popup
  });

  const closePopupButton = document.getElementById("close-popup");

  closePopupButton.addEventListener("click", function () {
    recipePopup.classList.add("hidden");
    closeMenu(); // Call this function to close the menu when closing the popup
  });
});
