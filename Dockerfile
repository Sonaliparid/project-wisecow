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

# Convert line endings and make it executable
RUN dos2unix wisecow.sh && chmod +x wisecow.sh

# Ensure PATH includes /usr/games at runtime
ENV PATH="/usr/games:$PATH"

# Expose the port used in wisecow.sh
EXPOSE 4499

# Start the app
CMD ["./wisecow.sh"]
