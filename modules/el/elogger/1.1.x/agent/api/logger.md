# The `elogger.logger` service (logging API)

Service id **`elogger.logger`** → `Drupal\elogger\Services\Elogger` (extends diff's
`UnifiedFieldsDiffLayout`). This is the public API for writing a log event. The module's own hooks
call it automatically (see [../hooks/automatic-logging.md](../hooks/automatic-logging.md)); call it
directly to log from your own code.

## Public methods

| Method | Purpose |
|--------|---------|
| `setEntity(EntityInterface $entity)` | Set the entity context for the next `logEvent()`. |
| `setForm(array $form, FormStateInterface $form_state)` | Set the form context for an `actions` event. |
| `logEvent(string $event_type)` | Write the log. `$event_type` ∈ `entity_create`, `entity_update`, `entity_delete`, `actions`. |
| `getEventTypes(): array` | Map of the four event-type ids → translated labels. |
| `buildDiffOutput(array $diff)` | Render a stored (unserialized) entity diff as a table (used by the view). |
| `buildFormData(array $form_data): MarkupInterface` | Render serialized form values as a collapsible jsonpanel (attaches library `elogger/elogger-jsonpanel`). |

## Usage

```php
$elog = \Drupal::service('elogger.logger');

// Log an entity CRUD event:
$elog->setEntity($node);
$elog->logEvent('entity_create');

// Log a form submission (also captures the submitted values):
$elog->setForm($form, $form_state);
$elog->logEvent('actions');
```

## What `logEvent()` does

1. For an entity event, derives the owning **module** from the entity class namespace
   (`Drupal\<module>\...`) and **returns early if that module is not in `elogger.settings:modules`**.
   Own `Elog` entities are always skipped (no recursion).
2. For `actions`, requires a form context; **returns early unless the form id is listed in
   `actions_forms` or `actions_forms === '*'`**. Serializes `$form_state->getValues()` into `form_data`.
3. On `entity_update` of a content entity, builds a serialized **diff** from the pre-save original
   (captured in the session by `hook_entity_presave`) using `diff.entity_comparison`.
4. Renders the message from `log_message_templates[$event_type]` via the token service + the built-in
   `{entity_type}`/`{entity}`/`{user}`/`{form_id}` placeholders.
5. Creates and saves an **`elog`** entity (always) capturing `event_type`, `user`, `module`,
   `diff`, `log_message` (with `elogger_text_format`), `form_data`, `ip`
   (`Request::getClientIp()`), `user_agent` (`User-Agent` header).
6. **If the `syslog` module is enabled**, also sends the message to the `eventlog` logger channel
   (which the `logger.eventlog` service turns into a syslog/watchdog line).

## What gets stored — the `elog` entity

Content entity `elog`, base table `elog`, canonical `/admin/reports/elogger/elog/{elog}`. Base fields:

| Field | Type | Notes |
|-------|------|-------|
| `id`, `uuid` | integer / uuid | Read-only ids. |
| `log_message` | text_long | Rendered message (format = `elogger_text_format`). |
| `diff` | string_long | Serialized entity diff (updates only). |
| `form_data` | string_long | Serialized `$form_state->getValues()` (form events). |
| `event_type` | string | e.g. `entity_update`. |
| `module` | string | Context module. |
| `user_id` | entity_reference → user | Owner (set to current user on create). |
| `ip` | string | Client IP. |
| `user_agent` | string | Browser User-Agent. |
| `langcode`, `created`, `changed` | language / created / changed | Standard. |

## Syslog/watchdog forwarder — `logger.eventlog`

Service id **`logger.eventlog`** → `Drupal\elogger\Logger\EventLog` (a PSR `LoggerInterface`).
`logEvent($log)` formats the line with the `elogger.settings:format` token string, then:
- `output_type == 'syslog'` → writes to the OS syslog via `openlog()`/`syslog()`;
- otherwise (and not CLI) → logs through the `elogger` logger channel (dblog/watchdog).

## Tokens

The module registers an **`elogger`** token type (`hook_token_info`/`hook_tokens`) with tokens
`log_message`, `event_type`, `module`, `user` (chains to `user:*`), `created`, `changed`
(chain to `date:*`). Used in the `format` string for syslog/watchdog output.
