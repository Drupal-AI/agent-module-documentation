<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks defined + integrations shipped

## Hooks this module defines

Documented in `entity_is_public.api.php`:

- **`hook_entity_type_is_public_alter(bool &$public, EntityTypeInterface $entity_type)`** — alter
  whether an entity *type* is public. Called at the end of `isTypePublic()`.
- **`hook_entity_is_public(EntityInterface $entity): ?bool`** — per-entity veto. Return **FALSE**
  to mark non-public, **NULL** for no opinion. Returning TRUE does **not** override another
  implementation's FALSE. Only invoked after type/published/anonymous-access checks already passed.
- **`hook_entity_is_public_alter(bool &$public, EntityInterface $entity)`** — final per-entity
  alter, called after all `hook_entity_is_public()` implementations.

## Integrations it ships

All in `src/Hook/EntityIsPublicHooks.php` (service `Drupal\entity_is_public\Hook\EntityIsPublicHooks`),
using `#[Hook(...)]` attributes; `entity_is_public.module` also declares `#[LegacyHook]` procedural
wrappers for Drupal 10. Constructor deps: `config.factory`, `helper`'s `EntityHelper`,
`EntityIsPublicInterface`, `entity_display.repository`.

- **`entity_type_alter`** (`alterEntityTypes`): seeds each entity type's `public` property from
  `entity_is_public.settings:entity_types`, defaulting `comment`, `config_pages`, `block_content`,
  `llms_txt_section`, `menu_link_content`, `microcontent`, `shortcut`, `redirect` to FALSE (only
  when `public` is still NULL).
- **media** — `entity_type_is_public_alter`: forces `media` non-public when `media.settings:standalone_url`
  is off. `form_entity_is_public_settings_alter`: disables + annotates the media checkbox in the
  settings form in that case.
- **field_redirection** — `entity_is_public`: FALSE if a displayed field uses the
  `field_redirection_formatter` and has a value (`EntityHelper::hasValue`).
- **system** — `entity_is_public`: FALSE if the entity matches the site's configured `page.404` or
  `page.403` path (`EntityHelper::matchesPath`).
- **micronode** — `entity_is_public`: FALSE for nodes that are microcontent
  (`micronode_is_micro_content()`).
- **path** — `entity_is_public`: when `entity_is_public.settings:require_alias` is on, FALSE if a
  fieldable entity with a `path` field has an empty alias.
- **rabbit_hole** — `entity_is_public`: runs `rabbit_hole.behavior_invoker->processEntity()`; a
  non-empty response (a redirect/deny action) or a `NotFound`/`AccessDenied` exception → FALSE;
  other exceptions → TRUE. `entity_type_is_public_alter`: FALSE when the type's Rabbit Hole action
  is not `display_page` and override is not allowed.
- **xmlsitemap** — `entity_is_public`: FALSE unless the built sitemap link has `access` and
  `status`. `xmlsitemap_link_alter`: sets `link['access'] = isPublic($entity, ['xmlsitemap'])`.
- **metatag** — `entity_is_public`: FALSE if the entity's `robots` metatag contains `noindex`.
  `metatags_alter`: forces `robots = 'noindex, nofollow'` when `isPublic($entity, ['metatag'])` is
  FALSE.
- **trash** — `entity_is_public`: for trash-enabled entity types, FALSE if the `deleted` field is
  non-empty.

The `['xmlsitemap']` / `['metatag']` `skipModules` arguments prevent these alter hooks from
recursing into their own `entity_is_public` implementation.

## Example custom veto

```php
#[Hook('entity_is_public')]
public function myModuleEntityIsPublic(EntityInterface $entity): ?bool {
  if ($entity instanceof FieldableEntityInterface
      && $entity->hasField('field_internal')
      && !$entity->get('field_internal')->isEmpty()) {
    return FALSE;
  }
  return NULL;
}
```
