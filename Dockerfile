FROM mhart/alpine-node:12 as production

# Create app directory
WORKDIR /usr/src/app

COPY package*.json ./
COPY server.js ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "node", "server.js" ]
