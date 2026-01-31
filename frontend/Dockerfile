FROM node:18-alpine AS builder
WORKDIR /app

COPY package*.json .

RUN npm ci --omit=dev
COPY . .
ARG REACT_APP_CLOUD_NAME_CLOUDINARY
ARG REACT_APP_BACKEND_URI
ENV REACT_APP_BACKEND_URI=$REACT_APP_BACKEND_URI
ENV REACT_APP_CLOUD_NAME_CLOUDINARY=$REACT_APP_CLOUD_NAME_CLOUDINARY
RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx","-g","daemon off;"]

