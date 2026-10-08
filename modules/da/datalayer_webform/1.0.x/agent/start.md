# Datalayer Webform — agent index

A single Webform handler that pushes a configurable `dataLayer` event on webform submission (for
GTM/analytics). Depends on `datalayer` + `webform`. No config UI page, no permissions, no Drush —
configured per-webform on the handler.

- **The handler, the YAML event field, token replacement, and the JS push** →
  [configure/handler.md](configure/handler.md)

Key facts:
- Handler plugin `datalayer_webform` (`WebformHandler`), cardinality UNLIMITED, tokens enabled.
- Config: one `event` key (YAML). Decoded on submit, `replaceTokens()` fills Webform/site tokens.
- Result exposed as `drupalSettings.datalayer_webform.event`; `js/event.js` calls
  `dataLayer.push(event)` once per `.webform-submission-form`.
- `dataLayer` array itself is provided by the Datalayer module. Tested mainly with modal
  confirmation.
