# Configuration

Deepgram has no settings form of its own — you configure it in two moves: store
your Deepgram API key with the **Key** module, then point the **AI** module's
Deepgram provider at that Key. This keeps the secret out of your site's plain
configuration.

## Step 1 — Store the API key as a secret (recommended: environment variable)

The safest place for an API key is an **environment variable**, referenced through
a Key entity — never hard‑coded and never committed to version control.

**On DDEV**, save the value into DDEV's dotenv file and restart so the container
picks it up:

```bash
ddev dotenv set .ddev/.env --deepgram-api-key=YOUR_DEEPGRAM_KEY
ddev restart
```

The flag `--deepgram-api-key` becomes the environment variable
`DEEPGRAM_API_KEY` inside the container. Keep `.ddev/.env` out of version control.
You can confirm the variable is present **without printing its value**:

```bash
ddev exec 'test -n "$DEEPGRAM_API_KEY" && echo set'
```

If you are not on DDEV, make `DEEPGRAM_API_KEY` available to the web server through
your normal environment mechanism.

## Step 2 — Create the Key entity

1. Make sure the **Key** module is enabled (it is a dependency, so it should already
   be on).
2. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and
   **Add key**.
3. Give it a label (for example *Deepgram API Key*), choose an authentication key
   type, and set the **key provider** to **Environment** — pointing at the
   `DEEPGRAM_API_KEY` variable from Step 1.
4. Save.

You can also create the Key from the command line, for example:

```bash
drush key:save deepgram_api_key --label='Deepgram API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"DEEPGRAM_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## Step 3 — Connect the Key to the AI provider

Go to the **AI** module's provider configuration under **Configuration → AI**
(`/admin/config/ai`), find the **Deepgram** provider, and select the Key you just
created as its credential. Save. The AI module will now route speech‑to‑text and
text‑to‑speech requests to Deepgram using that key.

## Step 4 — Use it

Deepgram is now available anywhere the AI module offers speech‑to‑text or
text‑to‑speech — including the **AI Automator**. A common setup: create a content
type with a text field and an MP3 file field, enable and configure the AI Automator
on the text field to transcribe the uploaded audio, then create an entity, attach an
audio file, and save. Deepgram fills in the transcribed text.

## A note on data egress

When you transcribe audio or synthesize speech, the audio/text is **sent to
Deepgram's servers** (over HTTPS) for processing. This is normal for a cloud
service, but confirm it is acceptable for your content before enabling it broadly —
voice recordings in particular can be sensitive or subject to privacy obligations.
