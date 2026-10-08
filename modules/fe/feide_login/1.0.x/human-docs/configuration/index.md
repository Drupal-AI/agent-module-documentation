# Configuration

Setting up Feide Login is a one‑time task with three parts: register an
application with Feide, store the client secret safely, and decide how returning
users map to Drupal accounts.

## 1. Register a Feide application

You need a client ID and a client secret from Feide (issued through Feide's
customer/Dataporten administration). When registering the application, you will be
asked for a **redirect URI** (callback URL) — this is the address Feide sends the
user back to after they authenticate. For this module that is the `/feide_redirect`
path on your site, for example:

```
https://your-site.example/feide_redirect
```

Register the exact URL your site is served from. Feide will only redirect back to
URIs you have registered, so a mismatch is the most common cause of a failed
login.

## 2. Store the client secret with Key (do not paste it into config)

The client secret is a credential and should live in an environment variable, not
in exported configuration or code. The Key module (installed with this module)
reads it from the environment.

If you are on **DDEV**, save the value into DDEV's dotenv file and restart so the
container picks it up:

```bash
ddev dotenv set .ddev/.env --feide-client-secret='<your-secret>'
ddev restart
```

That makes the variable `FEIDE_CLIENT_SECRET` available inside the container.
(Keep `.ddev/.env` out of version control — never commit a secret.)

Then create a **Key** entity backed by that environment variable:

```bash
ddev drush key:save feide_client_secret \
  --label='Feide client secret' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"FEIDE_CLIENT_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

The client ID is not secret and can be entered directly in the module's settings;
only the secret needs the Key treatment.

## 3. Enter the settings and choose the mapping behaviour

With the Feide application registered and the secret stored, enter the module's
settings — the client ID, the Key that holds the client secret, and the OAuth
endpoints — and choose whether new Feide users should be **auto‑registered**:

- **Auto‑register on** — a Feide user with no matching Drupal account gets one
  created automatically on first login. Convenient for open onboarding.
- **Auto‑register off** — only Feide users whose email already matches an existing
  Drupal account can log in. Choose this when accounts must be provisioned ahead
  of time.

Mapping is done **by email address** via ExternalAuth, so make sure the email a
user presents from Feide is the one you expect to match.

## 4. Before you go live

Test the full login round‑trip on a staging environment first.
