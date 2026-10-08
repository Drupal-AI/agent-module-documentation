# Configuration

Configuring the BigBlueButton provider comes down to two things: telling Drupal
**where your BBB server is** and **how to authenticate to it** with the shared
secret. This module uses the **Key** module for the secret, which is the right way to
handle it — the shared secret never lives in plain module configuration.

## What you need from BigBlueButton

From your BigBlueButton server, collect:

- the **server URL** (the BBB API base URL for your server), and
- the **shared secret** — generated using a **supported hashing algorithm** (SHA‑1
  is no longer supported as of release 1.0.0‑alpha5).

## Step 1 — Store the shared secret as a Key

Rather than pasting the secret into a config field, store it as a **Key** entity so
it can be sourced from an environment variable and kept out of version control.

With DDEV, save the secret into an environment variable first (this keeps it out of
your codebase):

```bash
ddev dotenv set .ddev/.env --bbb-shared-secret=<your-secret>
ddev restart
```

`.ddev/.env` must **not** be committed to version control. Confirm the variable is
present in the container without printing it:

```bash
ddev exec 'test -n "$BBB_SHARED_SECRET"'   # exit status 0 means it is set
```

Then create a Key that reads it (install the Key module first if needed — it is a
dependency of this module, so it should already be enabled):

```bash
ddev drush key:save bbb_shared_secret \
  --label='BigBlueButton shared secret' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"BBB_SHARED_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

You can also create the Key through the UI at **Configuration → System → Keys**
(`/admin/config/system/keys`) if you prefer.

## Step 2 — Point the BBB provider at your server

In the BigBlueButton provider settings (reached through the Meeting API
administration):

- Set the **BBB server URL** to your BigBlueButton server's API base URL.
- Select the **Key** you created above as the source of the **shared secret**.
- Make sure the configured **hashing algorithm** matches what the server expects
  (not SHA‑1 on alpha5+).

Save the settings.

## Step 3 — Bind a meeting type to BigBlueButton

In **Meeting API**, edit (or create) a **meeting type** under **Structure** and set
its backend to **BigBlueButton**. Meetings of that type are now created on, and
joined through, your BBB server.

## Verify the connection

Create a test meeting of the BBB‑backed type. If it is created without an
authentication error, the server URL and Key are correct. An auth failure most often
means a mismatched secret or an unsupported hashing algorithm — regenerate the
secret on the BBB server with a supported algorithm and update the Key.

## Network and privacy notes

- Drupal makes **server‑side HTTPS requests** to your BBB server's API. Ensure the
  Drupal host has outbound network access to the BBB server, and use HTTPS.
- **BigBlueButton is a separate system** that handles the meetings and any
  recordings; secure and configure it on its own terms.
- **Join URLs are capabilities** — anyone with a join link can usually enter the
  meeting. Treat them as secrets in listings, feeds and notification emails.
