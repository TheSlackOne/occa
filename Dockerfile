
# Use an official Python image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install solc-select and setup Solidity compiler
RUN pip install solc-select==1.0.2 \
    && solc-select install 0.8.19 \
    && solc-select use 0.8.19

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the scanner script and contracts
COPY . .

# Default command
CMD ["python", "src/code-scanner.py"]
