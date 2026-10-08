# Configuration

Ecomail's setup is really one task: get your **Ecomail API key** into the site
safely, as a **Key** entity, so the integration can authenticate. Because the key
is a secret, the goal is to keep its value out of your database config exports and
out of version control.

## Step 1 — get your API key from Ecomail

Log in to your Ecomail account and copy your API key from the Ecomail dashboard
(under your account's integrations/API settings). Keep it handy but treat it like
a password.

## Step 2 — store the key as an environment variable (recommended)

The safest home for a secret is an environment variable, not a text field in the
database. If you use DDEV, save it into DDEV's dotenv file and restart so the web
container picks it up:

```bash
ddev dotenv set .ddev/.env --ecomail-api-key=<your-key-here>
ddev restart
```

The flag `--ecomail-api-key` becomes the environment variable
`ECOMAIL_API_KEY`. **Never commit `.ddev/.env`** — keep it out of version
control. You can confirm the variable is present *without* printing its value:

```bash
ddev exec 'test -n "$ECOMAIL_API_KEY" && echo set'
```

## Step 3 — create the Key entity

Create a Key that reads from that environment variable, using the Key module's
built‑in env provider:

```bash
ddev drush key:save ecomail_api_key \
  --label='Ecomail API Key' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"ECOMAIL_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

You can also do this through the UI at **Configuration → System → Keys**
(`/admin/config/system/keys`) → **Add key**: give it a label, choose the
*Authentication* key type, and pick a provider — the **Environment** provider
(pointing at `ECOMAIL_API_KEY`) keeps the secret out of the database, while the
*Configuration* provider stores the value in config if you accept that trade‑off.

## Step 4 — point Ecomail at the key

With the Key entity in place, tell Ecomail to use it as its Ecomail API key. The
module reads the key from the Key module, so selecting the `Ecomail API Key` you
just created is what activates the connection.

## A note on privacy and transport

Once connected, Ecomail **sends contact and subscriber data to Ecomail's
servers** — this is personal data leaving your site for a third party, so make
sure your privacy policy discloses the transfer. Always serve the site over
**HTTPS** so both the API key and the synced data are protected in transit.
