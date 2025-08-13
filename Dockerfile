# bookworm based, not buster
FROM python:3.10-slim
WORKDIR /app
RUN apt-get update \
 && apt-get install -y --no-install-recommends git ca-certificates \
 && rm -rf /var/lib/apt/lists/*
# clone your fork
RUN git clone https://github.com/Mp9909/UnHided.git .
# install deps
RUN pip install --no-cache-dir -r requirements.txt
# Spaces provide PORT automatically, default for local
ENV PORT=7860
EXPOSE 7860
# use shell form so ${PORT} gets expanded, and run a single worker
CMD sh -c "uvicorn run:main_app --host 0.0.0.0 --port ${PORT} --workers 1"
