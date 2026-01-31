FROM node:18-alpine AS builder
WORKDIR /app

COPY package*.json .

RUN npm ci --omit=dev
COPY . .
ENV REACT_APP_BACKEND_URI=http://43.205.199.75:32538
ENV REACT_APP_CLOUD_NAME_CLOUDINARY=dnbnsimy4
RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx","-g","daemon off;"]

