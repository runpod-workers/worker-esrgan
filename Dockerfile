FROM runpod/base:0.4.2-cuda11.8.0

# Python dependencies
COPY builder/requirements.txt /requirements.txt
RUN python3.11 -m pip install --upgrade pip && \
    python3.11 -m pip install --no-cache-dir setuptools wheel && \
    python3.11 -m pip install --no-cache-dir numpy>=1.22.0 && \
    python3.11 -m pip install --no-cache-dir -r /requirements.txt && \
    rm /requirements.txt

# Create weights directory
RUN mkdir -p weights

# download models
RUN wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 3 https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth -P weights
RUN wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 3 https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.1/RealESRNet_x4plus.pth -P weights
RUN wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 3 https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.2.4/RealESRGAN_x4plus_anime_6B.pth -P weights
RUN wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 3 https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.1/RealESRGAN_x2plus.pth -P weights

# Copy source code
ADD src .

# Add test_input.json for RunPod SDK automated testing
COPY src/test_input.json /test_input.json

CMD [ "python3.11", "-u", "rp_handler.py" ]