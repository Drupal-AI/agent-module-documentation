<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — UX Enhanced Autocomplete

Route: `/admin/config/user-interface/ux-enhanced-autocomplete` (form `ConfigurationForm`, permission `administer site configuration`). Config object: `ux_enhanced_autocomplete.settings`.

| Key | Meaning | Default |
| --- | --- | --- |
| `match_limit` | Max suggestions returned | 20 |
| `min_length` | Min input chars before enhanced matching runs | 1 |
| `show_entity_type` | Show bundle label | TRUE |
| `show_entity_id` | Show `#<id>` | TRUE |
| `show_date` | Show created (node) / changed (term) date | TRUE |
| `show_author` | Show owner label | TRUE |
| `date_format` | Drupal date format id used for the date part | `medium` |
| `separator` | String between info parts | ` | ` |
| `bold_entity_type` / `bold_entity_id` / `bold_date` / `bold_author` | Bold each part | FALSE |
| `enable_color` + `accent_color` | Inline color on type/ID parts | FALSE / `#045e7c` |
| `truncate_title` + `title_max_length` | Truncate long titles | TRUE / 60 |

Drush: `drush cget ux_enhanced_autocomplete.settings`, `drush cset ux_enhanced_autocomplete.settings min_length 3 -y`.

## Behavior notes
- Only `node` and `taxonomy_term` target types are enhanced; every other type is delegated to the original core matcher, as is any error case.
- Matching goes through the entity-reference **selection handler** (`getReferenceableEntities`), so field/entity access filtering is identical to core autocomplete.
- Output label is HTML: `<div class="ux-enhanced-autocomplete-item">Title<br><small>info…</small></div>`, each part `Html::escape()`d. Style via the module's CSS library (attached on all pages through `hook_page_attachments`).
- No per-field enabling is required — it applies globally to supported autocomplete fields once installed.
