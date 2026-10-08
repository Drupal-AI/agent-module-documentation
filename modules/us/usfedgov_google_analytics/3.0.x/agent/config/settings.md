<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — usfedgov_google_analytics

Single config object **`usfedgov_google_analytics.settings`**. UI at
`/admin/config/services/dap` (route `usfedgov_google_analytics.form`), gated by permission
**`administer federal google analytics`**. Schema: `config/schema/usfedgov_google_analytics.schema.yml`.
Defaults: `config/install/usfedgov_google_analytics.settings.yml`.

## Attach conditions (`src/Hook/PageAttachments.php`)
The DAP script is attached to a page ONLY when ALL are true:
- `status` is `true`,
- `query_parameters.agency` is non-empty (**required**),
- the current user is **anonymous** (authenticated users are never tracked),
- the route is not `user.login`, `user.logout`, or `user.pass`,
- the route is **not** an admin route.

## Top-level settings
| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `status` | bool | `true` | Master on/off ("Enable"). |
| `library` | string | `cdn` | Which asset library / DAP source to serve. One of: `cdn`, `local_minified.8.6.0`, `local.8.6.0`, `local_minified.8.5.0`, `local.8.5.0`, `local_minified.8.0.0`, `local.8.0.0`. `cdn` = `https://dap.digitalgov.gov/Universal-Federated-Analytics-Min.js`. |

## `query_parameters.*` (appended to the script URL)
Emitted via `UrlHelper::buildQuery`; only values that differ from the DAP default AND are
non-empty are sent; booleans are output as literal `true`/`false`.

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `agency` | string | `''` | **Required.** Main federal agency (e.g. `DHS`). |
| `subagency` | string | `''` | Sub-agency (e.g. `FEMA`). |
| `sitetopic` | string | `''` | Site topic (e.g. health, travel). |
| `siteplatform` | string | `Drupal` | Site platform label. |
| `sp` | string | `''` | Extra search-parameter names added to DAP's auto search tracking. |
| `autotracker` | bool | `true` | Download tracking on/off. |
| `exts` | string | `''` | Extra file extensions to treat as downloads. |
| `yt` | bool | `false` | YouTube video tracking. |
| `htmlvideo` | bool | `true` | HTML5 media tracking (needs DAP ≥ 8.3.0; disabled in the form for the 8.0.0 libraries). |
| `ytm` | int | `25` | Video milestone percent; one of `10`, `20`, `25`. |
| `sdor` | string | `''` | Sub-domain linking value; blank = sub-domains counted separately. |
| `cto` | int | `24` | Cookie expiration in months (Chrome caps at 400 days). |
| `dapdev` | bool | `false` | Report to the DAP TEST/DEV environment. |

### Parallel Google Analytics 4 (`query_parameters.*`)
| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `pga4` | string | `''` | Your own GA4 **Measurement ID** for a parallel tracker. |
| `parallelcd` | bool | `false` | Also send custom dimensions to the parallel account. |
| `palagencydim` | int | `1` | Agency custom-dimension slot (1–425). |
| `palsubagencydim` | int | `2` | Sub-agency slot. |
| `palversiondim` | int | `3` | Code-version slot. |
| `paltopicdim` | int | `4` | Site-topic slot. |
| `palplatformdim` | int | `5` | Site-platform slot. |
| `palscriptsrcdim` | int | `6` | Script-source slot. |
| `palurlprotocoldim` | int | `7` | URL-protocol slot. |
| `palinteractiontypedim` | int | `8` | Interaction-type slot. |

## Configure via drush
```bash
# Minimum viable setup: set the required agency and confirm tracking is on.
drush cset usfedgov_google_analytics.settings query_parameters.agency DHS -y
drush cset usfedgov_google_analytics.settings status true -y

# Optional: sub-agency, serve a pinned local version, enable YouTube tracking.
drush cset usfedgov_google_analytics.settings query_parameters.subagency FEMA -y
drush cset usfedgov_google_analytics.settings library local_minified.8.6.0 -y
drush cset usfedgov_google_analytics.settings query_parameters.yt true -y

# The settings FORM clears the library-discovery cache on save; when editing config
# directly, do it yourself so the new query string is baked into the library:
drush cache:rebuild
```
Read current values: `drush cget usfedgov_google_analytics.settings`.

## Notes
- No agency set → nothing attaches, and the status report (`/admin/reports/status`) shows a
  warning (`src/Hook/RuntimeRequirements.php`).
- The three `user.*` routes and all admin routes are excluded in code; there is no UI to add
  more exclusions.
- Bundled scripts live under `js/{8.0.0,8.5.0,8.6.0}/`; the CDN option needs no local files.
