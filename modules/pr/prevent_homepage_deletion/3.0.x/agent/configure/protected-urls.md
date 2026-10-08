<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the protected pages

## The form

Route `prevent_homepage_deletion.settings` (this is also the module's `configure` key) →
`/admin/config/system/prevent-homepage-deletion`, permission `administer site configuration`.
Menu link "Prevent page deletion" under *Configuration → System*
(`prevent_homepage_deletion.links.menu.yml`, parent `system.admin_config_system`).

One field: a textarea **"Protect these URL's"** — *"Enter a list of page paths to protect
against deletion. Start with "/". Wildcards are not supported. One item per line."*

## The config

```yaml
# prevent_homepage_deletion.settings
protected_urls: "/node/12\n/node/34"
```

Schema: `prevent_homepage_deletion.settings` (`config_object`) with a single **string**
`protected_urls` — not a sequence. The module splits it with
`preg_split("(\r\n?|\n)", $protected_urls)`.

```bash
drush cget prevent_homepage_deletion.settings protected_urls
drush php:eval '\Drupal::configFactory()->getEditable("prevent_homepage_deletion.settings")->set("protected_urls", "/node/12\n/node/34")->save();'
```

Note there is **no `config/install` directory**, so on a fresh install the key is unset and
`$config->get('protected_urls') ?? ''` yields an empty list — only the `system.site` pages are
protected until you save the form once.

## What is protected

`_prevent_homepage_deletion_check($entity, $account)` builds its list of protected entity ids
from four sources:

| Source | Key |
|---|---|
| Site front page | `system.site:page.front` |
| Custom 404 | `system.site:page.404` |
| Custom 403 | `system.site:page.403` |
| Your list | `prevent_homepage_deletion.settings:protected_urls` (one path per line) |

Each URI is resolved with `Url::fromUri('internal:' . $uri)`; if `$url->isRouted()` the **first
route parameter value** is collected as a protected id (so `/node/12` → `12`, and a path alias
resolving to a node route works too). The check then denies when
`\Drupal::service('path.matcher')->isFrontPage()` **or** `in_array($entity->id(), $ids)` and the
account lacks `delete_homepage_node`.

Consequences to know:

- Ids are compared without an entity-type check, so the list is effectively "node ids".
- An unrouted or malformed line (e.g. missing leading `/`) yields no id and silently protects
  nothing — `Url::fromUri('internal:' . $uri)` requires a leading slash.
- Wildcards (`/blog/*`) are not supported.
- Changing `system.site:page.front` automatically moves the protection to the new node.

## Reading the effective protection from code

```php
$paths = \Drupal::config('prevent_homepage_deletion.settings')->get('protected_urls') ?? '';
$site  = \Drupal::config('system.site');
$uris  = array_merge(
  [$site->get('page.front'), $site->get('page.404'), $site->get('page.403')],
  preg_split("(\r\n?|\n)", $paths)
);
```

To test the real outcome, just ask core:

```php
$node->access('delete', $account);              // FALSE for a protected node
$node->get('status')->access('edit', $account); // FALSE ⇒ cannot unpublish
```
