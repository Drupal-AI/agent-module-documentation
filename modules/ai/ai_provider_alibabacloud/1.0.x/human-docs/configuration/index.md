# Configuration

Configuring this provider is a two-part job: first store your Alibaba Cloud Model
Studio API key as a **Key** entity, then tell the provider to use it.

## 1. Get an Alibaba Cloud Model Studio API key

Sign in to the Alibaba Cloud console, open **Model Studio** (the DashScope /
Bailian platform that serves the Qwen models), and create an API key. Copy the key
somewhere safe for the next step — you will not paste it directly into Drupal
configuration.

## 2. Store the key as a secret (env → Key entity)

Never paste the API key into a plain configuration field or commit it to Git.
Store it in an environment variable and reference it from a Key entity.

With DDEV, save the value into the container's environment:

```bash
ddev dotenv set .ddev/.env --alibabacloud-api-key=YOUR_KEY_HERE
ddev restart
```

That makes the variable `ALIBABACLOUD_API_KEY` available inside the container
(keep `.ddev/.env` out of version control). Then create a Key entity that reads
from it — at **Configuration → System → Keys → Add key**
(`/admin/config/system/keys/add`):

- **Key type:** Authentication.
- **Key provider:** Environment.
- **Environment variable:** `ALIBABACLOUD_API_KEY`.

Save the key.

## 3. Point the provider at your key

1. Log in as a user who can administer AI providers.
2. Go to the AI providers area under **Configuration → AI → Providers**
   (`/admin/config/ai/providers`) and open the **Alibaba Cloud Model Studio**
   settings form (route `ai_provider_alibabacloud.settings_form`).
3. Select the **Key** you created above as the API key.
4. Confirm any endpoint/region and default-model fields for Model Studio, then
   save.

The API key is sent to Alibaba Cloud as a Bearer token over HTTPS with normal
certificate verification.

## 4. Select a Qwen model

The provider only makes Qwen available; you still choose where it is used. In the
AI module's settings (for example the default provider for chat, or an individual
AI feature), pick **Alibaba Cloud Model Studio** and the Qwen model you want. Those
operations now run against Alibaba Cloud.

## Data-residency note

Prompts and any content you include are transmitted to Alibaba Cloud, which
operates outside the US/EU. Treat this as a data-residency and data-handling
decision for sensitive or regulated content before enabling it in production.
