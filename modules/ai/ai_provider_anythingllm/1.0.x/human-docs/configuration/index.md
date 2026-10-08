# Configuration

Configuring this provider means telling it two things: **where** your AnythingLLM
instance is (its base URL) and **how** to authenticate to it (an API key stored as
a Key entity).

## 1. Get your AnythingLLM endpoint and API key

From your AnythingLLM instance, note:

- The **base URL** it is served on (for example
  `https://anythingllm.internal.example.com`). Prefer HTTPS, and make sure the
  endpoint is reachable from your Drupal server.
- An **API key**, generated in AnythingLLM's settings.

## 2. Store the API key as a secret (env → Key entity)

Never paste the API key into plain configuration. Store it in an environment
variable and reference it from a Key entity.

With DDEV:

```bash
ddev dotenv set .ddev/.env --anythingllm-api-key=YOUR_KEY_HERE
ddev restart
```

That exposes `ANYTHINGLLM_API_KEY` inside the container (keep `.ddev/.env` out of
version control). Then create a Key entity at **Configuration → System → Keys →
Add key** (`/admin/config/system/keys/add`):

- **Key type:** Authentication.
- **Key provider:** Environment.
- **Environment variable:** `ANYTHINGLLM_API_KEY`.

Save the key.

## 3. Configure the provider

1. Log in as a user who can administer AI providers.
2. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and
   open the **AnythingLLM** provider settings.
3. Enter the **base URL** of your AnythingLLM instance.
4. Select the **Key** you created for the API key.
5. Save.

## 4. Use it

Choose **AnythingLLM** wherever the AI module offers a provider choice — for
example as the default chat provider, or on a specific AI feature. Because
AnythingLLM can be self-hosted, this lets prompts stay on infrastructure you
control; just confirm the endpoint you configured is one you trust.
