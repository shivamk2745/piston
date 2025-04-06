FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl git python3 python3-pip build-essential \
    docker.io docker-compose sudo \
    && apt-get clean

# Clone the piston repo
RUN git clone https://github.com/engineer-man/piston.git /piston
WORKDIR /piston

# Install piston (includes runtime setup)
RUN ./scripts/install.sh

# Expose the default API port
EXPOSE 2000

CMD ["python3", "main.py"]
