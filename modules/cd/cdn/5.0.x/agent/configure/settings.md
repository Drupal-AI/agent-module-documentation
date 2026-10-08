# Configure CDN

All settings live in the **`cdn.settings`** config object (schema:
`config/schema/cdn.schema.yml`, `cdn.mapping.schema.yml`, `cdn.conditions.schema.yml`,
`cdn.data_types.schema.yml`). This module has no UI; enable **cdn_ui** or edit config directly.

## Top-level keys (install defaults)

| Key | Default | Meaning |
|---|---|---|
| `status` | `false` | Master switch. `true` = rewrite file URLs to the CDN. |
| `mapping` | simple, no domain, `not: {extensions: [css, js]}` | The domain→file mapping (see below). |
| `scheme` | `//` | URL scheme: `//` (scheme-relative), `https://`, or `http://`. |
| `farfuture.status` | `true` | Enable forever-cacheable file serving via the `/cdn/ff/…` route. |
| `stream_wrappers` | `[public]` | Local stream-wrapper schemes eligible for CDN rewriting. |

## Mapping types (`mapping.type`)

**`simple`** — one domain, optional extension conditions:
```yaml
mapping:
  type: simple
  domain: cdn-a.example.com
  conditions: {}                     # all files
  # or:  conditions: {extensions: [jpg, jpeg, png]}   # only these
  # or:  conditions: {not: {extensions: [css, js]}}   # everything except these
```

**`complex`** — a `fallback_domain` plus nested per-extension mappings:
```yaml
mapping:
  type: complex
  fallback_domain: cdn-c.example.com   # or null for "nothing else"
  domains:
    - {type: simple, domain: cdn-a.example.com, conditions: {extensions: [css, jpg, jpeg, png]}}
    - {type: simple, domain: cdn-b.example.com, conditions: {extensions: [zip]}}
```

**`auto-balanced`** — spread matching extensions over several domains (consistent hashing;
same file always maps to the same domain). Requires an `extensions` condition:
```yaml
mapping:
  type: auto-balanced
  domains: [cdn-b.example.com, cdn-c.example.com]
  conditions: {extensions: [jpg, jpeg, png]}
```

Domains are validated by the `CdnDomain` constraint (host/authority per RFC3986, no scheme).
`scheme` is validated by a `Choice` constraint against the three allowed values.

## Change settings via drush (grounding for evals)

```bash
drush config:set cdn.settings status true -y
drush config:set cdn.settings mapping.type simple -y
drush config:set cdn.settings mapping.domain cdn-a.example.com -y
drush config:set cdn.settings scheme 'https://' -y
drush config:get cdn.settings mapping
```

Note: the CDN does **not** serve HTML/REST responses or private files; only public files
matching the mapping and an eligible stream wrapper are rewritten.
