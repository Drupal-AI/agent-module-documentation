# Configuration

Configuring this provider means storing your X API key as a **Key** entity and
selecting it on the provider's settings form.

## 1. Get an X API key

From your X AI account create an API key for the Grok service and copy it for the
next step. Do not paste it directly into Drupal configuration.

## 2. Store the key as a secret (env → Key entity)

Put the key in an environment variable. With DDEV:

```bash
ddev dotenv set .ddev/.env --x-api-key=YOUR_KEY_HERE
ddev restart
```

That exposes `X_API_KEY` inside the container (keep `.ddev/.env` out of version
control). Then create a Key entity at **Configuration → System → Keys → Add key**
(`/admin/config/system/keys/add`):

- **Key type:** Authentication.
- **Key provider:** Environment.
- **Environment variable:** `X_API_KEY`.

Save the key.

## 3. Configure the provider

1. Log in as a user with permission to administer AI providers.
2. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and open
   the **X (Grok)** provider settings.
3. Select the **Key** you created.
4. Save.

## 4. Use it

Choose **X (Grok)** wherever the AI module offers a provider choice — for example
as the default chat provider, or on an individual AI feature.

## Data-egress note

Calls go to X's API over HTTPS, and prompt content is sent to X. Confirm that
external egress is acceptable for the content you route through it before enabling
it in production.
