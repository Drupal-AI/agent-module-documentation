<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Purge configuration

Config object **`registration_purger.settings`** (schema `registration_purger.settings`), defaults
from `config/install/registration_purger.settings.yml`:

| Key | Default | Purges when… |
|---|---|---|
| `purge_registration_on_delete` | true | host entity is **deleted** → delete its registrations |
| `purge_registration_settings_on_delete` | true | host entity is **deleted** → delete its registration_settings |
| `purge_registration_on_update` | false | host is **updated** so registration becomes disabled → delete registrations |
| `purge_registration_settings_on_update` | false | host is **updated** so registration becomes disabled → delete settings |

## Read / write

```bash
drush cget registration_purger.settings
```

Booleans are safest set via config factory (type-correct):

```php
\Drupal::configFactory()->getEditable('registration_purger.settings')
  ->set('purge_registration_on_update', TRUE)
  ->save();
```

## Mechanism

`RegistrationPurgerHooks` implements `hook_entity_delete()` → `purger->onEntityDelete($entity)` and
`hook_entity_update()` → `purger->onEntityUpdate($entity)` (service `registration_purger.purger`,
`Drupal\registration_purger\RegistrationPurger`). On delete it removes the host's registrations
and/or settings per the `*_on_delete` flags; on update, if the host's registration was just
disabled, it removes them per the `*_on_update` flags. Setting all four flags false disables the
submodule's effect without uninstalling it.
