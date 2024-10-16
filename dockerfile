# Step 1: Use an official Node.js base image
FROM node:16

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the package.json and package-lock.json files
COPY package*.json ./

# Step 4: Install the application dependencies
RUN npm install

# Step 5: Copy the rest of the application code
COPY . .

# Step 6: Expose the port the app runs on
EXPOSE 6000

# Step 7: Define the command to start the app
CMD ["npm", "start"]
