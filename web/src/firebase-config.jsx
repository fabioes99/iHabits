import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth"

const firebaseConfig = {
  apiKey: "AIzaSyB9kbpckJ7a5GojL4mIYHJl4E4JD9_BN8M",
  authDomain: "auth-tg-79ec8.firebaseapp.com",
  projectId: "auth-tg-79ec8",
  storageBucket: "auth-tg-79ec8.appspot.com",
  messagingSenderId: "723854990288",
  appId: "1:723854990288:web:a640a5b7f010e3114277d5"
};

const app = initializeApp(firebaseConfig);

export const auth = getAuth(app);
