<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sub Entity (subentity) — agent index

Developer framework for **subentities**: content entities that never exist on their own — they
are always referenced by a parent entity, so their access is derived from that parent rather than
decided independently. The field_collection idea for D8+, and an alternative to Paragraphs when the
Paragraphs type system / widget / revision model is the wrong shape. It ships base classes, entity
handlers, route providers and a Drush generator; you define concrete subentity types in your own
module (nothing to enable per-type).

- **Core:** `^10 || ^11`. **Composer:** `drush/drush >11` (conflicts with `<12`), so the generator
  is effectively mandatory. No other module dependency declared.
- **Configure route:** none (no module settings form). Admin landing page is
  `subentity.entity_types` at `/admin/structure/subentities`, a menu-block page requiring **both**
  `administer subentities` and `administer site configuration` (comma = AND).
- Provides **1 permission**, a **Drush generator** (`drush generate subentity`), theme hooks. No
  Drupal plugin types, no config schema of its own (per-type schema is generated into your module).

## What you'd do
- **Define a subentity type / wire its entity handlers / understand the parent-inherited access** → [api/framework.md](api/framework.md)
- **Scaffold a new subentity type with Drush** → [drush/generate.md](drush/generate.md)
- **Grant admin access to the subentity UI** → [permissions/permissions.md](permissions/permissions.md)
- **Theme / override a subentity's template** → [theme/templates.md](theme/templates.md)

## Key facts (real machine names)
- Base class: `Drupal\subentity\Entity\SubEntityBase` (abstract, extends `ContentEntityBase`).
- Access handler: `Drupal\subentity\ReferencedEntityAccessControlHandler` (handler key `access`).
- Parent finder handler: `Drupal\subentity\Entity\EntityParentHandler` (handler key `parent`).
- Route providers: `Drupal\subentity\EntityHtmlRouteProvider` (subentity),
  `Drupal\subentity\BundleHtmlRouteProvider` (bundle config entity).
- List builders: `Drupal\subentity\Entity\Controller\ReferencedEntityListBuilder`,
  `Drupal\subentity\BundleListBuilder`.
- Forms: `Drupal\subentity\Form\ReferencedEntityForm`, `EntitySettingsForm`, `BundleForm`.
- Service (autowired, class-name id): `Drupal\subentity\Services\SubentityHelper` → `installSubentity(string $machine_name)`.
- Permission: `administer subentities`. Admin route: `subentity.entity_types`. Menu link: `subentity.admin.structure.types`.
- Drush generator name `entity:subentity` (alias `subentity`), templates under `templates/`.
- Theme hook `subentity` (template `subentity.html.twig`).
