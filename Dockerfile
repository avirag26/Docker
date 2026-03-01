FROM node:24-alpine AS builder

WORKDIR /app

COPY package*.json ./

COPY tsconfig*.json ./

RUN npm ci

COPY . .

RUN npm run build


FROM node:24-alpine

RUN npm install -g serve

WORKDIR /app

COPY --from=builder /app/dist ./dist

EXPOSE 3000

CMD ["serve","-s","dist"]