# Automatic logging (hooks it implements)

Enabling the module makes it log events with no code changes. These are the hooks in
`elogger.module` that produce or manage log entries — relevant if you need to predict what gets
logged or integrate with it.

## Entity CRUD

| Hook | Effect |
|------|--------|
| `hook_entity_insert` | Logs `entity_create` for the saved entity. |
| `hook_entity_update` | Logs `entity_update` (includes a diff for content entities). |
| `hook_entity_delete` | Logs `entity_delete`. |
| `hook_entity_presave` | For existing entities, stashes the **original** entity in the session under key `id().uuid()` so the update diff can be computed later. Requires a started session. |

Each of the three CRUD hooks calls `_log_entity_event()`, which sets a `__elogger_logged` flag on
the entity to avoid double-logging when an entity is saved twice in one request (e.g. blocks, node
forms). An event is only recorded if the entity's owning **module** is enabled in
`elogger.settings:modules` (see [../configure/configuration.md](../configure/configuration.md)).

## Form submissions

`hook_form_alter` prepends a global submit handler `_add_form_submit_log` to **every** form, which
logs an `actions` event capturing the serialized submitted values. Excluded up front (never logged):

- `views-exposed-form-elogger-elogs` (the log listing's own exposed filter)
- `user_login_form`
- `user_register_form`
- `commerce_checkout_flow_multistep_default`

Beyond that list, an individual form is only stored if its id matches `actions_forms` (or
`actions_forms === '*'`). The same hook also rewrites the log listing's exposed `module` and
`event_type` filters into select dropdowns.

## Retention (cron)

`hook_cron` prunes the `elog` table to `elogger.settings:elogger_row_limit` rows, deleting the
oldest by `id`. `0` disables pruning (keep all). Nothing else prunes the table, so a value must be
set for the table not to grow unbounded.

## View rendering & syslog page

- `hook_views_pre_render` (view id `elogger`): unserializes each row's `diff` / `form_data`
  (with `allowed_classes` restricted to `TranslatableMarkup`) and replaces them with rendered
  diff tables / jsonpanel output.
- `hook_form_system_logging_settings_alter` adds the syslog `format`/`output_type` controls to
  core's *Logging and errors* page when the `syslog` module is enabled.

## Tokens & help

`hook_token_info` / `hook_tokens` register the `elogger` token type (see
[../api/logger.md](../api/logger.md)); `hook_help` provides the `help.page.elogger` text.
