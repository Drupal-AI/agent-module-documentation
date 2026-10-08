# The `iframeremove_filter` filter plugin

Source: `src/Plugin/Filter/IframeRemoveFilter.php`. A single core-filter plugin (extends `FilterBase`),
type `TYPE_TRANSFORM_IRREVERSIBLE`. It removes `<iframe>` elements at render time unless their `src`
hostname is allowlisted.

## Enable & configure

There is no admin route of its own (`configure` null). Configure it per text format:

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`), edit a format (e.g. Full HTML).
2. Enable **iFrame remove filter** under *Enabled filters*.
3. Under *Filter settings* fill the **Whitelist** textarea: one domain per line. Only iframes whose
   `src` host matches an entry are kept.
4. Order it after the HTML-limiting/WYSIWYG filters in *Filter processing order*.

Stored in `filter.format.<format>.filters.iframeremove_filter.settings.iframeremove_whitelist`
(schema `filter_settings.iframeremove_filter`; default setting `''`).

## Whitelist format & matching

- One domain per line (split on runs of newlines/whitespace). Empty whitelist = **all** iframes removed.
- Each entry is normalized in `iframeRemoveMapRegex()`: leading `^` / trailing `$` stripped, then
  `preg_quote`, then literal `*` → `.*?`, wrapped as `/^<entry>$/`.
- So `youtube.com` matches only host `youtube.com`; use `*.youtube.com` (or `*youtube.com`) to allow
  subdomains, and `*` matches anything. Matching is against the parsed **host only** (`parse_url(..., PHP_URL_HOST)`).

## Processing logic (`process()`)

1. `process($text)` calls `iframeRemoveIframe()` with the compiled regex list.
2. Fast path: if the text has no `<iframe` (case-insensitive), return unchanged (avoids DOM load).
3. Otherwise `Html::load($text)` → iterate `getElementsByTagName('iframe')`. For each with a `src`,
   extract host; if host is empty or matches **no** whitelist regex, mark for removal.
4. Remove marked iframes from the DOM; if any were removed, return `Html::serialize($dom)`, else the
   original string.

Notes for agents:
- Iframes **without** a `src` attribute are left untouched (only `src` iframes are inspected).
- Because the type is irreversible, the transformation happens on display and is not designed to be
  reversed; keep it out of formats meant to preserve exact source markup.
- The filter's `tips()` describes it as a security filter that "removes unsafe iframes from page display".
