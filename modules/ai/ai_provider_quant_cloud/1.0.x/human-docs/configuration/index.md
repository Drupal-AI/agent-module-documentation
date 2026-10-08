# Configuration

Quant Cloud authenticates with **OAuth**, so configuration means storing your OAuth
client credentials as **Key** entities and selecting them on the provider's
settings form.

## 1. Get OAuth client credentials

From the Quant Cloud dashboard, create or locate the **OAuth client credentials**
(typically a client ID and client secret) for the Dashboard API, and copy them for
the next step.

## 2. Store the credentials as secrets (env → Key entities)

Put the credentials in environment variables. With DDEV:

```bash
ddev dotenv set .ddev/.env --quant-client-id=YOUR_ID --quant-client-secret=YOUR_SECRET
ddev restart
```

That exposes `QUANT_CLIENT_ID` and `QUANT_CLIENT_SECRET` inside the container (keep
`.ddev/.env` out of version control). Then create a Key entity for each at
**Configuration → System → Keys → Add key** (`/admin/config/system/keys/add`):

- **Key type:** Authentication.
- **Key provider:** Environment.
- **Environment variable:** `QUANT_CLIENT_ID` (and a second key for
  `QUANT_CLIENT_SECRET`).

## 3. Configure the provider

1. Log in as a user with permission to administer AI providers.
2. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and open
   the **Quant Cloud** provider settings.
3. Select the **Key** entities holding your OAuth client credentials.
4. Save.

## 4. Select a model

Choose **Quant Cloud** wherever the AI module offers a provider choice — as the
default chat provider, on an individual AI feature, or as the **embeddings**
provider for AI Search.

## Cost and data note

Prompt and embedding content is sent to Quant's API, so ordinary platform cost and
data egress apply. Weigh that for sensitive or regulated content before enabling it
in production.
