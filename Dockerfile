# Stage 1: Build the mdbook site
FROM rust:alpine AS builder

WORKDIR /app

# Copy the project files
COPY . .

# Install mdbook and build the book
RUN apk add --no-cache build-base libc6-compat && \
  cargo install mdbook && \
  cargo install mdbook-katex && \
  mdbook build

# Stage 2: Serve the built site with Nginx
FROM nginx:alpine

# Copy the built files from the builder stage
COPY --from=builder /app/book /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
