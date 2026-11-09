FROM node:23-alpine AS builder

WORKDIR /app

RUN corepack enable

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
ENV NODE_OPTIONS="--max-old-space-size=2560"
RUN pnpm exec nuxt build


FROM node:23-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

COPY --from=builder --chown=node:node /app/.output/ ./.output
COPY --from=builder --chown=node:node /app/realtime/ ./realtime
COPY --from=builder --chown=node:node /app/node_modules/ ./node_modules
COPY --from=builder --chown=node:node /app/package.json ./package.json

USER node
EXPOSE 3000 3015
CMD ["node", ".output/server/index.mjs"]

