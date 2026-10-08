# Configuration

All the module needs to work is the address of your Immich server and an API key
that authenticates Drupal against it.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → Immich**, or navigate directly to
   `/admin/config/media/immich`.

## The settings

- **Server URL** — the base URL of your Immich instance (for example
  `https://immich.example.com`). The module validates it and uses it as the base
  for every API request. Because this value is set only by an administrator, there
  is no untrusted‑input SSRF concern here.
- **API key** — a key you generate inside Immich (in Immich, under your account's
  API key settings). The module sends it as the `x-api-key` header on every
  request. This is a credential that grants access to your photo library, so treat
  it carefully.
- **Test Connection** — an AJAX button that calls the Immich server and reports
  back its version, confirming the URL and key are correct before you save.

Click **Save configuration** when the test passes.

## Keep the API key out of committed config

The module saves the API key in its configuration (`immich_integration.settings`).
Avoid committing the real key to version control.

With DDEV, store the key in an environment variable:

```bash
ddev dotenv set .ddev/.env --immich-api-key=<your-immich-api-key>
ddev restart
```

That exposes it inside the web container as `IMMICH_API_KEY` (never commit
`.ddev/.env`). You can then reference it from your deployment/config workflow so
the real key lives only in the environment. Where you can, install the
[Key](https://www.drupal.org/project/key) module and store the credential in an
env‑backed Key entity rather than in module config.

## Network egress

Drupal must be able to reach your Immich server over the network. If your site runs
behind a restrictive egress policy, allow outbound HTTPS to the Immich server's
host. TLS certificate verification is on by default (the module uses Drupal's
standard HTTP client), so the Immich server needs a valid certificate for the URL
you configure.

## After configuring

The settings form is the end of the click‑through setup. To actually display or use
Immich content, a developer injects the `immich_integration.client` service into
custom code — see the sibling [`agent/`](../agent/start.md) docs for the available
methods.
