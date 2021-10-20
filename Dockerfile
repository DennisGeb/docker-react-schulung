# tagged as builder phase
FROM node:alpine as builder
     
WORKDIR /app

COPY ./package.json ./
RUN npm install

COPY ./ ./

RUN npm run build

# /app/build -> all important prod stuff

# assumes that previous block is already complete -> from says this is new block
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# default command wil start nginx automatically