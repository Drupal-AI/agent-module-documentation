<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Siteimprove.ai Plugin — configuration

## Settings form
`/admin/config/system/siteimprove` — route `siteimprove.settings_form`, permission **`administer siteimprove`**.

Enter (or regenerate) the **Siteimprove auth token**. The token is requested server-side from
`https://my2.siteimprove.com/auth/token?cms=Drupal-<version>` (`SiteimproveUtils::requestToken()`,
`\Drupal::httpClient()->get(...)`) over HTTPS with Guzzle's default certificate verification —
it is not disabled.

## Permissions
| Permission | Grants |
|---|---|
| `administer siteimprove` | Access the settings form |
| `use siteimprove` | See and use the overlay/features |
| `use siteimprove prepublish` | Use the prepublish content check |

## Which pages load the overlay
Defined by service **parameters** (override in a `*.services.yml` if needed):
- `siteimprove.recheck_enabled_routes` — routes that get the recheck action.
- `siteimprove.prepublish_check_enabled_routes` — routes offered the prepublish check.
- `siteimprove.other_enabled_routes` — other routes that load the integration.

Defaults cover `entity.node.*`, `entity.taxonomy_term.*` and `entity.group.*` canonical/edit/latest-version routes.

## Frontend domain plugins
If the public (frontend) domain differs from the editing (backend) domain, choose a **Frontend
Domain plugin**: (1) same-domain default, (2) a single distinct frontend domain, or a
Domain Access-aware option when the `domain` suite is installed. Custom plugins can be added.

## Security notes
- All configuration is behind `administer siteimprove`; there are no anonymous or mutating routes.
- The token fetch uses verified TLS (no `verify => false`).