// Login Simulado
document.addEventListener("DOMContentLoaded", () => {
  const loginForm = document.getElementById("loginForm");
  if (loginForm) {
    loginForm.addEventListener("submit", async (e) => {
      e.preventDefault();
      const username = document.getElementById("username").value;
      const password = document.getElementById("password").value;

      const res = await fetch("users.json");
      const users = await res.json();

      const user = users.find(u => u.username === username && u.password === password);

      const status = document.getElementById("loginStatus");
      if (user) {
        localStorage.setItem("user", username);
        status.textContent = "Login bem-sucedido! 🎉";
        status.style.color = "green";
      } else {
        status.textContent = "Credenciais inválidas 😢";
        status.style.color = "red";
      }
    });
  }

  // Carregar Ementa
  const ementaContainer = document.getElementById("ementaContainer");
  if (ementaContainer) {
    fetch("ementa.json")
      .then(res => res.json())
      .then(data => {
        for (const categoria in data) {
          const section = document.createElement("section");
          const titulo = document.createElement("h2");
          titulo.textContent = categoria;
          section.appendChild(titulo);

          data[categoria].forEach(prato => {
            const card = document.createElement("div");
            card.className = "card";
            card.innerHTML = `<strong>${prato.nome}</strong><br>${prato.descricao}<br><em>${prato.preco}</em>`;
            section.appendChild(card);
          });

          ementaContainer.appendChild(section);
        }
      });
  }
});
// Alternar tema claro/escuro
const temaBtn = document.getElementById("temaBtn");
if (temaBtn) {
  const saved = localStorage.getItem("tema");
  if (saved === "dark") document.body.classList.add("dark");

  temaBtn.addEventListener("click", () => {
    document.body.classList.toggle("dark");
    localStorage.setItem("tema", document.body.classList.contains("dark") ? "dark" : "light");
  });
}

// Simular reserva
const reservaForm = document.getElementById("reservaForm");
if (reservaForm) {
  reservaForm.addEventListener("submit", e => {
    e.preventDefault();
    document.getElementById("reservaStatus").textContent = "Reserva enviada com sucesso! 🥳";
    reservaForm.reset();
  });
}

// Simular contacto
const contactoForm = document.getElementById("contactoForm");
if (contactoForm) {
  contactoForm.addEventListener("submit", e => {
    e.preventDefault();
    document.getElementById("contactoStatus").textContent = "Mensagem enviada! 📬";
    contactoForm.reset();
  });
}

