# The `filter_elf` text filter

`Drupal\elf\Plugin\Filter\FilterElf` — plugin id `filter_elf`, title "Add an icon to external
and mailto links", type `TYPE_MARKUP_LANGUAGE`. It runs inside a text format's filter pipeline
and rewrites the rendered `<a>` markup; the stored text is unchanged.

## Enable it
Enable per text format at `/admin/config/content/formats/manage/<format>`: check
**"Add an icon to external and mailto links"**, set its per-filter options, and (because it
adds classes/attributes) place it where it will not be stripped by a "Limit allowed HTML tags"
filter. It attaches the `elf/elf_css` library to output so the icon CSS loads.

## Per-filter settings (`settingsForm`)
Stored in the format's filter config under `filters.filter_elf.settings`.

| Setting | Default | Effect on external links |
|---|---|---|
| `elf_nofollow` | `false` | adds `nofollow` to `rel` |
| `elf_noopener` | `false` | adds `noopener` to `rel` |
| `elf_noreferrer` | `false` | adds `noreferrer` to `rel` |

Existing `rel` tokens are preserved; each enabled token is appended only if not already present.

## Runtime behavior (`process()`)
Loads the HTML with `Html::load()`, walks every `<a>`, and for each with a non-empty `href`:

- **`mailto:` link** (href starts with `mailto:`): adds classes `elf-mailto <icon_class>`, then
  skips the rest.
- **External link** (`elf_url_external($href)` true): adds classes `elf-external <icon_class>`;
  if the link wraps an `<img>`, also adds `elf-img`. Then, from `elf.settings`:
  - `elf_window` → sets `target="_blank"`.
  - `elf_accessible` → appends `<span class="screen-reader-only">external link</span>`
    (text becomes "external link, opens in a new tab" when `elf_window` is also on).
  - the three per-filter `rel` tokens are merged into `rel`.
  - `elf_redirect` → replaces `href` with `elf.manager->getRedirectUrl($href)->toString()`
    (see [../api/redirect.md](../api/redirect.md)).

`<icon_class>` is the module-wide `elf_icon_class` config value (default `elf-icon`), not a
per-filter setting. Output is re-serialized with `Html::serialize()`.

### How "external" is decided — `elf_url_external($url)`
Builds a regex from the `elf_domains` config plus the global `$base_url` (each `preg_quote`d,
with `*` treated as a wildcard `.*`). A URL matching any of those prefixes is treated as
internal; otherwise the result of `UrlHelper::isExternal($url)` decides. So relative/site-local
links and links to any configured internal domain are left untouched.
