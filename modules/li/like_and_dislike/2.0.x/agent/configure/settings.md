# Configure Like & Dislike

Settings form `Drupal\like_and_dislike\Form\SettingsForm` (`ConfigFormBase`, form id
`like_and_dislike_settings`).

- Route: `like_and_dislike.admin_settings` → `/admin/config/search/votingapi/like_and_dislike`
  (permission `administer like and dislike`; `_admin_route: TRUE`). Appears as a local task/menu
  link under the Voting API settings (`votingapi.admin_settings`).
- Config object: `like_and_dislike.settings` (editable name returned by `getEditableConfigNames()`).

## Config keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled_types` | map `entity_type_id` → list of bundle ids | `{}` (nothing enabled) | Which content entity types/bundles show the widget. A key with an **empty list** enables the whole entity type (types with no bundle key). A key with a **non-empty list** enables only those bundles. |
| `allow_cancel_vote` | bool | `true` | If TRUE, voting the same way again removes (cancels) the existing vote; if FALSE the second identical vote is rejected with a warning. |
| `check_vote_init` | bool | `true` | If TRUE, the widget highlights the user's existing vote on page load (adds `voted` class). Does not work with cached pages — see note below. |
| `hide_vote_widget` | bool | `false` | If TRUE the widget is **hidden** for users lacking the vote permission; if FALSE it is shown but disabled (`disable-status` class). |

Only content entity types (`getGroup() == 'content'`) that have a `view_builder` handler are listed
in the form. The form stores an entity type only when its "enabled" checkbox is on; a bundled type
is stored with its checked bundles, or with an empty list if no bundle is checked.

## What the form does on submit

`submitForm()` rebuilds `enabled_types` from the checkboxes, saves the three booleans, then calls
`entityFieldManager->clearCachedFieldDefinitions()` so the extra display field (see
[../hooks/hooks.md](../hooks/hooks.md)) appears/disappears immediately.

## Set it without the UI

Drush:

```bash
# Enable the widget on article + page nodes, and on the whole "user" entity type.
drush cset like_and_dislike.settings enabled_types.node '["article","page"]' -y
drush cset like_and_dislike.settings enabled_types.user '[]' -y
drush cset like_and_dislike.settings allow_cancel_vote 1 -y
drush cset like_and_dislike.settings hide_vote_widget 0 -y
```

PHP:

```php
\Drupal::configFactory()->getEditable('like_and_dislike.settings')
  ->set('enabled_types', ['node' => ['article', 'page'], 'user' => []])
  ->set('allow_cancel_vote', TRUE)
  ->set('check_vote_init', TRUE)
  ->set('hide_vote_widget', FALSE)
  ->save();
// Then make the field visible on the display and clear caches:
\Drupal::service('entity_field.manager')->clearCachedFieldDefinitions();
```

Enabling a type only *offers* the widget as an extra display component named `like_and_dislike`
(default `visible: FALSE`). You must turn it on in the entity's "Manage display" (or via the
Views field) for it to render. Dynamic per-type/bundle **permissions** are generated from
`enabled_types` — grant them so users can actually vote (see
[../permissions/permissions.md](../permissions/permissions.md)).

## Config schema

`config/schema/like_and_dislike.schema.yml` types `like_and_dislike.settings` as a `config_object`
with the four keys above; `enabled_types` is a nested `sequence` of `sequence` of `string` (entity
type → bundles). `config/install/` also ships the two Voting API vote types `like` and `dislike`
(`value_type: points`, enforced-dependency on this module).

## Cache note

`check_vote_init` highlights the current user's vote at build time inside a lazy builder placeholder;
because the widget is a `#lazy_builder`/`#create_placeholder` render element it is personalized after
placeholder resolution, but the surrounding entity render cache can still serve a stale highlight —
the widget is always re-highlighted client-side right after the user votes.
