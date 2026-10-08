<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AGROVOC Field (agrovocfield) — agent index

Auto-suggests **AGROVOC** concept tags for a **taxonomy reference field** from another field's text,
by calling an **admin-configured self-hosted AgroTagger** service on interactive save. D11 port of
the D7 `agrovocfield_automatic` submodule. Version **1.0.2**, core `^10.3 || ^11`, package `Fields`,
license GPL-2.0-or-later. Depends on core **`taxonomy`** and **`field`**. **No permissions of its
own** (settings route uses core `administer site configuration`); no Drush.

- **Enabling automatic indexing, the widget settings, the save-time flow, the HTTP client, and
  config** → [fields/automatic-indexing.md](fields/automatic-indexing.md)

## What it actually is (from source)

- **Not a field type/widget/formatter.** It adds a **third-party setting** ("AGROVOC automatic
  indexing") to two existing "tags style" widgets and attaches an `#element_validate` callback.
  Implemented entirely in `agrovocfield.module` (hooks) + one service.
- **Supported widgets** (`AGROVOCFIELD_SUPPORTED_WIDGETS`, allowlist):
  `entity_reference_autocomplete_tags` (core) and `tagify_entity_reference_autocomplete_widget`
  (Tagify contrib). Applies only when the field's `target_type` is `taxonomy_term`.
- **Hooks:** `agrovocfield_field_widget_third_party_settings_form()` (enabled / source_field /
  max_tags), `..._settings_summary_alter()`, `..._complete_form_alter()` (attaches
  `#agrovocfield` + `_agrovocfield_validate`).
- **Save flow** (`_agrovocfield_validate`): only when the field is empty; reads the just-submitted
  source-field text (`strip_tags`), calls `agrovocfield.tagger_client`, slices to `max_tags`, then
  `loadByProperties`/`create` terms in the single target vocabulary and injects them in each
  widget's raw value shape.
- **Service:** `src/AgroTaggerClient.php` (`agrovocfield.tagger_client`, args
  `@http_client @config.factory @logger.channel.agrovocfield`) — `tag(string)` POSTs
  `{text}` to `<service_url>/tag` (default `http://agrotagger:8080`) with a configurable timeout;
  failures are logged and degrade to an empty list.
- **Config route** `agrovocfield.settings` → `/admin/config/content/agrovocfield`, permission
  `administer site configuration`. Config object `agrovocfield.settings` (`service_url`, `timeout`);
  schema also defines `field.widget.third_party.agrovocfield`.

## Files

- `agrovocfield.module` — all hooks, the `_agrovocfield_validate` callback, `_agrovocfield_*`
  helpers, `_agrovocfield_normalize_uri()`.
- `src/AgroTaggerClient.php` — HTTP client. `src/Form/SettingsForm.php` — settings form.
- `config/install/agrovocfield.settings.yml`, `config/schema/agrovocfield.schema.yml`,
  `agrovocfield.routing.yml`, `agrovocfield.services.yml`, `agrovocfield.links.menu.yml`.

See [../usage.md](../usage.md) for prose and use cases.
