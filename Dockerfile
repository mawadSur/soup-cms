FROM node:18-alpine3.18
# Installing libvips-dev for sharp Compatibility
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/
COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm
RUN pnpm install
ENV PATH=/opt/node_modules/.bin:$PATH

WORKDIR /opt/app
COPY . .
RUN chown -R node:node /opt/app
USER node
RUN ["pnpm", "build"]
EXPOSE 1337
CMD ["pnpm", "develop"]
