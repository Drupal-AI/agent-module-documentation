# Configuration

Unlike the single-vendor providers, Universal is configured by **defining
configuration entities**: one or more *servers* (each an OpenAI-compatible
endpoint) and the *models* they serve. Any API keys are stored through the **Key**
module.

## 1. Store any API keys as secrets (env → Key entities)

If an endpoint you want to register requires an API key, put it in an environment
variable first. With DDEV:

```bash
ddev dotenv set .ddev/.env --universal-api-key=YOUR_KEY_HERE
ddev restart
```

That exposes `UNIVERSAL_API_KEY` inside the container (keep `.ddev/.env` out of
version control; use one variable per endpoint that needs its own key). Then create
a Key entity at **Configuration → System → Keys → Add key**
(`/admin/config/system/keys/add`):

- **Key type:** Authentication.
- **Key provider:** Environment.
- **Environment variable:** `UNIVERSAL_API_KEY`.

A self-hosted server with no authentication needs no key.

## 2. Define servers and models

1. Log in as a user with permission to administer AI providers.
2. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and open
   the **Universal** provider's configuration.
3. Add a **server** for each OpenAI-compatible endpoint — its base URL, and the Key
   entity for its API key where required.
4. Add the **models** each server serves.

Because servers and models are configuration entities, they can be exported with
your site's configuration and deployed between environments.

## 3. Use it

Choose **Universal** and one of your defined models wherever the AI module offers a
provider choice. Prompt content is sent to whichever endpoint backs that model, so
cost and data egress depend on the server you pointed it at.
