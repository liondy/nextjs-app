FROM node:18-alpine AS deps
WORKDIR /app

COPY app/package*.json ./
RUN npm install

FROM node:18-alpine AS builder
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY ./app .

RUN mkdir -p public \
    && npm run build

FROM node:18-alpine AS runner
WORKDIR /app

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules

EXPOSE 3000
CMD ["npm", "run", "start"]
