# Configuration

Configuring this provider means storing your SiliconFlow API key as a **Key**
entity, selecting it on the provider's settings form, and (optionally) granting the
permission that powers the model-list lookup.

## 1. Get a SiliconFlow API key

From your SiliconFlow account create an API key and copy it for the next step. Do
not paste it directly into Drupal configuration.

## 2. Store the key as a secret (env → Key entity)

Put the key in an environment variable. With DDEV:

```bash
ddev dotenv set .ddev/.env --siliconflow-api-key=YOUR_KEY_HERE
ddev restart
```

That exposes `SILICONFLOW_API_KEY` inside the container (keep `.ddev/.env` out of
version control). Then create a Key entity at **Configuration → System → Keys → Add
key** (`/admin/config/system/keys/add`):

- **Key type:** Authentication.
- **Key provider:** Environment.
- **Environment variable:** `SILICONFLOW_API_KEY`.

Save the key.

## 3. Grant the model-list permission

The model-list autocomplete is gated by a dedicated permission. At **People →
Permissions** (`/admin/people/permissions`), grant **`autocomplete siliconflow
model list`** to the roles that configure the provider (typically administrators).

## 4. Configure the provider

1. Log in as a user with the permission above and rights to administer AI
   providers.
2. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and open
   the **SiliconFlow** provider settings.
3. Select the **Key** you created.
4. Use the **model-list autocomplete** to look up and choose a SiliconFlow-hosted
   model.
5. Save.

## 5. Use it

Choose **SiliconFlow** wherever the AI module offers a provider choice. Prompt
content is sent to SiliconFlow's API, so ordinary API usage cost and data egress
apply.
