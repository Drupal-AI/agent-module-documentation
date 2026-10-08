# Configuration

Configuring this provider means storing your xAI API key as a **Key** entity and
selecting it on the provider's settings form.

## 1. Get an xAI API key

From your xAI account create an API key and copy it for the next step. Do not paste
it directly into Drupal configuration.

## 2. Store the key as a secret (env → Key entity)

Put the key in an environment variable. With DDEV:

```bash
ddev dotenv set .ddev/.env --xai-api-key=YOUR_KEY_HERE
ddev restart
```

That exposes `XAI_API_KEY` inside the container (keep `.ddev/.env` out of version
control). Then create a Key entity at **Configuration → System → Keys → Add key**
(`/admin/config/system/keys/add`):

- **Key type:** Authentication.
- **Key provider:** Environment.
- **Environment variable:** `XAI_API_KEY`.

Save the key.

## 3. Configure the provider

1. Log in as a user with permission to administer AI providers.
2. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and open
   the **xAI** provider settings.
3. Select the **Key** you created.
4. Save.

## 4. Select a Grok model

Choose **xAI** and a Grok model wherever the AI module offers a provider choice —
for example as the default chat provider, or on an individual AI feature.

## Cost and data-egress note

Prompt content is sent to xAI's API, so ordinary API usage cost and external data
egress apply. Confirm both are acceptable before enabling it in production.
