FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl git python3 python3-pip build-essential nodejs npm docker.io docker-compose \
    && apt-get clean

# Copy code
COPY . /piston
WORKDIR /piston

# Debug: Show directory structure
RUN ls -la && ls -la api && ls -la cli

# Install CLI dependencies
RUN cd cli && npm install && cd ..

# Install Flask API dependencies
RUN pip3 install flask requests

# Install language runtimes using the CLI
RUN node cli/index.js ppman install python && \
    node cli/index.js ppman install nodejs && \
    node cli/index.js ppman install cpp

EXPOSE 2000

CMD ["python3", "api/main.py"]
