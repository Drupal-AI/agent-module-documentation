# OpenAI Error Log Analyzer (openai_dblog) — agent index

Adds an "Explanation (powered by OpenAI)" row to Drupal's database-log (dblog) event detail page:
for enabled severity levels it asks OpenAI what the error means and how to fix it, then caches the
answer. Uses the parent `openai.api` service.

Dependencies: `dblog`, `openai:openai`. `configure` = `openai_dblog.settings`. Provides a config
object + schema and its own DB table; no permissions or Drush of its own.

- **Choose which log levels/model are analyzed; how the analysis + caching works** → [configure/settings.md](configure/settings.md)

Parent (shared OpenAI client/service + API-key config): [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md).

Key facts:
- Config `openai_dblog.settings`: `levels` (mapping of enabled RFC level labels) + `model` (default
  install value `text-davinci-003`). Schema `openai_dblog.schema.yml`.
- Settings form route `openai_dblog.settings` → `/admin/config/openai/openai-dblog/settings`,
  `\Drupal\openai_dblog\Form\SettingsForm`, `_permission: 'administer site configuration'`.
- Service `openai_dblog.route_subscriber` (`\Drupal\openai_dblog\Routing\RouteSubscriber`) overrides
  the `dblog.event` route controller with `\Drupal\openai_dblog\Controller\OpenAIDbLogController::eventDetails`.
- Analysis runs on the dblog event page (core permission `access site reports`); `gpt*` models use
  `OpenAIApi::chat()`, other models use `OpenAIApi::completions()`.
- Answers are cached in the `openai_dblog` table (`hash`,`message`,`explanation`) keyed by a
  sha256 hash of the truncated message (`hook_schema` in `openai_dblog.install`).
