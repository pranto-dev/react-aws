# Use a lightweight Node.js image
FROM node:alpine as build

# Set the working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install


# Copy the rest of the files
COPY . .

# Build the React app
RUN npm run build

# Use a lightweight Nginx image
FROM nginx:alpine

# Copy the React app build files
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]



