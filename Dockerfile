FROM node as gatsby-build

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

RUN apt-get update
RUN apt-get -y install libglu1
RUN apt-get -y install libxi6 libgconf-2-4
RUN ldconfig

COPY ./package.json ./

RUN npm install

COPY . .

RUN npm run build

FROM socialengine/nginx-spa as server

COPY --from=gatsby-build /home/node/app/public ./app