# Configuration

AI Core's configuration has two homes: the **main settings form** at
**Configuration → AI → Settings** (`/admin/config/ai/settings`, permission
**Administer ai**), and the **per‑provider settings** at **Configuration → AI →
Providers** (`/admin/config/ai/providers`, permission **Administer ai providers**).

## API keys go through the Key module

Before anything else: never put a vendor API key in configuration or
`settings.php`. Store it as a **Key entity** (the environment‑variable provider is
recommended) and select it in the provider's settings form. Each provider module
adds its own settings form under **Providers** where you pick the Key and the
default models — configure providers there rather than by hand, because the form
validates the Key selection and model lists against what the provider actually
supports.

## Main settings form

The AI settings form writes to the `ai.settings` config object and controls
site‑wide behavior:

- **Default providers** (`default_providers`) — a map of *operation type →
  provider + model*. This is where you set the site default for each capability:
  for example a strong model for **chat** and a cheaper one for **summarization** or
  **embeddings**. Code that asks for the default provider for an operation gets
  whatever you pick here, so switching vendors is a config change.
- **Prompt logging** (`prompt_logging`, *off by default*) — log the full prompt sent
  to providers, for auditing exactly what was sent to the LLM.
- **Prompt logging tags** (`prompt_logging_tags`) — only log requests carrying these
  tags, to keep logging focused.
- **Request timeout** (`request_timeout`, *default: 60*) — seconds before an AI HTTP
  request times out.
- **Allowed hosts** (`allowed_hosts`, *default: none*) — a security allow‑list of
  outbound hosts providers may call. Restrict this to just your provider's host.
- **Rewrite links to allowed hosts** (`allowed_hosts_rewrite_links`, *off by
  default*) — rewrite links so they point at allowed hosts.
- **Global guardrails** (`global_guardrails`) — guardrail sets applied to *every*
  request site‑wide (see below).

You can also inspect or script these with Drush, though the provider forms are
preferred for anything key‑ or model‑related:

```bash
drush config:get ai.settings
drush config:set ai.settings default_providers.chat.provider_id openai -y
drush config:set ai.settings default_providers.chat.model_id gpt-4o -y
drush config:set ai.settings allowed_hosts.0 api.openai.com -y
```

## Guardrails and prompts

AI Core defines several configuration entities you manage from the admin UI:

- **Guardrails** (`ai_guardrail`) and **guardrail sets** (`ai_guardrail_set`) —
  reusable pre/post‑processing policy applied to requests (for example restricting
  responses to a topic or blocking PII). Reference a set from **Global guardrails**
  to apply it everywhere. Gated by **Administer guardrails** and **Administer
  guardrail sets**.
- **Prompts** (`ai_prompt`) and **prompt types** (`ai_prompt_type`) — a reusable
  prompt library so you don't scatter prompt strings through code. Gated by **Manage
  ai prompts** and **Administer ai prompt types**.

## AI files

The module also provides an `ai_file` content entity for AI‑generated files (such
as generated images). There is an AI Files overview listing (permission **Access ai
files overview**), with per‑item view/delete gated by the various `* ai file(s)`
permissions.

## Permissions

AI Core defines these permissions. Most administrative ones are security‑sensitive
(they expose API credentials, spend money, or control moderation policy) — grant
them only to trusted roles.

| Permission | What it allows |
|-----------|----------------|
| **Administer ai** | The main AI settings form: defaults, logging, timeout, allowed hosts. |
| **Administer ai providers** | Per‑provider configuration, including Key selection. |
| **Access ai tools overview** | The overview listing of available AI tools. |
| **Administer ai prompt types** | Create/edit/delete prompt‑type entities. |
| **Manage ai prompts** | Create/edit/delete individual prompt entities. |
| **Administer guardrail sets** | Create/edit/delete guardrail‑set entities. |
| **Administer guardrails** | Create/edit/delete guardrail entities. |
| **Access ai files overview** | The AI Files listing. |
| **View own ai files** / **View any ai file** | View AI files you own / any AI file. |
| **Delete own ai file** / **Delete any ai file** | Delete AI files you own / any (restricted). |

```bash
drush role:perm:add administrator 'administer ai'
drush role:perm:add content_editor 'manage ai prompts'
```
