# Configure Resource Hints

## Form
- Route `resource_hints.settings` → `/admin/config/development/performance/resources-hints`
  (a local task under core's Performance settings). Permission: `administer resource hints`.
- Form `Drupal\resource_hints\Form\ResourceHintsConfigForm`, config object
  `resource_hints.settings`.
- Four hint sections, each a `details`: **DNS Prefetch**, **Preconnect**, **Prefetch**,
  **Prerender**. Each has:
  - a `Resources` textarea — one URL per line (stored/loaded as a sequence, split on `PHP_EOL`);
  - an `Output type` select — `0` = **Link Header**, `1` = **Link Element**.
- The DNS Prefetch section additionally has `DNS Prefetch Control` (`on` = Enabled, `off` =
  Disabled), controlling the `X-DNS-Prefetch-Control` header/meta.

## Config keys (`resource_hints.settings`)
| Key | Type | Default | Notes |
|---|---|---|---|
| `dns_prefetch_resources` | sequence<string> | `['']` | URLs for `rel="dns-prefetch"` |
| `dns_prefetch_output` | int | 0 | 0 header / 1 element |
| `dns_prefetch_control` | string | `on` | `on`/`off`; `off` suppresses dns-prefetch links |
| `preconnect_resources` / `preconnect_output` | sequence / int | `['']` / 0 | |
| `prefetch_resources` / `prefetch_output` | sequence / int | `['']` / 0 | |
| `prerender_resources` / `prerender_output` | sequence / int | `['']` / 0 | |

Constants (`ResourceHintsConfigForm`): `OUTPUT_LINK_HEADER = 0`, `OUTPUT_LINK_ELEMENT = 1`,
`DNS_PREFETCH_ENABLED = 'on'`, `DNS_PREFETCH_DISABLED = 'off'`.

## How output is produced (`resource_hints_page_attachments_alter`)
For each hint type, each configured URL is `trim()`med and run through
`UrlHelper::stripDangerousProtocols()`; empty/blank results are skipped. Then:
- **Header mode:** `$attachments['#attached']['http_header'][] = ['Link', '<url>; rel="type"']`.
- **Element mode:** `$attachments['#attached']['html_head_link'][] = [['rel' => type, 'href' => url]]`.

DNS-prefetch control: value is `Html::escape()`d; in header mode emits
`X-DNS-Prefetch-Control: <value>`, otherwise a `<meta http-equiv="x-dns-prefetch-control">`.
If `dns_prefetch_control != 'on'`, the `dns-prefetch` URL links are skipped.

## Drush
```
drush config:set resource_hints.settings preconnect_output 0 -y
# resources are sequences; edit via config:edit or a config import
drush config:edit resource_hints.settings
```

## Permission note
`administer resource hints` is **not** `restrict access: true`. It only lets a holder set
resource-hint URLs (sanitized on output via `stripDangerousProtocols`) and the DNS toggle — a
performance-tuning capability, not a content/security boundary.
