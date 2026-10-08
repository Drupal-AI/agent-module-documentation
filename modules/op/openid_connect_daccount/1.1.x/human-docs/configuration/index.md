# Configuration

d ACCOUNT OpenID Connect Client is configured as a client of the **OpenID
Connect** module, so the settings live on OpenID Connect's client screen. This
module contributes the d ACCOUNT‑specific endpoints and the Business d ACCOUNT
settings.

## Handle the client secret as a secret

Your d ACCOUNT **client ID** and especially the **client secret** are credentials
— keep them out of version control and out of exported configuration, and serve
your site over HTTPS so they're never sent in the clear. If you run DDEV, store the
secret in the environment and never commit `.ddev/.env`:

```bash
ddev dotenv set .ddev/.env --daccount-client-secret=<your-secret>
ddev restart
```

then reference it (for example via a Key entity or `getenv()`), rather than typing
it into config you export.

## Set up the d ACCOUNT client

Go to **Configuration → People → OpenID Connect**
(`/admin/config/people/openid-connect`) and add or edit the **d ACCOUNT** client:

- **Client ID** and **Client secret** — the credentials issued for your site.
  Provide the secret from your secret store as described above.
- **Endpoints** — the d ACCOUNT authorization, token, and userinfo endpoints. This
  module supplies the d ACCOUNT‑specific values.
- **Business d ACCOUNT settings** — the additional options this module adds for
  Business d ACCOUNT, beyond what the generic OpenID Connect client offers.

Save the client.

## Security posture — what's handled for you

- **Login CSRF (the OAuth `state` parameter):** handled by the OpenID Connect base
  module, not reimplemented here. Keeping OpenID Connect updated keeps that defence
  current — treat it as a required part of your setup.
- **Code→token exchange and identity mapping:** also handled by OpenID Connect.
- **This module's job:** supplying the d ACCOUNT endpoints, claims, and Business d
  ACCOUNT settings.

## Test it

Sign in with a test d ACCOUNT account. You should be redirected to d ACCOUNT and
back, and OpenID Connect should map the returned identity to a Drupal user. If
login fails, re‑check the credentials and endpoints, confirm the site is on HTTPS,
and make sure OpenID Connect is enabled and updated.
