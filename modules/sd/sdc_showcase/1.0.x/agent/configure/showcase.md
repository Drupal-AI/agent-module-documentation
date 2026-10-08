<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure SDC Showcase

Settings live in `sdc_showcase.settings` (route `sdc_showcase.settings`, perm `administer sdc showcase`).

## Access modes (`access_mode`)
| Mode | Behaviour |
|---|---|
| `open` (default) | `access sdc showcase` permission required (standard Drupal). |
| `disabled` | All showcase routes 403. Use on production. |
| `http_auth` | Valid `http_auth_username`/`http_auth_password` (Basic Auth) OR the permission. Creds compared with `hash_equals`. |
| `query_string` | Valid `?sdc_key=` matching `query_string_key` OR the permission. |

The admin settings page itself is never gated by this mechanism (only by the permission).

## Key settings
- `seed` (default 42) — deterministic fake-data seed.
- `default_variation_layers` — `baseline` / `sweep` / `edges` / `combinations` toggles.
- `global_max_variations` (default 50) — cap per component.
- `enabled_providers` — restrict which SDC providers are shown.
- `slot_defaults` — short/medium/long/empty/image placeholder markup for slots.
- `iframe_mode` — render variation pages bare for screenshotting.

## Extend
Add a fake-data provider by implementing an `SdcDataGenerator` plugin (`Plugin/SdcDataGenerator/`, interface `SdcDataGeneratorInterface`, attribute `SdcDataGenerator`). Per-component overrides come from `*.stories.yml` parsed by `sdc_showcase.stories_parser`.

## Drush
`sdc_showcase.commands` (`ShowcaseCommands`) lists components/collections and builds variations for CI.
