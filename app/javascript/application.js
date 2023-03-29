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
userSettingsTrigger.addEventListener("click", () => {
  if (buttons.classList.contains("hidden")) {
    buttons.classList.remove("hidden");
  } else {
    buttons.classList.add("hidden");
  }
});
