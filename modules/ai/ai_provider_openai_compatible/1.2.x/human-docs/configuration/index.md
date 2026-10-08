# Configuration

This provider has its own settings form, reachable under **Configuration → AI**
(`/admin/config/ai`) or via the **Configure** link beside the module on the
**Extend** page. You need the AI provider administration permission (an
administrator by default). Two settings matter: the **base URL** and the **API
key**.

## 1. Set the base URL

Enter the endpoint's OpenAI‑compatible base URL, for example:

- DeepSeek: `https://api.deepseek.com/v1`
- A self‑hosted server: whatever address it listens on (e.g.
  `http://my-llm-host:8000/v1`).

Point the base URL **only at trusted endpoints** and prefer **HTTPS** — this is an
admin‑configured outbound target, so treat it with the same care as any other.

## 2. Store the API key as a secret

Where the endpoint requires a key, keep it in an environment variable exposed
through a **Key** entity rather than a plain configuration field.

1. Save the value with DDEV (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --openai-compatible-key=<your-key>
   ddev restart
   ```

2. Confirm the container sees it *without* printing it:

   ```bash
   ddev exec 'test -n "$OPENAI_COMPATIBLE_KEY" && echo set'
   ```

3. Create a Key entity backed by that variable at **Configuration → System →
   Keys** (`/admin/config/system/keys`) using the **Environment** key provider,
   then select it on the provider settings form.

For a **local endpoint that needs no key**, you can leave the credential empty.

## 3. Pick a model and select the provider

Enter or select a **model name the endpoint serves** (for example a DeepSeek model
id, or the name of the model your local server has loaded). Then choose this
provider for whichever AI operations you want it to power in the AI module's
settings.

## Security notes

- **Base URL is admin‑configured** — point only at trusted endpoints, use HTTPS.
- **Store the API key as a secret** (Key entity / env var), never plain config.
- **Prompts sent leave the site** for a cloud endpoint; a **self‑hosted / local**
  endpoint keeps that data in‑house, which is the main reason to choose one.
