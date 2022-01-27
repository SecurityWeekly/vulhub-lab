FROM alpine:edge

RUN apk --update add --no-cache python3 py3-requests py3-pip openssl ca-certificates bash

WORKDIR /files

EXPOSE 80

CMD ["python3", "-m", "http.server", "80"]