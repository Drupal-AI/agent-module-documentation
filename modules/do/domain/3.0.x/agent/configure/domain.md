<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Domain

![Domains list](../../../../../../../screenshots/domain/3.0.x/domain.png)

## Domain records (the `domain` config entity)

Entity type id `domain`, config prefix `domain.record.<id>`. Exported fields:
`id` (machine name), `domain_id` (int, auto CRC of hostname), `hostname`, `name` (label),
`scheme` (`http` | `https` | `variable`), `status` (bool), `weight` (int),
`is_default` (bool), `path_prefix` (string, optional).

Manage in the UI at `/admin/config/domain` (route `domain.admin`); add form at
`/admin/config/domain/add`. Requires permission `administer domains`.

**Create via Drush** (preferred, `hostname` then `name`):

```
drush domain:add example.com "Example" --scheme=https
drush domain:add example.org "Example Org" --scheme=https --weight=2 --path-prefix=org
```

**Create in PHP** (the storage sets `domain_id` and machine id from the hostname if omitted):

```php
$storage = \Drupal::entityTypeManager()->getStorage('domain');
$domain = $storage->create([
  'id' => 'example_com',            // omit to derive from hostname
  'hostname' => 'example.com',
  'name' => 'Example',
  'scheme' => 'https',
  'status' => TRUE,
]);
$domain->save();
```

> The **first** domain saved is automatically marked default (`is_default = TRUE`).

**Set the default / enable / disable / rename / rescheme:**

```
drush domain:default example.org      # make this the canonical default
drush domain:disable example.net      # mark inactive (offline)
drush domain:enable  example.net
drush domain:name    example.net "New Name"
drush domain:scheme  example.net https
```

In PHP, set default with `$domain->saveDefault();` (or `->set('is_default', TRUE)->save()`).

## Global settings (`domain.settings`)

UI at `/admin/config/domain/settings` (route `domain.settings`, perm `administer domains`).
Keys and install defaults:

| Key | Default | Meaning |
|---|---|---|
| `www_prefix` | `false` | Treat `www.host` and `host` as the same domain when negotiating. |
| `path_prefix` | `false` | Enable per-domain URL path prefixes. |
| `allow_non_ascii` | `false` | Permit non-ASCII characters in hostnames. |
| `login_paths` | `/user/login`,`/user/password` | Paths still reachable on an **inactive** domain. |
| `css_classes` | `''` | CSS classes added to the `<body>` per domain. |
| `language_negotiation` | `false` | Respect per-domain language negotiation. |
| `allow_destination_domain` | `false` | Allow a `destination` domain to be set on redirects. |

Booleans must be stored as real booleans — via config API, not `drush config:set` (which
mis-parses `false` for boolean keys):

```php
\Drupal::configFactory()->getEditable('domain.settings')
  ->set('www_prefix', TRUE)->save();
```

## Drush commands (all `domain:*`)

`domain:list`, `domain:info`, `domain:add`, `domain:delete`, `domain:default`,
`domain:enable`, `domain:disable`, `domain:name`, `domain:scheme`, `domain:test`,
`domain:replace` (bulk-rename a hostname), `domain:generate` (make N test domains).

## Permissions

`administer domains` (all operations), `create domains`, `edit assigned domains`,
`delete assigned domains`, `assign domain administrators`, `access inactive domains`,
`view domain list`, `view assigned domains`, `view domain entity`,
`view domain information` (debug), `use domain nav block`, `use domain switcher block`.
