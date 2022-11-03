FROM node:14

# Create app directory
WORKDIR /usr/src/app

COPY package*.json ./
COPY server.js ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "node", "server.js" ]
