const { contextBridge, ipcRenderer } = require('electron')

/**
 * Expone APIs seguras al proceso renderer a través de contextBridge.
 * El renderer accede a estas funciones mediante window.api.*
 */
contextBridge.exposeInMainWorld('api', {

    auth: {
        login:  (credentials) => ipcRenderer.invoke('auth:login',  credentials),
        logout: ()            => ipcRenderer.invoke('auth:logout')
    }

})
