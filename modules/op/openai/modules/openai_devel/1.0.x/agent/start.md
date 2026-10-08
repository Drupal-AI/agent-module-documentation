# OpenAI Devel Generate (openai_devel) — agent index

Adds a GPT-backed generator to Devel Generate: instead of Lorem Ipsum, sample nodes get titles
and string/text-field values written by OpenAI chat models through the parent `openai.api`
service. Dev/QA tooling only (info.yml `tags: developer`).

Dependencies: `openai:openai`, `devel:devel_generate`. No `configure` route, and no permissions,
config, or schema of its own — it reuses Devel Generate's UI/permission and the parent module's
API key.

- **Generate GPT content from the UI / how the plugin builds nodes** → [plugins/content_gpt.md](plugins/content_gpt.md)
- **Generate GPT content from Drush** → [drush/commands.md](drush/commands.md)

Parent (shared OpenAI client/service + API-key config): [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md).

Key facts:
- DevelGenerate plugin id `content_gpt` → `\Drupal\openai_devel\Plugin\DevelGenerate\ContentGPTDevelGenerate`
  (extends `devel_generate`'s `ContentDevelGenerate`). UI at `/admin/config/development/generate/content-gpt`.
- Plugin annotation `permission = "administer devel_generate"` — no new permission is defined; access
  is Devel Generate's own admin permission.
- Drush command `devel-generate:content-gpt` (alias `gencgpt`), service `openai_devel.commands`
  (`\Drupal\openai_devel\Commands\OpenAIDevelCommands`, argument `@plugin.manager.develgenerate`),
  registered in `drush.services.yml`.
- Generation calls `openai.api` → `OpenAIApi::chat($model, $messages, $temperature, $max_tokens)`
  once per title and once per eligible field. Default model `gpt-3.5-turbo`, temperature `0.4`,
  max_tokens `512`.
