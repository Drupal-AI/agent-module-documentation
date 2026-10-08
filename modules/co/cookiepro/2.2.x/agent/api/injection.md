<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How CookiePro injects the script

All logic is in `cookiepro_page_attachments_alter()` (an implementation of
`hook_page_attachments_alter()`) in `cookiepro.module`. There is no service or plugin.

## Flow

1. Read `cookiepro.header.settings` → `scripts` (the raw markup you saved). If empty, do
   nothing.
2. Strip HTML comments (`<!-- ... -->`) from the input.
3. Split the remaining string on `</script>` / `</noscript>` so each tag is handled
   separately.
4. For each fragment, detect whether it is a `<script>` or `<noscript>`, extract the inner
   value and parse the opening-tag attributes (`src`, `type`, `charset`,
   `data-domain-script`, …).
5. Append an `html_head` render element per fragment:

```php
$attachments['#attached']['html_head'][$i] = [
  ['#type' => 'html_tag', '#tag' => $script_tag, '#value' => $value, '#attributes' => $attrs],
  'cookiepro-' . $i,
];
```

The result is that each pasted `<script>`/`<noscript>` tag is rendered into the page
`<head>` on **every** request (the hook runs for all pages).

## Implications for agents

- The injected markup is **not sanitized** beyond comment stripping — it is trusted admin
  input. Verifying "is CookiePro configured/active on this site?" means reading
  `cookiepro.header.settings.scripts` and checking it is non-empty.
- There is no allow/deny per route, per role, or per path — it is global for all visitors.
- To confirm what will render, inspect the config value, not the page cache; the tags are
  rebuilt from config on each request.
