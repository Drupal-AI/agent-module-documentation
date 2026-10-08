# Setup & configuration

There is almost nothing to configure — the field is managed automatically. The only "config" is a
one-time back-fill of existing content.

## Automatic field management

The module keeps a one-to-one mapping between **moderated bundles** and instances of the
`cached_moderation_state` field:

- On module install and on every `workflow` config save (`hook_ENTITY_TYPE_insert/update` for
  `workflow`), `cached_moderation_state.field_config_handler`'s `sync()` runs.
- `sync()` creates the (locked) field storage per entity type and a field instance on every bundle
  that Content Moderation currently moderates, and **deletes** instances from bundles that are no
  longer moderated.

So to "enable" caching for a content type, you just add that bundle to a Content Moderation
workflow — the field appears automatically. To disable, remove it from the workflow. You never
create or delete the field by hand (it is `no_ui` and hidden anyway).

Check which bundles are moderated / have the field:

```bash
drush cached-moderation-state:list-moderated-bundles     # e.g. node:article
drush php:eval '$f=\Drupal::service("cached_moderation_state.field_config_handler")->getCachedModerationStateFields(); foreach($f as $x){print $x->id()."\n";}'
```

## Back-filling existing content (the "configure" route)

New/edited entities cache their state automatically, but content that existed *before* the field
was added has an empty cached value until back-filled. Do this once:

- **UI:** Configure form at `/admin/cached-moderation-state/update`
  (route `cached_moderation_state.batch_update_form`, permission
  `access cached_moderation_state update_form`). It runs a Batch over the chosen bundles.
- **CLI:**
  ```bash
  drush cached-moderation-state:update-all                 # all moderated bundles
  drush cached-moderation-state:update node:article,node:page
  drush cached-moderation-state:update-all --only-uninitialized --batch-size=50
  ```

The batch updates entities (including non-default revisions) **without creating new revisions** or
firing unwanted side effects (`BatchUpdateHandler` sets a syncing flag / suppresses revisions).

## Reading the value

```php
$state = $node->cached_moderation_state->value;      // e.g. 'draft'
$when  = $node->cached_moderation_state->updated;    // timestamp of last cache write
```

Or use it as a normal field in Views / entity queries (it is a real, indexed column). Direct UI
access is forbidden by `hook_entity_field_access` — it is for programmatic/Views use only.
