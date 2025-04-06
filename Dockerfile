FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including nodejs and npm
RUN apt-get update && apt-get install -y \
    curl git python3 python3-pip build-essential nodejs npm docker.io docker-compose \
    && apt-get clean

# Copy local code instead of cloning
COPY . /piston
WORKDIR /piston

# Install CLI dependencies and make it executable
RUN cd cli && npm install && cd .. && \
    chmod +x cli/index.js

# Install API dependencies 
RUN cd api && pip3 install -r requirements.txt && cd ..

# Install language packages
RUN ./cli/index.js ppman install python && \
    ./cli/index.js ppman install nodejs && \
    ./cli/index.js ppman install cpp

# Expose the default API port
EXPOSE 2000

CMD ["python3", "api/main.py"]