FROM node:14-slim AS modules

WORKDIR /app

COPY ./package*.json ./
RUN npm i
FROM modules AS app

WORKDIR /app

COPY . .

RUN npm run build 


CMD ["npm","run", "serve"]
