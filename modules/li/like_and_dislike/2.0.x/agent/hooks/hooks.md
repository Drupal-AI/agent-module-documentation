# Hooks implemented

All in `like_and_dislike.module` unless noted. These are the ones integrators care about.

| Hook | What it does |
|---|---|
| `hook_entity_extra_field_info()` | For every enabled type/bundle, registers a **display** extra field `like_and_dislike` (label "Like and dislike", `visible: FALSE` by default) so the widget can be placed in "Manage display". |
| `hook_entity_view()` | If the display shows the `like_and_dislike` component and the entity is enabled (`like_and_dislike_is_enabled()`), adds `$build['like_and_dislike']` as a `#lazy_builder` calling `like_and_dislike.vote_builder:build` with `[entity_type_id, entity_id]` and `#create_placeholder => TRUE` (keeps the widget out of the entity render cache and personalizes it per user). Skipped in preview / when the entity has no id. |
| `hook_ENTITY_TYPE_insert()` (`like_and_dislike_vote_insert`) | On insert of any `vote` entity whose bundle is `like` or `dislike`, deletes the voter's opposite-type vote on the same entity — enforcing that a user cannot hold both a like and a dislike. |
| `hook_views_data_alter()` (in `like_and_dislike.views.inc`) | Adds a `like_and_dislike` field to every content entity type that has a view builder, backed by the Views field plugin (see [../views/field.md](../views/field.md)). |
| `hook_theme()` | Declares theme hook `like_and_dislike_icons` (variables `entity_id`, `entity_type`, `icons`), template `templates/like-and-dislike-icons.html.twig`. |
| `hook_help()` | Help text on `help.page.like_and_dislike`. |

## Rendering / theming details

The widget template outputs `<div class="vote-widget vote-widget--like-and-dislike">` containing one
block per icon: `<div class="vote-{type} type-{entity_type}" id="{type}-container-{entity_type}-{entity_id}">`
with an `<a>` carrying the data attributes and a `.count` span. The JS behavior binds to
`.vote-widget--like-and-dislike` and the `#{type}-container-...` ids.

Libraries (`like_and_dislike.libraries.yml`):

- `like_and_dislike/icons` — `css/like_and_dislike.icons.css` (thumb sprite styling). Always attached.
- `like_and_dislike/behavior` — the two JS files; depends on `core/drupal`, `core/jquery`,
  `core/once`. Attached only when the current user may vote.

To render the widget yourself, enable the type in settings, then either enable the `like_and_dislike`
display component in Manage display / add the Views field, or call the vote_builder service directly
(see [../api/services.md](../api/services.md)).
