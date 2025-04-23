FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install all required packages and fix PATH + netcat compatibility
RUN apt-get update && \
    apt-get install -y \
    cowsay \
    fortune-mod \
    netcat-openbsd \
    dos2unix && \
    echo 'export PATH=$PATH:/usr/games' >> /etc/profile && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the original wisecow.sh script
COPY wisecow.sh .

# 🔧 Remove carriage returns using sed (works even if dos2unix fails)
RUN sed -i 's/\r$//' wisecow.sh && chmod +x wisecow.sh

# Ensure cowsay/fortune in path
ENV PATH="/usr/games:$PATH"

# Expose the port
EXPOSE 4499

# Use shell form to avoid shebang parsing
CMD bash wisecow.sh