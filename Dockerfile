FROM python:3.11
WORKDIR /app
COPY https-server.py .
COPY certs ./certs
EXPOSE 8443
CMD ["python3", "https-server.py"]
