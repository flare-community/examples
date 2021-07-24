######## base ########
FROM node:16-alpine3.12 AS base
WORKDIR /root/component
# install tini and set it as entrypoint
RUN apk add --no-cache tini
ENTRYPOINT ["/sbin/tini", "--"]
# copy project file
COPY package.json .


######## dependencies ########
FROM base AS dependencies
# install prod only and keep a copy
RUN npm install --only=production
RUN cp -R node_modules prod_node_modules
# install everything, including devDependencies
RUN npm install

######## release ########
FROM base AS release
# use prod node_modules
COPY --from=dependencies /root/component/prod_node_modules ./node_modules
# copy app sources
COPY . .
# expose port and define CMD
CMD npm run start
