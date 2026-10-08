<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Text-format filter: `env_link_fixer_strip_domain`

Class `\Drupal\env_link_fixer\Plugin\Filter\RewriteOwnDomainLinks`
(`src/Plugin/Filter/RewriteOwnDomainLinks.php`), extends core `FilterBase`.

- `@Filter` id **`env_link_fixer_strip_domain`**, title *"Convert absolute URLs to relative for some
  domains"*, `type = TYPE_TRANSFORM_IRREVERSIBLE`, `weight = 99` (runs late in the filter pipeline).
- Per-instance setting **`domain_names`** (string, default `''`) — same `hostname|domain,domain` storage
  format as the site-wide config (see [../config/settings.md](../config/settings.md)). Editable via
  `settingsForm()` (a textarea) on the text-format's filter settings.

## Enable it

Enable the filter on a text format at `/admin/config/content/formats/manage/<format>` and set its
*Domain names* mapping (or leave empty to use the site-wide `env_link_fixer.settings:mapping`).

## Processing (`process($text, $langcode)`)

1. If `env_link_fixer_disabled()` -> returns `$text` unchanged.
2. Reads `$this->settings['domain_names']`; if empty, uses `[]` (falls back to standard mapping later),
   else parses it with `env_link_fixer_convert_storage_to_array()`.
3. Calls `env_link_fixer_strip_domain($text, '', $domain_names)` and wraps the result in a
   `FilterProcessResult`.

## The rewrite (`env_link_fixer_strip_domain()` in `env_link_fixer.module`)

- Resolves the domain list via `env_link_fixer_domains_to_strip('', $domain_names)` (defaults to the
  request host + standard mapping when the passed list is empty). If empty, returns text unchanged.
- For each mapped domain it builds the regex:
  `!((<a\s[^>]*href)|(<img\s[^>]*src))\s*=\s*"http(s)?://<preg_quote(domain)>!iU`
  and, for every match, `str_replace`s the matched prefix with just `<a ...href="` / `<img ...src="` —
  i.e. it **deletes the scheme+domain**, leaving the path so the URL becomes root-relative.

So `<a href="https://www.example.com/foo">` becomes `<a href="/foo">`. It only strips domains present in
the mapping; it never substitutes one domain for another. The domain string is `preg_quote`d before use.

`tips()` returns a short static help string. This filter is irreversible (applied to cached, filtered
output only).
