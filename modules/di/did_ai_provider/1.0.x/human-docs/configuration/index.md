# Configuration

Configuring D-ID AI Provider means three things: storing your D-ID API key
securely, telling the provider which key to use, and enabling the automator on a
file field so videos are generated when content is saved.

## 1. Store the D-ID API key securely

Never paste an API key directly into a settings form or commit it to code. Store
it as an environment variable and expose it to Drupal through the **Key** module.

With DDEV, save the value into your environment file and restart so the container
picks it up:

```bash
ddev dotenv set .ddev/.env --did-api-key=<your-d-id-key>
ddev restart
```

This makes the value available inside the container as `DID_API_KEY` (keep
`.ddev/.env` out of version control). Then create a Key entity that reads from
that variable:

```bash
ddev drush key:save did_api_key --label='D-ID API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"DID_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

> **Note:** D-ID authenticates with HTTP Basic credentials in the form
> `username:password`. Store the whole credential string as the key's value, in the
> format your D-ID account provides.

## 2. Select the key on the provider settings form

1. Log in as a user with the **administer ai providers** permission.
2. Go to **Configuration → AI → D-ID Provider settings**
   (`/admin/config/ai/di-ai-provider`).
3. In the **API key** field, select the Key entity you just created (for example
   *D-ID API Key*).
4. Save the form.

## 3. Enable the automator on a file field

1. Add (or edit) a **file field** on the content type where you want generated
   videos stored — this field will hold the output MP4.
2. On that field, enable the **AI Automator** and select **D-ID: Image + Audio →
   Video**.
3. Map the fields the automator should use:
   - The **audio field** that supplies the spoken audio.
   - Optionally an **image field** for the portrait — or choose **"No image"** and
     select a built-in **D-ID presenter**.
4. Optionally pick a **facial expression** (neutral, happy, surprised, serious,
   angry, or sad).
5. Save.

Now, when an editor saves content with the mapped audio (and image or presenter),
Drupal calls D-ID, generates the video, and stores the resulting MP4 in the file
field (under `public://did_videos`).

## Cost and egress caveats

- **Every generation is a paid, external API call.** Audio and images are sent to
  `api.d-id.com`, and each talk is billed by D-ID. Budget accordingly.
- **Generation can be slow.** A single call can block for up to ~10 minutes while
  D-ID renders and the module polls for the result; the module uses Drupal's
  batch/queue processing for reliability.
- **Restrict who can trigger it.** Because automators run on content save, limit
  which roles can create or edit the content that fires generation, so costs stay
  under control.
