# Configure PrevNext

Settings page: `/admin/config/user-interface/prevnext` (route `prevnext.admin_settings`,
permission `administer prevnext`). Form `PrevNextSettingsForm` writes config object
`prevnext.settings`.

## Settings keys

| Key | Type | Meaning |
|---|---|---|
| `prevnext_enabled_entity_types` | map `{type_id: type_id}` | Which fieldable entity types (that have a canonical link) have PrevNext on. |
| `prevnext_enabled_entity_bundles` | map `{type_id: {bundle: bundle}}` | Which bundles of each enabled type are on. |
| `prevnext_infinite_loop` | bool | When true, wrap around: last entity's "next" = first, first entity's "previous" = last. |

The form auto-discovers every entity type implementing `FieldableEntityInterface` that defines a
`canonical` link template, and shows a bundle checkbox group per type (visible only when the type is
checked). Saving invalidates the `entity_field_info` cache tag so the pseudo-fields appear/disappear.

## Set it with Drush

```php
// drush php:eval — enable PrevNext on the article node bundle, with wrap-around.
\Drupal::configFactory()->getEditable('prevnext.settings')
  ->set('prevnext_enabled_entity_types', ['node' => 'node'])
  ->set('prevnext_enabled_entity_bundles', ['node' => ['article' => 'article']])
  ->set('prevnext_infinite_loop', TRUE)
  ->save();
\Drupal\Core\Cache\Cache::invalidateTags(['entity_field_info']);
```

## The three ways to render the links

Enabling a bundle only makes the links *available*; you still choose one output method:

1. **Pseudo-fields (Manage display).** `hook_entity_extra_field_info` exposes two display
   components, `prevnext_previous` and `prevnext_next`, for each enabled bundle. Turn them on (and
   order them) on the entity's *Manage display* tab. `hook_entity_view` renders them when the
   `prevnext_previous` component is enabled.
2. **Block.** Place the **PrevNext links** block (plugin id `prevnext_block`, category *Other*). It
   resolves the entity from the current route parameters, checks the bundle is enabled, and renders
   both links. `blockAccess()` requires `view prevnext links` or the matching per-type permission.
   Returns nothing in preview.
3. **Views field.** Add the **PrevNext links** field (`prevnext_links_field`) to a view whose rows
   are the enabled entity type; `render()` calls the service per row.

## Behaviour notes

- Only **published** (`status = 1`) siblings are considered; neighbours are found by entity **ID**
  order, not by a date or weight field.
- Siblings are filtered to the **current entity's language**.
- The query runs with `accessCheck()`, so entities the user cannot view are skipped.
- Output caching: contexts `url` + `user.permissions`; tags `config:prevnext.settings`,
  `{type}_list`, `{type}_view`, `prevnext_infinite_loop`, and `prevnext-{type}-{bundle}`
  (the last is invalidated in `hook_entity_presave` whenever an enabled entity is saved).
