FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl git python3 python3-pip build-essential \
    && apt-get clean

# Copy local code instead of cloning
COPY . /piston
WORKDIR /piston

# Install python dependencies
RUN ./scripts/install.sh

# Expose the default API port
EXPOSE 2000

CMD ["python3", "main.py"]