# Configuration

LM Studio Provider is configured from its own settings form, reachable under
**Configuration → AI** (`/admin/config/ai`) or via the **Configure** link beside
the module on the **Extend** page. You need the **Administer AI providers**
permission (an administrator by default).

## Point the provider at your LM Studio server

The one setting that matters is the **endpoint / base URL** of your LM Studio
local server. In LM Studio, load a model and start its local server; it will show
you a base URL, commonly:

```
http://localhost:1234/v1
```

Enter that URL in the provider's settings form. If Drupal and LM Studio run on
different hosts (for example Drupal in a DDEV container and LM Studio on your
workstation), use the address that the Drupal process can actually reach — not
`localhost`, which inside a container points at the container itself.

## Credentials — usually not needed

A local LM Studio server typically does **not** require an API key, so you can
often leave the credential empty. If you have put an authenticating proxy in
front of LM Studio, or otherwise require a token, follow the project convention
and store that secret in an environment variable exposed through a **Key**
entity rather than typing it into a plain configuration field:

1. Save the value with DDEV: `ddev dotenv set .ddev/.env --lmstudio-key=<value>`
   then `ddev restart` (never commit `.ddev/.env`).
2. Create a Key entity backed by the env variable (install the Key module first
   if needed) and select that Key in the provider settings.

## Choose the model and select the provider

The models available are those you have **loaded in LM Studio**. Once the
endpoint is saved and reachable, select **LM Studio** as the provider — and one
of its models — for whichever AI operation you want to run locally (chat,
completions, and so on), either as a per‑operation default in the AI module's
settings or wherever a given feature lets you pick a provider.

## Security notes

- Point the provider **only at a trusted local endpoint**. The base URL is
  admin‑configured, so treat it like any other outbound target.
- If the LM Studio server is reachable over a network rather than just
  `localhost`, secure it with authentication or network isolation.
- The payoff: because inference runs on your own hardware, **prompts stay on your
  infrastructure** — a genuine data‑handling advantage for sensitive content.
