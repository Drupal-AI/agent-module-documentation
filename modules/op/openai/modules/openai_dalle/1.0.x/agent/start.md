# OpenAI DALL·E (openai_dalle) — agent index

Adds an admin form to generate images with OpenAI's DALL·E endpoint (DALL·E 3 or DALL·E 2) through
the parent `openai.api` service. It is an explorer/utility form, not a field type or block.

Dependency: `openai:openai`. `configure` = `openai_dalle.dalle_form`. Defines one permission; no
config object, schema, or Drush of its own.

- **Generate an image / the DALL·E form (models, size, quality, style, output)** → [configure/dalle_form.md](configure/dalle_form.md)
- **Who can use it** → [permissions/permissions.md](permissions/permissions.md)

Parent (shared OpenAI client/service + API-key config): [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md).

Key facts:
- Route `openai_dalle.dalle_form` → `/admin/config/openai/dalle`, form
  `\Drupal\openai_dalle\Form\DalleForm`, requirement `_permission: 'access openai dalle'`.
- Permission `access openai dalle` (`openai_dalle.permissions.yml`).
- Calls `openai.api` → `OpenAIApi::images($model, $prompt, $size, $response_format, $quality, $style)`.
- Model options come from `filterModels(['dall'])`; default `dall-e-3`.
- `response_format` `url` returns the OpenAI image URL; `b64_json` decodes and saves a permanent
  `public://<filename>.png` File entity owned by the current user.
- Menu link under the OpenAI admin group (`openai.admin_config_openai`).
