# Configuration

LangFuse needs to know **where** your LangFuse instance is and **how** to
authenticate to it. You configure both on one settings form, and the module tests
the connection for you when you save.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → System → LangFuse → Settings**
   (`/admin/config/system/langfuse/settings`).

## The settings

- **LangFuse URL** — the address of your LangFuse instance. For LangFuse Cloud this
  is typically `https://cloud.langfuse.com`; for a self‑hosted setup, enter your own
  URL. Always use `https://` so credentials and trace data travel encrypted.
- **Authentication method** — choose one:
  - **API key pair** *(recommended)* — a public/secret key pair from your LangFuse
    project settings.
  - **Bearer token** — a single token.
  - **Basic auth** — username/password style credentials.
  Self‑hosted LangFuse is fully supported with any of these.
- **Credentials** — enter the keys, token, or username/password matching the method
  you chose. You'll find these in your LangFuse **project settings**.

## Save and confirm

Click **Save configuration**. The module **tests the connection automatically**, so
you'll know straight away whether Drupal can reach LangFuse with the details you
supplied.

## Keep the credentials secret

Treat your LangFuse keys/token as secrets. Prefer storing them in an environment
variable rather than in configuration that is exported and committed. With DDEV:

```bash
ddev dotenv set .ddev/.env --langfuse-secret-key=YOUR_SECRET_KEY
ddev restart
```

The flag `--langfuse-secret-key` becomes `LANGFUSE_SECRET_KEY` in the container —
**never commit `.ddev/.env`**. You can then surface it through a **Key** entity
(`ddev composer require drupal/key && ddev drush en key -y`) and reference that Key
from the settings form where it supports one, so the secret is read from the
environment rather than stored in configuration.

## Before you go live — the data‑egress question

Enabling LangFuse means your AI **prompts and responses** are sent off‑site to the
LangFuse service, and that content can include sensitive information or personal
data (PII). Before turning it on in production:

- Confirm it is acceptable for that content to leave your site.
- Disclose the practice in your privacy policy where appropriate.
- If the data must stay within your own infrastructure, run a **self‑hosted**
  LangFuse instance and point the LangFuse URL at it.

## How automatic tracking works

With the `langfuse_ai_logging` submodule enabled (see
[Installation](../installation/index.md)), AI module interactions are logged
automatically — programmatic calls, the AI Explorer, and any AI integration such as
chat forms or embeddings — with no code changes. Traces appear in your LangFuse
project with full detail: prompts, responses, timing, token usage, tool calls, and
nested spans for downstream operations.
