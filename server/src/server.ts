//Back end sera uma API RESTFUl
import fastify from "fastify";
import cors from '@fastify/cors'
import { appRoutes } from "./routes";


const app = fastify();


app.register(cors, {
  origin: ['https://localhost:3333']
})

app.register(appRoutes)

app.listen({
  port:3333,
}).then(() => {
  console.log("SERVER RUNNING!");
});

