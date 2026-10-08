# Configure Pathologic

Pathologic is a **filter plugin**, not an entity. You use it in two steps: enable it on a text
format, then choose where its settings come from (global or per-format).

## 1. Enable the filter on a text format

At **Admin → Config → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit a format and enable **"Correct URLs with Pathologic"**
(plugin id `filter_pathologic`). Because it rewrites finished markup, drag it to be the **last**
filter in the **"Filter processing order"** list. The plugin ships with weight `50` to encourage
this. It is a `TYPE_TRANSFORM_IRREVERSIBLE` filter and processes URLs in the `href`, `src`,
`srcset`, `action`, and `longdesc` HTML attributes.

Per-format the filter has one choice — **Settings source** (`settings_source`): `global` (default)
or `local` (custom settings for this text format). With `local`, the same fields below are stored
under `local_settings` in that format's `filter_settings.filter_pathologic` config.

## 2. Global settings — `pathologic.settings`

Edit at `/admin/config/content/pathologic` (route `pathologic.config_form`, permission
`administer filters`) or via `drush cset pathologic.settings <key> <value>`. Defaults from
`config/install/pathologic.settings.yml`:

| Key | Default | Meaning |
|---|---|---|
| `protocol_style` | `full` | Output format: `full` (`http://example.com/foo/bar`), `proto-rel` (`//example.com/foo/bar`), or `path` (`/foo/bar`, relative to server root) |
| `local_paths` | `''` | One base path/URL per line for every location the site is or was served at (e.g. a staging URL). Links written against these are recognized and corrected. |
| `keep_language_prefix` | `true` | Only shown/used when core **Language** is enabled. If unchecked, language prefixes such as `/fr` are stripped from rewritten URLs. |
| `scheme_allow_list` | `['http', 'https', 'files', 'internal']` | URL schemes Pathologic will process. **No UI** — set via config/drush only. `files` and `internal` exist for legacy Path Filter compatibility. |

Choosing `protocol_style`:

- `full` — best for stopping broken links/images in syndicated content (RSS), but problematic on
  sites reachable by both HTTP and HTTPS.
- `proto-rel` — avoids HTTP/HTTPS mixing; older feed readers may not understand it.
- `path` — safest for dual HTTP/HTTPS with no compatibility concerns, but does **not** fix links in
  syndicated content (no host in the URL).

Settings are a config object, so they export/deploy with `drush config:export`. Schema:
`config/schema/pathologic.schema.yml` (`pathologic.settings` and `filter_settings.filter_pathologic`).

> Note: global settings only affect formats whose filter is set to **"Use global Pathologic
> settings"**. Formats using per-format settings ignore them.
