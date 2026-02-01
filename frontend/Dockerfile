FROM node:18-alpine AS builder
WORKDIR /app

COPY package*.json .

RUN npm ci --omit=dev
COPY . .
ENV REACT_APP_BACKEND_URI=http://k8s-ecommerc-mainlb-7952d971ab-643844860.ap-south-1.elb.amazonaws.com
ENV REACT_APP_CLOUD_NAME_CLOUDINARY=dnbnsimy4
RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx","-g","daemon off;"]

