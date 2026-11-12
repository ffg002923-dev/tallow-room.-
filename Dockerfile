
FROM node:22-alpine

RUN apk add --no-cache unzip

WORKDIR /app

COPY game-bundle-*.zip /tmp/

RUN for f in /tmp/game-bundle-*.zip; do \
    unzip -oq "$f" -d /app; \
    done && \
    rm -f /tmp/game-bundle-*.zip && \
    chmod -R a+rX /app

ENV NODE_ENV=production
ENV PORT=8080

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s \
  CMD wget -qO- http://127.0.0.1:8080/health || exit 1

USER node

CMD ["node", "server/server.js"]
