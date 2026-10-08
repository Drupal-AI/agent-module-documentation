# Configuration

Configuring this provider means storing your Baidu API credential as a **Key**
entity and then selecting it on the provider's settings form.

## 1. Get a Baidu API credential

From Baidu's AI platform (ERNIE / Qianfan) create the API credential the provider
needs and copy it for the next step. Do not paste it directly into Drupal
configuration.

## 2. Store the credential as a secret (env → Key entity)

Put the credential in an environment variable. With DDEV:

```bash
ddev dotenv set .ddev/.env --baidu-api-key=YOUR_KEY_HERE
ddev restart
```

That exposes `BAIDU_API_KEY` inside the container (keep `.ddev/.env` out of version
control). Then create a Key entity at **Configuration → System → Keys → Add key**
(`/admin/config/system/keys/add`):

- **Key type:** Authentication.
- **Key provider:** Environment.
- **Environment variable:** `BAIDU_API_KEY`.

Save the key.

## 3. Configure the provider

1. Log in as a user with permission to administer AI providers.
2. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and open
   the **Baidu** provider settings.
3. Select the **Key** you created.
4. Save.

## 4. Select a Baidu model

Choose **Baidu** and a model wherever the AI module offers a provider choice — for
example as the default chat provider, or on an individual AI feature.

## Data-residency note

Prompts are sent to Baidu's API, which operates in China. Treat this as a
data-residency and data-handling decision for sensitive or regulated content, and
remember that ordinary Baidu API usage cost applies.
