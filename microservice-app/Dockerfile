# Dockerfile

# Use minimal Node.js Alpine image
FROM node:20-alpine

# Security fix: Explicitly upgrade npm to secure version
RUN npm install -g npm@11.3.0

# Create non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Create working directory
WORKDIR /app

# Copy dependencies first (better caching)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --production

# Copy source code
COPY . .

# Change ownership to non-root user
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Expose port defined in .env or 3000 by default
EXPOSE 3000

# Run Node.js app
CMD ["node", "index.js"]