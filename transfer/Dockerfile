FROM node:alpine
LABEL Name="transfer"
LABEL Version="1.0.1"
WORKDIR /usr/src/app
COPY package.json server.js ./
RUN npm config set strict-ssl false
RUN npm install
EXPOSE 8081
CMD ["node", "server.js"]
