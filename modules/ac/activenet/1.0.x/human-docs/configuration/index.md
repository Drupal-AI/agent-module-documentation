# Configuration

Configuring ActiveNet means connecting Drupal to your ActiveNet account with API
credentials, stored securely, and served over HTTPS.

## Get your ActiveNet credentials

Obtain the API credentials for your ActiveNet (Active Network) account from
Active Network. Confirm the API endpoint you connect to uses **HTTPS**.

## Store the credentials as secrets

API credentials must be environment-backed rather than committed to version
control or exported configuration. With DDEV you can set an environment variable
like this:

```bash
ddev dotenv set .ddev/.env --activenet-api-key=<your-key>
ddev restart
```

That exposes the value as `ACTIVENET_API_KEY` inside the container (keep
`.ddev/.env` out of version control). Where supported, wire the value through a
**Key** entity (the `key` module) with its environment provider so nothing
sensitive lands in configuration; otherwise read it in `settings.php` with
`getenv()`.

## Connect the module

Point the module's connection settings at your environment-backed credentials.
Once connected, ActiveNet fetches program and activity data for display in
Drupal.

## Display the fetched data safely

The programs and activities come from an external service, so treat them as
untrusted content: make sure whatever renders them escapes the values on output.
Grant the module's permission only to the administrators who should manage or see
the integration.
