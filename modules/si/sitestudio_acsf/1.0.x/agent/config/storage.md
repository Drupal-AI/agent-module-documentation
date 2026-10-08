<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Database storage for Site Studio templates and stylesheet JSON

Goal: make Acquia Site Studio (Cohesion) keep its generated Twig templates and stylesheet JSON in the
database (KeyValue) rather than on the filesystem. The module wires this up with two mechanisms plus an
install step; there is nothing to configure by hand.

## Install / enable
```
drush en sitestudio_acsf -y
drush cohesion:rebuild          # or visit /admin/cohesion/developer/rebuild
```
Requires the `cohesion_templates` module and `acquia/cohesion >= 6.3.5`. The rebuild migrates existing
templates into the database; without it, templates already on the filesystem are not moved.

## Mechanism 1 — Twig template storage (service alias)
`src/SiteStudioAcsfServiceProvider.php`, class `SiteStudioAcsfServiceProvider extends ServiceProviderBase`.
Its `alter(ContainerBuilder $container)` calls:
```php
$container->setAlias('cohesion.template_storage', 'cohesion.template_storage.key_value');
```
So any code resolving `cohesion.template_storage` gets Cohesion's KeyValue implementation
(`Drupal\cohesion\TemplateStorage\KeyValueStorage`) instead of the filesystem one. A service provider
`alter()` runs at container-compile time, so the swap needs no config.

## Mechanism 2 — Stylesheet JSON storage (config override)
`src/Config/StylesheetJsonStorageOverride.php`, class `StylesheetJsonStorageOverride implements
ConfigFactoryOverrideInterface`, registered in `sitestudio_acsf.services.yml` as service
`sitestudio_acsf.override` tagged `config.factory.override` with `priority: 5`.
Its `loadOverrides($names)` returns, whenever `cohesion.settings` is requested:
```php
['cohesion.settings' => ['stylesheet_json_storage_keyvalue' => TRUE]]
```
This forces Cohesion to store stylesheet JSON in KeyValue storage. It is a runtime override (not written
to config): `createConfigObject()` returns NULL and `getCacheableMetadata()` returns empty metadata, so
the value is effectively constant while the module is enabled and cannot be turned off from the Site
Studio settings UI. Note the config module ships no `config/schema`, so `provides_config_schema` is false.

## Install behaviour (`sitestudio_acsf.install`)
`hook_install()`:
- `module_set_weight('sitestudio_acsf', -100)` — makes this module's services register before others so
  the template-storage alias wins (this is why the module belongs to the "Module execution order" concern).
- Rebuilds the active module list and calls `\Drupal::service('kernel')->updateModules(...)` to reboot the
  kernel with the new service definitions.
- Adds a warning (messenger + logger) that a Site Studio rebuild is required to migrate templates.

## Status report (`hook_requirements`, `runtime` phase)
Adds two informational rows at `/admin/reports/status`:
- **Site Studio: Stylesheet JSON Storage** — `Database` if `cohesion.settings:stylesheet_json_storage_keyvalue`
  is truthy, else `Filesystem`.
- **Site Studio: Twig template storage** — `Database` if the resolved `cohesion.template_storage` service is
  an instance of `Drupal\cohesion\TemplateStorage\KeyValueStorage`, else `Filesystem`.
Use these to confirm both stores actually flipped after install.

## Reverting
Uninstall `sitestudio_acsf` (removes the alias and the override), then run `drush cohesion:rebuild` to
regenerate assets back onto the filesystem. Expect database size and rebuild/sync load to be higher while
the module is enabled — that is the documented trade-off for read/write consistency.
