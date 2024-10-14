FROM node:10-alpine
WORKDIR /app
COPY package.json package-lock.json /app/
RUN npm install
COPY . /app/
ENTRYPOINT [ "npm","start","app.js"]
