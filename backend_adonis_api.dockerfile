# 1. Grab the latest node image
FROM node:latest
RUN npm i -g @adonisjs/cli

# 2. Set the working directory inside the container to /app
WORKDIR /app

# 3. Add the .env to the directory (We need those variables)
# ADD .env /app
COPY .env.docker /app/.env

# 4. Expose port defined in .env file
EXPOSE ${PORT}

# 5. Add package.json to the directory
ADD package.json /app

# 6. Install dependencies
RUN npm i

# 7. Install mysql
RUN npm i -s mysql

# 8. Copy the rest into directory
COPY . /app
COPY .env.docker /app/.env

# 9. Start the app inside the container
CMD ["npm", "start"]
# CMD ["npm", "run-script", "dev"]