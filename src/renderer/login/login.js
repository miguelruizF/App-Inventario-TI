const form     = document.getElementById('loginForm')
const btnLogin = document.getElementById('btnLogin')
const errorMsg = document.getElementById('errorMsg')

function showError(msg) {
    errorMsg.textContent = msg
    errorMsg.classList.remove('hidden')
}

function hideError() {
    errorMsg.classList.add('hidden')
}

function setLoading(loading) {
    btnLogin.disabled    = loading
    btnLogin.textContent = loading ? 'Verificando...' : 'Iniciar sesión'
}

form.addEventListener('submit', async (e) => {
    e.preventDefault()
    hideError()

    const username = document.getElementById('username').value.trim()
    const password = document.getElementById('password').value

    if (!username || !password) {
        showError('Completa todos los campos')
        return
    }

    setLoading(true)

    const result = await window.api.auth.login({ username, password })

    if (!result.success) {
        showError(result.message)
        setLoading(false)
    }
    // Si success: true, el main process abre el dashboard y cierra esta ventana
})
