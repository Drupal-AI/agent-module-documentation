<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Base module: the bypass service, permission, and how submodules use it

## Install & enable

```bash
composer require drupal/domain_entity_type   # pulls drupal/domain
drush en domain_entity_type -y
```

`domain_entity_type_install($is_syncing)` (in `domain_entity_type.install`) calls
`module_installer->install(['det_node'])` when det_node is not already enabled — so enabling the
base module also enables the **det_node** submodule automatically. Requires the **Domain**
(`domain`) module (`.info.yml` `dependencies: domain:domain`). There is no config form
(`configure` is null) and no `config/install` or `config/schema`.

## The manager service

Service id **`domain_entity_type.manager`** (`domain_entity_type.services.yml`), class
`Drupal\domain_entity_type\Services\DomainEntityTypeManager` implementing
`DomainEntityTypeManagerInterface`, constructed with `@current_user`.

Single method:

```php
public function bypassAccessCheck($entity_type = '');
```

Logic (`src/Services/DomainEntityTypeManager.php`):

1. If the current user has **`bypass all entity types domain access check`** → return `TRUE`
   (bypass for every entity type).
2. `switch ($entity_type)`:
   - `'node_type'` → return whether the user has **`bypass content type domain access check`**
     (this permission is declared by the **det_node** submodule).
   - `'default'` → return whether the user has `bypass all entity types domain access check`
     (note: this is a literal string case matched against `$entity_type`, not PHP's `default:`
     keyword — reachable only if a caller passes the string `'default'`; the global check in
     step 1 already covers this).
3. Otherwise (including the empty-string default argument) → return `FALSE`.

The service holds no domain logic itself; it only answers "may this user skip the domain check?"
Callers (det_node's access handler, list builder, controller, and route access check) combine it
with the active domain and each bundle's assigned domains.

## Permission

`domain_entity_type.permissions.yml` declares one permission:

- **`bypass all entity types domain access check`** — title *"Bypass all entity types domain
  access check"*. Grant only to trusted roles; it disables the domain restriction for every entity
  type the framework covers. Not granted to any role by default.

(The content-type-only permission `bypass content type domain access check` is declared by the
det_node submodule, not here.)

## Extending the framework in your own submodule

The base module is a foundation. To add per-domain restrictions for another entity type, inject
`@domain_entity_type.manager`, call `bypassAccessCheck('<entity_type_id>')` first, and — if not
bypassed — compare `domain.negotiator`'s active domain id against your entity's assigned domains
(det_node stores these as the `det_node`/`domains` third-party setting on `node_type`). Add a
matching case to `bypassAccessCheck()` (or rely on the global `bypass all entity types domain
access check`) plus your own bypass permission. See the det_node docs for a complete worked
example.
