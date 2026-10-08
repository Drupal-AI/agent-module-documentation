# Configuration

OpenID ClaveUnica is configured as a client of the **OpenID Connect** module, so
the settings live on OpenID Connect's client screen. The ClaveÚnica‑specific
pieces (endpoints and the complete‑profile flow) come from this module.

## Handle the client secret as a secret

Your ClaveÚnica **client ID** and especially the **client secret** are
credentials — keep them out of version control and out of exported configuration,
and serve your site over HTTPS so they're never sent in the clear. If you run
DDEV, store the secret in the environment and never commit `.ddev/.env`:

```bash
ddev dotenv set .ddev/.env --claveunica-client-secret=<your-secret>
ddev restart
```

then reference it (for example via a Key entity or `getenv()`), rather than typing
it into config you export.

## Set up the ClaveÚnica client

Go to **Configuration → People → OpenID Connect**
(`/admin/config/people/openid-connect`) and add or edit the **ClaveÚnica** client:

- **Client ID** and **Client secret** — the credentials issued for your site by
  ClaveÚnica. Provide the secret from your secret store as described above.
- **Endpoints / issuer** — the ClaveÚnica authorization, token, and userinfo
  endpoints. This module supplies the ClaveÚnica‑specific values.
- Any additional ClaveÚnica options the client exposes.

Save the client.

## Security posture — what's handled for you

- **Login CSRF (the OAuth `state` parameter):** handled by the OpenID Connect base
  module, not reimplemented here. Keeping OpenID Connect updated keeps that
  defence current — treat it as a required part of your setup.
- **Code→token exchange and identity mapping:** also handled by OpenID Connect.
- **Complete‑profile step:** the complete‑account route
  (`claveunica/complete-account/{user}/{client}/{hash}`) is gated by a custom
  access check, and the form validates a per‑user hash before calling
  `user_login_finalize()`, so a new user can only finish their own profile.

## Test it

Sign in with a test ClaveÚnica account. A first‑time user should be routed through
the complete‑profile step (validated by the per‑user hash) before the account is
finalised; a returning user should be logged straight in. If login fails, re‑check
the credentials and endpoints, and confirm OpenID Connect is enabled and updated.
