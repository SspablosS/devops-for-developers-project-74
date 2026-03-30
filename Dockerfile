FROM node:20.12.2

WORKDIR /app

COPY app/ ./

RUN make install && make db-migrate

EXPOSE 8080

CMD ["make", "test"]
