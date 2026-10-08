# Configuration

The core of configuring this module is connecting it to your ActiveCampaign
account. That means supplying two things from ActiveCampaign — your **API URL**
(the account URL) and an **API key** — and storing them securely.

## Get your ActiveCampaign credentials

1. Sign in to ActiveCampaign.
2. Open your account's developer / API settings and copy the **API URL** and the
   **API key**.

## Store the credentials as secrets

API credentials are secrets and must never be committed to version control or
pasted into exported configuration. Store them as environment variables and read
them from there. With DDEV you can set an environment variable like this:

```bash
ddev dotenv set .ddev/.env --activecampaign-api-key=<your-key>
ddev restart
```

That makes the value available as `ACTIVECAMPAIGN_API_KEY` inside the container
(keep `.ddev/.env` out of version control). Where the module or your site
supports it, wire the value in through a **Key** entity (the `key` module) using
its environment provider, so nothing sensitive lands in configuration. Otherwise
reference the environment variable from `settings.php` with `getenv()`.

## Connect the module

With the credentials available as secrets, enter (or reference) them in the
module's connection settings so the module can authenticate to the ActiveCampaign
API. Once connected, contacts can sync and — if you enabled the submodules — the
dashboard view and Webform integration become usable.

## Privacy checklist

- Contact data (names, email addresses) is personal data sent to a third party.
  Make sure you have consent to share it and that your privacy notice discloses
  the transfer to ActiveCampaign.
- Keep the API key rotated and scoped to what the integration needs.
