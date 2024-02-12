importScripts('https://www.gstatic.com/firebasejs/8.6.8/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.6.8/firebase-messaging.js');

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;

firebase.initializeApp({
    apiKey: 'AIzaSyC0Ya02B345ngAvH6bkpW2Dr1MDIkt7BBU',
    appId: '1:1053702216845:web:480764af63312c9b6f96c4',
    messagingSenderId: '1053702216845',
    projectId: 'rexwebmedia',
    databaseURL: 'https://rexwebmedia.firebaseio.com',
    storageBucket: 'rexwebmedia.appspot.com',
    authDomain: 'rexwebmedia.firebaseapp.com',
    measurementId: 'G-9TETJ7LCD7',
});

const messaging = firebase.messaging();
messaging.usePublicVapidKey('BMcP2WWC5k5pY8Nqx0_-rwFK27uwU9PmLPa7KQqn5OHWxpf9rPTq0X6iVDiH4AScoy5p8DY0FgFkjGgNB6OMpOE');
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: 'window',
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification('New Message');
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});
// messaging.onMessage((payload) => {
//     console.log('Message received. ', payload);
//     // ...
// });