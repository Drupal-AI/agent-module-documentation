# Configuration

Configuring ActiveTickets Client means connecting Drupal to your ActiveTickets
account with API credentials, stored securely, and served over HTTPS.

## Get your ActiveTickets credentials

Obtain the API credentials for your ActiveTickets account from ActiveTickets.
Confirm the API endpoint you connect to uses **HTTPS**.

## Store the credentials as secrets

API credentials must be environment-backed rather than committed to version
control or exported configuration. With DDEV you can set an environment variable
like this:

```bash
ddev dotenv set .ddev/.env --activetickets-api-key=<your-key>
ddev restart
```

That exposes the value as `ACTIVETICKETS_API_KEY` inside the container (keep
`.ddev/.env` out of version control). Where supported, wire the value through a
**Key** entity (the `key` module) with its environment provider so nothing
sensitive lands in configuration; otherwise read it in `settings.php` with
`getenv()`.

## Connect the module

Point the module's connection settings at your environment-backed credentials.
Once connected, the client can fetch and manage events and ticketing data.

## Handle customer data responsibly

The client may exchange customer and booking data, which is personal data. Make
sure your handling, retention, and disclosure of that data meet your privacy
obligations, and keep the credentials scoped to only what the integration needs.
