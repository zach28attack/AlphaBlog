// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

// add button modal to articles
const articles = document.querySelectorAll(".article");

articles.forEach((article) => {
  article.addEventListener("mouseover", () => {
    const buttonModal = article.querySelector(".article-buttons");
    const [...modalParams] = article.querySelectorAll("#modal-param");
    buttonModal.classList.remove("hidden");
    buttonModal.classList.add("modal");
    buttonModal.classList.add("show");
    modalParams.forEach((modalParam) => {
      modalParam.classList.add("modal-param");
    });

    article.addEventListener("mouseout", () => {
      const buttonModal = article.querySelector(".article-buttons");
      buttonModal.classList.add("hidden");
      buttonModal.classList.remove("modal");
      buttonModal.classList.remove("show");
      modalParams.map((modalParam) => {
        modalParam.classList.remove("modal-param");
      });
    });
  });
});

const userSettingsTrigger = document.querySelector("#settings-dropdown-toggle");
const buttons = document.querySelector(".user-buttons");
if (userSettingsTrigger) {
  userSettingsTrigger.addEventListener("click", () => {
    if (buttons.classList.contains("hidden")) {
      buttons.classList.remove("hidden");
    } else {
      buttons.classList.add("hidden");
    }
  });
}

const userCards = document.querySelectorAll(".user-grid-cell");
userCards.forEach((userCard) => {
  userCard.addEventListener("mouseover", (e) => {
    if (e.target.closest(".user-grid-cell") === userCard) {
      userCard.style.position = "relative";
      userCard.style.zIndex = "100";
      userCard.style.transform = "scale(1.5)";

      userCard.addEventListener("mouseout", (e) => {
        if (e.target.closest(".user-grid-cell") === userCard) {
          userCard.style.transform = "scale(1)";
          userCard.style.zIndex = "0";
          userCard.style.position = "";
        }
      });
    }
  });
});

const userFormToggle = document.querySelector("#user-form-toggle");
const userForm = document.querySelector(".user-form");
const showUserForm = (e) => {
  e.preventDefault();
  userForm.classList.toggle("hidden");
  userForm.classList.add("user-dropdown");
};
const sessionFormToggle = document.querySelector("#session-form-toggle");
const sessionForm = document.querySelector("#session-form");
const showSessionForm = (e) => {
  e.preventDefault();
  sessionForm.classList.toggle("hidden");
  sessionForm.classList.add("user-dropdown");
};

userFormToggle.addEventListener("click", (e) => {
  showUserForm(e);
  if (!sessionForm.classList.contains("hidden")) {
    sessionForm.classList.add("hidden");
  }
});

sessionFormToggle.addEventListener("click", (e) => {
  showSessionForm(e);
  if (!userForm.classList.contains("hidden")) {
    userForm.classList.add("hidden");
  }
});
