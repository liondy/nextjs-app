# Next.js Production Container Setup

This project includes a multi-stage Docker build tailored for running the Next.js application in production.

## Prerequisites
- Docker Engine 20.10+
- Docker Compose plugin (or `docker-compose` v1.29+)

## Build the production image
```bash
docker build -t nextjs-app .
```

## Run the container directly
```bash
docker run --rm -p 3000:3000 nextjs-app
```
The app is now reachable at http://localhost:3000.

## Using Docker Compose
```bash
docker compose up --build
```
This starts the container with the production image and maps port 3000 from the container to the host. The service uses the `unless-stopped` restart policy so it will come back up automatically after a reboot.

Press `Ctrl+C` to stop, then remove the containers with:
```bash
docker compose down
```

## Environment variables
Add any environment variables required by the app into a `.env` file in the project root. They are automatically picked up by Next.js at build/run time. Rebuild the image after changing environment variables that affect the build.

## Troubleshooting
- If dependencies change, rebuild the image: `docker compose build --no-cache`.
- Check logs with `docker compose logs -f web`.
