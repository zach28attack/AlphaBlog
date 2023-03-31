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

  //listen for form submission
  const userFormSubmit = userForm.querySelector("input[type=submit]");
  userFormSubmit.addEventListener("click", (e) => {
    //grab form
    const userFormById = document.querySelector("#user-form");
    // if any field is blank
    if (!userFormById.checkValidity()) {
      userFormById.reportValidity();
      e.preventDefault();
    }
    //add error messages to username
    const userFormUsername = userForm.querySelector("#user_username").value;
    const usernameError = document.querySelector("#username-error");
    console.log(userFormUsername.length);
    if (userFormUsername.length < 3 || userFormUsername.length > 15) {
      usernameError.innerHTML =
        "<span>*</span>must be between 3 and 15 characters";
    } else {
      usernameError.innerHTML = "";
    }

    //add error messages to password
    const userFormPassword = userForm.querySelector("#user_password").value;
    const userPasswordError = document.querySelector("#password-error");
    console.log(userFormPassword.length);
    if (userFormPassword.length < 6 || userFormPassword.length > 20) {
      userPasswordError.innerHTML =
        "<span>*</span>must be between 6 and 20 characters";
    } else {
      userPasswordError.innerHTML = "";
    }
  });

  //remove login form if displayed
  if (!sessionForm.classList.contains("hidden")) {
    sessionForm.classList.add("hidden");
  }
});

sessionFormToggle.addEventListener("click", (e) => {
  showSessionForm(e);

  const sessionFormSubmit = sessionForm.querySelector("input[type=submit]");
  sessionFormSubmit.addEventListener("click", () => {
    //grab form
    const sessionFormById = document.querySelector("#session-form");
    // if any field is blank
    if (!sessionFormById.checkValidity()) {
      sessionFormById.reportValidity();
      e.preventDefault();
    }
  });
  //remove signup form if displayed
  if (!userForm.classList.contains("hidden")) {
    userForm.classList.add("hidden");
  }
});
