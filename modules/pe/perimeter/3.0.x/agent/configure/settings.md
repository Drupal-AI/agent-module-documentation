<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Perimeter

All configuration lives in the single config object **`perimeter.settings`**
(schema `config/schema/perimeter.schema.yml`). Settings form route
`perimeter.settings` → `/admin/config/system/perimeter` (also linked under
Admin › Configuration › System). No Drush commands; use `drush config:get/set`
or the form.

## Keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `not_found_exception_patterns` | sequence of strings | 12 built-in patterns (see below) | Regex patterns (full `/…/` delimiters). A 404 request whose **path** matches any pattern bans the client IP. |
| `whitelisted_ips` | sequence of strings | `{}` (empty) | IPs / CIDR ranges never banned. Supports `192.168.1.0/24`, `10.0.0.0/8`, etc. (uses Symfony `IpUtils::checkIp`). |
| `flood_threshold` | integer | `0` | Matching requests allowed before a ban. `0` = ban on the first match. `2` = allow two, ban on the third. |
| `flood_window` | integer (seconds) | `3600` | Time window over which `flood_threshold` is counted. |

Built-in `not_found_exception_patterns` (install default):
`/.*\.aspx/`, `/.*\.asp/`, `/.*\.jsp/`, `/\/blog_edit\.php/`, `/\/blogs\.php/`,
`/\/wp-admin.*/`, `/\/wp-login.*/`, `/\/my_blogs/`, `/\/system\/.*\.php/`,
`/.*systopice.*/`, `/.*login.json/`, `/\/episerver.*/`.

Each pattern is a complete PCRE with delimiters and is matched with `preg_match`
against `Request::getPathInfo()`. Patterns are `trim()`med; blank lines are ignored.

## Read / set with Drush

```bash
drush config:get perimeter.settings                      # whole object
drush config:get perimeter.settings flood_threshold      # single key
drush config:set perimeter.settings flood_threshold 3 -y
```

Sequence keys (patterns, whitelist) are awkward to set from the CLI one line at a
time; set them from PHP instead:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("perimeter.settings");
  $p = $c->get("not_found_exception_patterns");
  $p[] = "/\/xmlrpc\.php/";            // ban any 404 hitting xmlrpc.php
  $c->set("not_found_exception_patterns", $p)
    ->set("whitelisted_ips", ["203.0.113.0/24"])
    ->save();
'
```

The settings **form** (`Drupal\perimeter\Form\PerimeterSettingsForm`) stores the
textareas by `explode("\n", …)`, so one pattern / IP per line in the UI.

## Permissions (gate the form fields)

| Permission | Grants |
|---|---|
| `administer perimeter url patterns` | edit the "URL banning patterns" textarea |
| `administer perimeter ip whitelist` | edit the "Whitelisted IPs" textarea |
| `bypass perimeter defence rules` | (restricted) this user's requests never trigger a ban |

The settings route requires `administer perimeter url patterns` **or**
`administer perimeter ip whitelist`. `perimeter_update_8202()` auto-granted the two
admin permissions to any role that already had `administer site configuration`.

## Managing bans

Perimeter only *adds* bans; viewing/removing them is core Ban at
`/admin/config/people/ban` (route `ban.admin_page`). To unban from the CLI:

```bash
drush sql:query "DELETE FROM ban_ip WHERE ip='203.0.113.45';"
# or:  drush php:eval '\Drupal::service("ban.ip_manager")->unbanIp("203.0.113.45");'
```

Note `BanIpManager::unbanIp($ip)` takes the **IP string**, not the row id.
