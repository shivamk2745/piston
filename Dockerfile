FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl git python3 python3-pip build-essential \
    && apt-get clean

# Copy local code instead of cloning
COPY . /piston
WORKDIR /piston

# Create scripts directory and install script
RUN mkdir -p scripts && \
    echo '#!/bin/bash\n\
pip3 install -e cli/\n\
pip3 install -e api/\n\
./cli/index.js ppman list\n\
# Install language packages\n\
./cli/index.js ppman install python\n\
./cli/index.js ppman install nodejs\n\
./cli/index.js ppman install cpp\
' > scripts/install.sh && \
    chmod +x scripts/install.sh && \
    ./scripts/install.sh

# Expose the default API port
EXPOSE 2000

CMD ["python3", "api/main.py"]