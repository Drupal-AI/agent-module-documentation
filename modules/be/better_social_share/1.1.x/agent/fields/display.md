# Buttons on entities & in Views (fields)

Besides the block, buttons attach to content two ways: as a **display pseudo-field** on an entity's
*Manage display*, and as a **Views field**. Both read the site-wide config
`better_social_share.settings` (see [../configure/settings.md](../configure/settings.md)) via
`better_social_share_create_entity_data()` (see [../api/functions.md](../api/functions.md)).

## Pseudo-field on *Manage display*

Two hooks in `better_social_share.module` wire this up:

1. `better_social_share_entity_extra_field_info()` — for every content entity type whose
   `entities.<type>` flag is `1` in config, exposes a **display** extra-field
   `better_social_share` (label "Better Social Share", weight 50, visible) on each of its bundles.
   The entity-type list is passed through `hook_better_social_share_entity_types_alter()` first.
2. `better_social_share_entity_view()` (`hook_ENTITY_TYPE_view`) — on render, if the type is enabled
   and (for bundle-having types) the `better_social_share` component is present in the view display,
   builds `#theme => 'better_social_share_standard'` from `better_social_share_create_entity_data($entity)`
   and attaches library `better_social_share/better_social_share.front` + `drupalSettings.base_url`
   (the AJAX popup route). Unpublished-preview entities with a NULL id are skipped.

To turn it on: enable the entity type in the settings form ([../configure/settings.md](../configure/settings.md)),
then place the **"Better Social Share"** field on
`admin/structure/types/manage/<bundle>/display` (or the equivalent Manage display for the entity).
A cache rebuild may be needed before the field appears.

Because the standard theme hook has a suggestion hook, you can template per type/bundle:
`better_social_share_standard__<entity_type>` and `better_social_share_standard__<entity_type>__<bundle>`
(see [../hooks/theme.md](../hooks/theme.md)).

### Paragraph handling

`better_social_share_create_entity_data()` walks up from a `paragraph` entity to its first non-paragraph
parent (`getParentEntity()`), so buttons placed on a paragraph share the **host node's** URL/title.

## Views field `node_better_social_share`

Registered by `better_social_share_views_data_alter()` (`better_social_share.views.inc`) on the
`node` table; handler `Plugin\views\field\NodeBetterSocialShare` (`@ViewsField("node_better_social_share")`).
Add it in the Views UI as **"Better Social Share Buttons"** (title "Global: …" style — it is a
non-query field, `query()` is a no-op).

`render(ResultRow $values)`:
- Reads `$values->_entity`; returns `[]` (nothing) if `$entity->access('view')` is FALSE — respects
  node access.
- Builds the same `better_social_share_standard` render array from
  `better_social_share_create_entity_data($entity)` and attaches the front library + `base_url`.

It is registered only on `node`, so it is a node-Views field; other entity types use the
Manage-display pseudo-field instead.
