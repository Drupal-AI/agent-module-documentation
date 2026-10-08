# Configuration

Configuring this module means supplying your ActiveCampaign API credentials and
storing them securely. The settings are protected by the **Manage ActiveCampaign
API settings** (`manage activecampaign_api settings`) permission, so grant that
to the right administrators first (under **People → Permissions**).

## Get your ActiveCampaign credentials

1. Sign in to ActiveCampaign.
2. Open your account's developer / API settings and copy the **API URL** (the
   account URL) and the **API key**.

## Store the credentials as secrets

Credentials must be environment-backed, not committed to version control or
exported configuration. With DDEV you can set an environment variable like this:

```bash
ddev dotenv set .ddev/.env --activecampaign-api-key=<your-key>
ddev restart
```

That exposes the value as `ACTIVECAMPAIGN_API_KEY` inside the container (keep
`.ddev/.env` out of version control). Where supported, wire the value through a
**Key** entity (the `key` module) using its environment provider so nothing
sensitive lands in configuration; otherwise read it from `settings.php` with
`getenv()`.

## Provide the credentials to the module

In the module's settings (reachable with the **Manage ActiveCampaign API
settings** permission), point the client at your environment-backed credentials.
Once saved, other modules or custom code that depend on this client can use it to
sync contacts, manage lists, and trigger automations.

## Verify

If a consuming module or a small test call can reach ActiveCampaign (for example
listing contacts) without an authentication error, the credentials are wired up
correctly.
