FROM node as build

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

COPY ./package*.json ./

RUN yarn

COPY . .

RUN yarn build

FROM socialengine/nginx-spa as server

COPY --from=build build/ /app