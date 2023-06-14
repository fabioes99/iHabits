import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth"

const firebaseConfig = {
  apiKey: "AIzaSyDqwweBDIvoKHGqRQ-jAr1G5hizkE7iXD4",
  authDomain: "ihealth-ad8cb.firebaseapp.com",
  projectId: "ihealth-ad8cb",
  storageBucket: "ihealth-ad8cb.appspot.com",
  messagingSenderId: "344196458545",
  appId: "1:344196458545:web:dcefb29f541a1257128d10",
  measurementId: "G-MNC7X516DK"
};

const app = initializeApp(firebaseConfig);

export const auth = getAuth(app);
