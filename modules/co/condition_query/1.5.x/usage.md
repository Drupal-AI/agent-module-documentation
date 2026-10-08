Condition Query adds a "Request Param" condition plugin so you can show or hide blocks (and anything else that uses Drupal's Condition API) based on URL query-string parameters — e.g. show a block only when the URL contains `?visibility=show`.

---

The module provides one core Condition plugin, `request_param` (`RequestParam`,
`src/Plugin/Condition/RequestParam.php`), that plugs into Drupal's condition system used by block
visibility, Rules, Page Manager, and similar. Its configuration form takes a textarea of query
parameters, one per line, in `key=value` form (arrays supported via `visibility[]=show`). At
evaluation it lowercases the config, turns the newline-separated list into a query string with
`parse_str()`, then compares each configured `key=value` against the current request's actual
query values (`RequestStack`), returning TRUE on any match. The standard **Negate the condition**
option inverts the result (e.g. show the block only when the parameter is absent). The plugin
declares the `url.query_args` cache context so pages vary correctly per query string. It has no
settings page, no permissions, and no dependencies beyond Drupal core.

---

- Show a promotional block only when the URL has `?campaign=summer`.
- Hide all sidebar blocks when the site is loaded in an app webview via `?app=true`.
- Reveal a debug/preview block only when `?preview=1` is present.
- Toggle a banner on links tagged with a tracking query parameter.
- Display an alternate block for traffic arriving with `?source=newsletter`.
- Support array-style parameters like `?visibility[]=show&visibility[]=beta`.
- Use Negate to show a block only when a given query parameter is missing.
- Gate a block behind a shareable "magic link" query flag.
- Vary block visibility for A/B links that differ only by query string.
- Show a cookie/consent notice unless `?consent=given` is in the URL.
- Reuse the same condition in Rules to act on query parameters.
- Combine with Page Manager to select a variant by query parameter.
- Hide navigation chrome for embedded/iframe views via a query flag.
- Show a "back to full site" block only in a stripped `?mode=lite` view.
- Display seasonal content triggered by a query parameter in marketing links.
- Match multiple parameters at once (any match makes the condition true).
- Keep caching correct thanks to the `url.query_args` cache context.
- Drive per-parameter visibility without writing a custom condition plugin.
- Present internal QA blocks only when a specific query flag is set.
- Enable a feature preview for stakeholders via a query-string toggle.
