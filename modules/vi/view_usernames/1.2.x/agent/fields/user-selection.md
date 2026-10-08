# Entity-reference selection handler: leak-proof user autocomplete

`src/Plugin/EntityReferenceSelection/UserSelection.php` — an opt-in selection handler for **user**
entity-reference fields that hides usernames the current user may not view.

| Property | Value |
|---|---|
| Plugin id | `default:strict_user_filtered_by_view_usernames` |
| Label | User selection filtered by View usernames |
| Group | `default` |
| Weight | `128` |
| Entity types | `user` |
| Extends | core `Drupal\user\Plugin\EntityReferenceSelection\UserSelection` |

## Why it exists

The access hooks already keep a username out of an autocomplete result the current user cannot view.
But core's default user selection still lets the widget's search confirm whether a user *exists*
(and exposes the uid). This handler filters every candidate through `$entity->access('view label')`
before it is offered:

- `getReferenceableEntities()` — loads users in batches and includes a user only if
  `access('view label')` passes, escaping the label with `Html::escape()`; it keeps querying until
  the requested `$limit` of *accessible* results is reached (or results run out), so inaccessible
  users do not silently shrink the list.
- `countReferenceableEntities()` — counts only accessible users (documented as intentionally
  inefficient, because deciders can't filter at the SQL-query level).
- `validateReferenceableEntities()` — accepts a submitted uid only if `access('view label')` passes,
  so a user cannot be referenced by guessing its id.
- `validateReferenceableNewEntities()` / `createNewEntity()` — throw `\LogicException`; creating a
  user through an ER field is unsupported by core.

## How to use it

It is **not** the default; a site opts in per field. On a user entity-reference field's storage/field
settings, set the selection handler to `default:strict_user_filtered_by_view_usernames`. Via config
(field instance `settings`):

```yaml
handler: 'default:strict_user_filtered_by_view_usernames'
handler_settings:
  # same settings as core's user selection (include_anonymous, filter, etc.)
```

Or in PHP when creating the field:

```php
$field_config->setSetting('handler', 'default:strict_user_filtered_by_view_usernames');
```

After switching, autocomplete/select widgets on that field only surface users whose username the
editing user is allowed to see, and reject references to users they may not see.
