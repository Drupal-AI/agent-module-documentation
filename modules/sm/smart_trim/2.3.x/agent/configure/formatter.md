# Configure the "Smart trimmed" formatter

Not a global admin form. Set per field: **Manage display** for the bundle
(`/admin/structure/types/manage/<bundle>/display`, and each view mode) → pick format
**"Smart trimmed"** → gear icon. Stored in the display config's
`content.<field>.settings` (schema `field.formatter.settings.smart_trim`), so it exports with
the entity view display and can be set via `drush config:set core.entity_view_display.<...>`.

Settings (key → default → meaning):

| Key | Default | Meaning |
|---|---|---|
| `trim_length` | `600` | How much to keep. Required, min 0. |
| `trim_type` | `chars` | Unit: `chars` or `words`. |
| `trim_suffix` | `''` | Appended when trimmed (e.g. `…`; supports `\uXXXX`). |
| `summary_handler` | `full` | Only shown for `text_with_summary`: `full` (use summary, no trim), `trim` (use summary, honor trim), `ignore` (never use summary). |
| `wrap_output` | `false` | Wrap output in a div. **Deprecated**, removed in 3.0 — override the template instead. |
| `wrap_class` | `trimmed` | Class for that wrapper div (only if `wrap_output`). |
| `trim_options.text` | off | Strip all HTML → plain text excerpt. |
| `trim_options.trim_zero` | off | Honor a `trim_length` of 0 (suppress output). |
| `trim_options.replace_tokens` | off | Run token replacement on content before trimming. |
| `more.display_link` | `false` | Show a "Read more" link to the entity's canonical URL. |
| `more.text` | `More` | Link text (supports tokens). |
| `more.link_trim_only` | `false` | Show link only when content was actually trimmed. |
| `more.target_blank` | `false` | Open link in a new window. |
| `more.class` | `more-link` | CSS class on the link. |
| `more.aria_label` | `Read more about [node:title]` | aria-label (supports tokens). |

Notes: truncation is HTML-aware (unclosed tags are repaired) via `smart_trim.truncate_html`.
The more link only renders if the entity has an `id` and a `canonical` link template. Fields
supported: `text`, `text_long`, `text_with_summary`, `string`, `string_long`.
