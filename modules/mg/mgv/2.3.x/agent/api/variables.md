<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Built-in global variables

All are printable in any Twig template as `{{ global_variables.<key> }}` (the module adds
`global_variables` to every template's default variables). Source: `src/Plugin/GlobalVariable/*`.

## Paths

| Twig | Plugin id | Returns |
|---|---|---|
| `global_variables.current_path` | `current_path` | Current internal path (`path.current`). Adds `url` cache context. |
| `global_variables.current_path_alias` | `current_path_alias` | Alias of the current path. |
| `global_variables.base_url` | `base_url` | Site base URL. |

## Current items

| Twig | Plugin id | Returns |
|---|---|---|
| `global_variables.current_page_title` | `current_page_title` | Resolved page title (rendered to string). |
| `global_variables.raw_current_page_title` | `raw_current_page_title` | Title as returned by the title resolver (may be a render array/Markup); Twig auto-escapes on print. |
| `global_variables.current_langcode` | `current_langcode` | Current interface langcode. |
| `global_variables.current_langname` | `current_langname` | Current language human name. |

## Site information (`system.site` config)

| Twig | Plugin id | Returns |
|---|---|---|
| `global_variables.site_name` | `site_name` | Site name. |
| `global_variables.site_slogan` | `site_slogan` | Site slogan. |
| `global_variables.site_mail` | `site_mail` | Site email. |
| `global_variables.logo` | `logo` | Site logo URL (`SiteLogo`). |

## Social sharing (nested under `social_sharing`)

Wrap in an anchor, e.g. `<a href="{{ global_variables.social_sharing.facebook }}">Share</a>`. Each is
built from other variables via `variableDependencies`.

| Twig | Plugin id | Shares via |
|---|---|---|
| `global_variables.social_sharing.facebook` | `social_sharing\facebook` | facebook.com/sharer.php |
| `global_variables.social_sharing.twitter` | `social_sharing\twitter` | X/Twitter intent |
| `global_variables.social_sharing.linkedin` | `social_sharing\linkedin` | LinkedIn share |
| `global_variables.social_sharing.whatsapp` | `social_sharing\whatsapp` | WhatsApp send |
| `global_variables.social_sharing.email` | `social_sharing\email` | `mailto:` (subject = page title) |

## Reading values in PHP

```php
$vars = \Drupal::service('plugin.manager.mgv')->getVariables(); // or the interface service
$title = (string) $vars['current_page_title'];
```

Note: `SystemSiteBase` is the shared base for the `system.site` variables; `SocialSharingEmail`
returns `NULL` when there is no current route (e.g. during search indexing).
