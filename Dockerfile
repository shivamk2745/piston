FROM ubuntu:20.04

# Install required dependencies

RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y \
    curl git python3 python3-pip build-essential nodejs npm docker.io docker-compose && \
    apt-get clean

# Clone the repository
RUN git clone https://github.com/engineer-man/piston /piston
WORKDIR /piston

# Start the API container (needs privileged mode)
# This is where Docker Compose would normally be used locally

# Install CLI dependencies
RUN cd cli && npm install && cd ..

# The CLI commands should be run after the container starts
# They can't be run during build because they need the API running

EXPOSE 2000

# Start the API server
CMD ["node", "api/src/index.js"]