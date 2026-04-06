//Logout
const btn_logout = document.getElementById("btn_logout");

btn_logout.addEventListener("click", async (e) => {
    await window.api.auth.logout()
    console.log('Logout solicitado')
});