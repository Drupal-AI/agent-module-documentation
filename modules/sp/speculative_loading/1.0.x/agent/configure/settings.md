<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings

Route `speculative_loading.settings` (the module's `configure` route) at
`/admin/config/development/performance/speculative-loading`, a local task under
*Configuration › Development › Performance*. Requirement: core permission
`administer site configuration`. Form class `SpeculativeLoadingSettingsForm`
(`ConfigFormBase`).

## Config object `speculative_loading.settings`

| Key | Type | Values | Default | Purpose |
|---|---|---|---|---|
| `mode` | string | `prefetch`, `prerender` | `prerender` | `prefetch` fetches the next document only; `prerender` fully renders it in the background (faster, but heavier — prefer prefetch for interactive pages). |
| `eagerness` | string | `conservative`, `moderate`, `eager` | `moderate` | Browser heuristic for when to trigger — `conservative` ≈ on click, `moderate` ≈ on hover, `eager` = on the slightest hint. |

Both keys are `#required` radios. Defaults ship in `config/install`. Config is
deleted on uninstall (`speculative_loading_uninstall`).

```bash
drush config:get speculative_loading.settings
drush config:set speculative_loading.settings mode prefetch -y
drush config:set speculative_loading.settings eagerness conservative -y
```

## Emitted rule (built in `SpeculationRulesManager::getSpeculationRules`)

Every response gets one inline `<script type="speculationrules">` whose JSON is:

```
{ "<mode>": [ { "source": "document",
  "where": { "and": [
    { "href_matches": "<base-path>/*" },              // same-site links only
    { "not": { "href_matches": [ ...exclude list... ] } },
    { "not": { "selector_matches": "a[rel~=\"nofollow\"]" } }
    // prerender only: + { "not": { "selector_matches": ".no-prerender" } }
  ] },
  "eagerness": "<eagerness>" } ] }
```

Fixed exclude list (`getHrefExcludePaths`, applied to both modes; base-path aware):
`/admin/*`, `/user/login*`, `/user/logout*`, `/user/register*`, the public files
path `/*`, the modules path `/*`, the themes path `/*`, and any URL with a query
string (`/*\?(.+)`). This list is **not** exposed in the UI — extend it in code
(see [extend/hooks.md](../extend/hooks.md)).

Effects require a browser that supports the Speculation Rules API (Chromium-based);
others ignore the script. There are no per-role or per-path settings — the same rules
ship to all visitors on all pages.
