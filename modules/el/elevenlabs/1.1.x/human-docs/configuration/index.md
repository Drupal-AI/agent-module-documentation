# Configuration

Configuring ElevenLabs is mostly about getting your API key into Drupal
**securely** and then pointing the module at it. Because the module stores a
reference to a **Key entity** rather than the secret itself, the recommended
approach is to keep the actual key in an environment variable and let the Key
module read it from there — nothing sensitive ends up in your configuration
export.

## Step 1 — Get your ElevenLabs API key

Create an API key in your ElevenLabs account. Make sure it is granted access to
Text to Speech, Speech to Text, Audio Isolation, Users, Voices, Models, and
History (the module needs these scopes to work fully).

## Step 2 — Store the key in an environment variable

Keep the secret out of code and configuration. With DDEV, save it into DDEV's
dotenv file and restart so the variable is available inside the web container:

```bash
ddev dotenv set .ddev/.env --elevenlabs-api-key=<your-key>
ddev restart
```

The flag `--elevenlabs-api-key` becomes the environment variable
`ELEVENLABS_API_KEY`. **Never commit `.ddev/.env`** — keep it out of version
control. You can confirm the variable is present without printing its value:

```bash
ddev exec 'test -n "$ELEVENLABS_API_KEY"'   # exit status 0 means it is set
```

## Step 3 — Create a Key entity backed by that variable

Create a Key (Configuration → System → Keys, or via Drush) that uses the Key
module's **environment** provider to read `ELEVENLABS_API_KEY`:

```bash
drush key:save elevenlabs_api_key \
  --label='ElevenLabs API Key' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"ELEVENLABS_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## Step 4 — Select the Key on the ElevenLabs settings form

1. Go to **Configuration → System → ElevenLabs settings**
   (`/admin/config/system/eleven-labs-settings`).
2. In the API key field (a Key selector), choose the **ElevenLabs API Key** you
   just created. The form stores the Key's id, not the secret.
3. Save the form.

## After configuring

Once saved, ElevenLabs is available as a text‑to‑speech (and speech‑to‑speech /
audio‑to‑audio) provider anywhere the AI module offers those operations,
including the AI Automator.

### Two things to watch

- **Cost.** ElevenLabs bills **per character**. Generate speech on save (and
  **cache the resulting audio**) rather than on every page render, or you may run
  up an unexpected bill.
- **Egress and terms.** Text you submit is sent to ElevenLabs' external service,
  and synthesised‑voice output is subject to ElevenLabs' own usage terms about
  whose voice may be imitated. Keep both in mind for privacy and licensing.
