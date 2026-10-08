<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sentiment dimensions — config, routes, forms

Dimensions ("sentiments metrics") are stored in the config object
**`analyze_ai_sentiments.settings`** under key `sentiments` — NOT in a database table. Each entry:
`id`, `label`, `min_label`, `mid_label`, `max_label`, `weight`.

## Install defaults
`config/install/analyze_ai_sentiments.settings.yml` ships four dimensions: `trust` (Trust &
Credibility), `objectivity` (Objectivity & Bias), `audience_vibe_check` (Audience Vibe Check),
`reading_level` (CEFR Reading Level). NOTE: `hook_install` (`.install`) sets a **different** legacy
default set (`overall`, `engagement`, `trust`, `objectivity`, `complexity`) only when no `sentiments`
config already exists — the same legacy set is also the hardcoded fallback in
`SentimentsStorageService::getDefaultSentiments()`. On a normal install the shipped YAML wins.

## Config schema
`config/schema/analyze_ai_sentiments.schema.yml`:
- `analyze_ai_sentiments.settings` — `config_object`; `sentiments` sequence of mappings
  (`id`/`label`/`min_label`/`mid_label`/`max_label` labels + integer `weight`).
- Also declares `analyze_ai_sentiments.entity_settings`, `analyze.entity_settings.*.analyzers.
  ai_sentiments_analyzer.settings`, and `analyze.plugin_settings.*.*.*` (the per-bundle enabled-map
  the analyzer actually reads/writes).

## Routes (`analyze_ai_sentiments.routing.yml`) — all `_permission: administer site configuration`
- `analyze_ai_sentiments.settings` — `/admin/config/analyze/sentiments` → `SentimentsSettingsForm`
  (the `configure` route).
- `analyze_ai_sentiments.add_sentiments` — `/admin/config/analyze/ai-sentiments/add` →
  `AddSentimentsForm`.
- `analyze_ai_sentiments.delete_sentiments` — `/admin/config/analyze/ai-sentiments/{sentiments_id}/delete`
  → `DeleteSentimentsForm` (a `ConfirmFormBase`).

Menu/task/action links in `analyze_ai_sentiments.links.*.yml`.

## Forms (`src/Form/`)
- **`SentimentsSettingsForm`** (`analyze_ai_sentiments_settings`): a tabledrag table of all dimensions
  — edit label + range labels, reorder by `weight`, per-row Delete operation link. Submit saves each
  row via `storage->saveSentiment()`. Shows a "View reports" button when the user has `access site
  reports` and the report route is accessible.
- **`AddSentimentsForm`** (`analyze_ai_sentiments_add_sentiments`): machine_name `id` (uniqueness via
  `sentimentsExists()` → `storage->sentimentExists()`), `label`, `min_label`, `mid_label`,
  `max_label`; new dimension gets `max(existing weight)+1`.
- **`DeleteSentimentsForm`** (`analyze_ai_sentiments_delete_sentiments`): standard confirm form;
  unsets the dimension from `analyze_ai_sentiments.settings`.

## Save/delete side effects
`storage->saveSentiment()` and `deleteSentiment()` write the config **and** call
`invalidateConfigCache()`, which deletes every cached result row whose `config_hash` differs from the
new one — so editing/adding/removing a dimension purges stale cached scores. (Direct config edits or
`DeleteSentimentsForm::submitForm`, which writes config directly, do not call it; the config hash
still changes so future reads miss the cache.)
