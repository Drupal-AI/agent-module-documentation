# Settings & runtime

## Config object `openai_dblog.settings` (schema `openai_dblog.schema.yml`)

| Key | Type | Install default | Meaning |
|-----|------|-----------------|---------|
| `levels` | mapping (sequence of strings) | `{Emergency, Alert, Critical, Error}` | Which RFC log-level labels get an OpenAI explanation. |
| `model` | string | `text-davinci-003` | OpenAI model used for the explanation. |

Settings form: route `openai_dblog.settings` → `/admin/config/openai/openai-dblog/settings`,
`\Drupal\openai_dblog\Form\SettingsForm` (form id `openai_dblog_settings`),
`_permission: 'administer site configuration'`.
- `levels` is a checkboxes element built from `RfcLogLevel::getLevels()`; saved via
  `array_filter()` (only checked labels persist).
- `model` options come from the parent `openai.api` `filterModels(['gpt', 'text'])`.

Set via Drush:

    drush cset openai_dblog.settings model gpt-4o -y
    drush cset openai_dblog.settings levels.Error Error -y

## How the analysis works

`openai_dblog.route_subscriber` (`RouteSubscriber::alterRoutes`) repoints the core `dblog.event`
route to `OpenAIDbLogController::eventDetails()`, which extends core `DbLogController`. On the log
detail page:

1. Renders the normal dblog table, reads the event's severity (row 6) and message (row 5).
2. If the severity label is **not** in the enabled `levels`, returns unchanged (no API call).
3. Truncates the message to 256 chars and computes `hash('sha256', $message)`.
4. Looks it up in the `{openai_dblog}` table. **Cache hit** → renders the stored `explanation`
   (`nl2br`) as a new "Explanation (powered by OpenAI)" row; no API call.
5. **Cache miss** → builds a prompt asking what the Drupal error means and how to fix it, then:
   - `str_contains($model, 'gpt')` → `OpenAIApi::chat($model, $messages, 0.4, 3900)` with a
     system role of a "PHP, Drupal 9/10 expert";
   - otherwise → `OpenAIApi::completions($model, $prompt, 0.4, 2048)`.
   The result is stored via `insertExplanation()` (`strip_tags()`'d) and rendered.

## Storage

`openai_dblog.install` `hook_schema()` defines table `openai_dblog`:

| Column | Type | Notes |
|--------|------|-------|
| `id` | serial | PK. |
| `hash` | varchar_ascii(256) | sha256 of the truncated message; unique key + index. |
| `message` | text big | The truncated log message. |
| `explanation` | text big | OpenAI answer (tags stripped). |

Because answers are keyed by message hash, repeated occurrences of the same error reuse the cached
explanation instead of re-calling OpenAI. Analysis is reached through the core dblog event page,
which requires the `access site reports` permission.

Parent service reference: [../../../../../1.0.x/agent/api/service.md](../../../../../1.0.x/agent/api/service.md).
