# Views field

Plugin `Drupal\like_and_dislike\Plugin\views\field\LikeAndDislike`
(`@ViewsField("like_and_dislike")`, extends `FieldPluginBase`).

Registered by `hook_views_data_alter()` (in `like_and_dislike.views.inc`) on **every content entity
type that has a view builder** as field `like_and_dislike` (title "Like and Dislike", help
"Like and dislike widget."). Add it to a view of that entity type to show the widget in a row.

- `query()` is a no-op (no query modification — it works off the row's loaded entity).
- `render(ResultRow $values)`:
  - Requires `$values->_entity` (the view must load entities, e.g. an entity-based view or a row with
    a relationship to the entity).
  - If the entity is enabled (`like_and_dislike_is_enabled()`), returns
    `like_and_dislike.vote_builder`'s `build($entity_type, $entity_id)` render array — the same widget
    as the entity display.
  - If not enabled, renders the message "Enable the current entity/bundle in the Like & Dislike
    settings page." (so enable the type in [../configure/settings.md](../configure/settings.md) first).
  - Returns NULL when the row has no entity.

Voting still requires the per-type/bundle permission; the widget is disabled/hidden for users without
it exactly as in the entity display.
