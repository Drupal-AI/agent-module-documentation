# Configure CSP policies

Form `\Drupal\csp\Form\CspSettingsForm` at `/admin/config/system/csp`
(route `csp.settings`, permission `administer csp configuration`). Config object
`csp.settings` (schema in `config/schema/csp.schema.yml`).

Two independent policies, each a `csp_policy` mapping:

- `report-only` — sent as `Content-Security-Policy-Report-Only` (violations logged, not blocked).
- `enforce` — sent as `Content-Security-Policy` (violations blocked).

Each policy has:
- `enable` (bool) — whether to emit the header.
- `directives` — a map of directive name → source list.
- `reporting` — `{ plugin: <handler id>, options: {...} }` (see
  [plugins/handler.md](../plugins/handler.md)).

## Directive source-list shape
```yaml
script-src:
  base: self          # '', self, none, or any (*)
  flags:              # optional
    - unsafe-inline
    - report-sample
  sources:            # optional explicit hosts
    - https://cdn.example.com
```
Boolean directives (`upgrade-insecure-requests`, `block-all-mixed-content`) are just `true`.
`webrtc` is `allow`|`block`. `sandbox` / `require-trusted-types-for` are token sequences.
`trusted-types` is its own mapping (`base`, `allow-duplicates`, `policy-names`).

## Full directive set
Fetch: `default-src`, `child-src`, `connect-src`, `font-src`, `frame-src`, `img-src`,
`manifest-src`, `media-src`, `object-src`, `prefetch-src`, `script-src(-attr|-elem)`,
`style-src(-attr|-elem)`, `worker-src`. Document: `base-uri`, `sandbox`. Navigation:
`form-action`, `frame-ancestors`. Other: `webrtc`, `upgrade-insecure-requests`,
`block-all-mixed-content`, `trusted-types`, `require-trusted-types-for`.
Directive fallbacks follow the spec (e.g. `script-src-elem` → `script-src` → `default-src`),
see `Csp::DIRECTIVES_FALLBACK`.

## Defaults (config/install/csp.settings.yml)
Both policies ship enabled: `object-src 'none'`, `script-src`/`style-src` `'self'`
(report-only) or `* 'unsafe-inline'` (enforce), `base-uri`/`form-action`/`frame-ancestors`
`'self'`, `webrtc: block`, reporting plugin `none`. Hosts required by enabled asset
libraries are added automatically (`csp.library_policy_builder`, rebuilt on cache clear via
`hook_rebuild`).

## Export/deploy
Standard config — edit `csp.settings.yml` in your config sync dir and `drush config:import`.
