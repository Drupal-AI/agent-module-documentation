<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundle Class Annotations (bca) — agent index

Lets a Drupal **bundle class** declare which entity type + bundle it serves with a PHP **attribute**
(`#[Bundle(...)]`) or a legacy **annotation** (`@Bundle`) placed on the class itself, instead of the
site wiring it up in `hook_entity_bundle_info_alter()`. Mechanism: `BundlePluginManager` (a
`DefaultPluginManager` subclass, service `plugin.manager.bca.bundle`) discovers every class in an
enabled module's `src/Entity/` (recursively) carrying the `Bundle` attribute/annotation; then
`bca_entity_bundle_info_alter()` in `bca.module` copies each discovered `class` (and optional
`label`) onto the matching `$bundles[<entityType>][<bundle>]` entry. Net effect is identical to the
core hook — the association just lives next to the class, so adding/removing a bundle class is one
file, not two places.

This is developer ergonomics, not new capability: registered bundle classes behave exactly as they
would via the hook. No routes, no permissions, no config, no forms, no drush, no settings page. The
only runtime service is the plugin manager; the only hook is `hook_entity_bundle_info_alter()`.
**Note (core 11.4+):** bundle-class attributes are now in Drupal core as
`Drupal\Core\Entity\Attribute\Bundle`; existing sites keep working, and you can migrate off this
module by swapping the `use` namespace. The 1.1.x branch supports both attributes and annotations;
the 2.x branch is attributes-only.

- **Depends on:** nothing (no `dependencies:` in info.yml).
- **Core:** `^10.2 || ^11` (attributes need Drupal 10.2+; below that only the annotation path works).
- **PHP:** `>=8.1` (attributes).
- **Package:** none declared (shows as "Other").
- **Settings page / configure route:** none (`configure` null).
- **Permissions:** none. **Drush:** none. **Config schema:** none.
- **Provides a plugin type:** yes — the `Bundle` plugin type, manager `plugin.manager.bca.bundle`,
  discovered from `src/Entity/`. It is an internal mechanism, not a general extension point.
- Upstream-linted: `phpstan.neon` + `phpstan-baseline.neon`, `phpcs.xml`.

## What you'd do → where
- Declare a bundle class (attribute or annotation), parameters, discovery rules, the manager
  service, and the hook it feeds → `agent/api/bundle-classes.md`

## Key facts (real machine names)
- Service: `plugin.manager.bca.bundle` → class `Drupal\bca\BundlePluginManager`, `parent:
  default_plugin_manager` (`bca.services.yml`).
- Attribute class: `Drupal\bca\Attribute\Bundle` (`#[\Attribute(\Attribute::TARGET_CLASS)]`,
  extends `Drupal\Component\Plugin\Attribute\Plugin`). Params: `entityType` (string, required),
  `bundle` (?string, defaults to `entityType`), `label` (?`TranslatableMarkup`).
- Annotation class: `Drupal\bca\Annotation\Bundle` (`@Annotation`, extends
  `Drupal\Component\Annotation\Plugin`). Keys: `entity_type`, `bundle` (defaults to `entity_type`),
  `label` (`@Translation`). **Deprecated** — attribute keys differ (`entityType` vs `entity_type`).
- Plugin ID format: `"<entityType>:<bundle>"` (built in each `Bundle` constructor / `getId()`).
- Discovery subdir: `Entity` (`BundlePluginManager::SUBDIR`) — scans `src/Entity/` recursively.
- Plugin interface passed to the manager: `Drupal\Core\Entity\EntityInterface` (a bundle class must
  extend its entity's class, e.g. `Node`, `User`).
- Cache key: `bca_bundle_classes` (`BundlePluginManager::CACHE_KEY`).
- Hook: `bca_entity_bundle_info_alter()` in `bca.module` — reads `$definition['entityType'] ??
  $definition['entity_type']` (handles both attribute and annotation key styles), then sets
  `$bundles[$entityType][$bundle]['class']` and `['label']`.
