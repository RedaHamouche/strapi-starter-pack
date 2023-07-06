FROM node:18.16.0-alpine
# Installing libvips-dev for sharp Compatibility
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

ENV HOST=0.0.0.0
ENV PORT=1337
ENV APP_KEYS=cPduQUh7GSeVxbvs3QPggw==,5qjBcVaqmgCwTP7trTlqvQ==,1sA+elJUfglmK3VLv4GqGg==,LN+0udmU0Zsj3t+ydVApJA==
ENV API_TOKEN_SALT=tRRMy2Wo3QET8ZAl3sBKSw==
ENV ADMIN_JWT_SECRET=AT2EHK0Fyhj6BCSLTKdilA==
ENV TRANSFER_TOKEN_SALT=sf227x+Jh17WBURK0AynXA==
# Database
ENV DATABASE_CLIENT=mysql
ENV DATABASE_PORT=3306
ENV DATABASE_NAME=strapi
ENV DATABASE_USERNAME=root
ENV DATABASE_PASSWORD=root
ENV JWT_SECRET=7KfVwKvBZ6hAZD+C6sMa+g==

WORKDIR /opt/
COPY package.json yarn.lock ./
RUN yarn config set network-timeout 600000 -g && yarn install
ENV PATH /opt/node_modules/.bin:$PATH

WORKDIR /opt/app
COPY . .
RUN chown -R node:node /opt/app
USER node
RUN ["yarn", "build"]
EXPOSE 1337
CMD ["yarn", "develop"]
