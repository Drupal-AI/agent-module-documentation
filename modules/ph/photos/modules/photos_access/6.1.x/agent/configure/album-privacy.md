<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Turn on album privacy & set an album's level

## Master switch (per content type)

Photos access does nothing until album privacy is enabled for the album's content type. The flag
is in the **parent** module's config:

- `photos.settings:photos_access_<content_type>` — e.g. `photos_access_photos` for the default
  `photos` (Photo album) type. `hook_form_node_form_alter()` only adds the privacy fields, and the
  node access hooks only act, when this is truthy (`\Drupal::config('photos.settings')
  ->get('photos_access_' . $node->getType())`).

Enable it (there is no dedicated settings form for the flag — it is exposed via the Photos basic
settings; set it directly in config if scripting):

```php
\Drupal::configFactory()->getEditable('photos.settings')
  ->set('photos_access_photos', 1)->save();
```

```bash
drush cget photos.settings photos_access_photos   # read current state
```

Uninstalling the submodule resets `photos_access_photos` to 0.

## Per-album privacy (the node form)

With the flag on, the album (node) edit form gains a privacy selector. The choice is saved per
album in the `photos_access_album` table as `viewid`:

| viewid | Meaning |
|---|---|
| `0` | **Open** — anyone who can view the album type. |
| `1` | **Locked** — owner only. |
| `2` | **User list** — only the users you list (`photos_access_user`); a user may be marked as able to *collaborate* (edit). |
| `3` | **Password** — visitors must enter the album password (`pass`, hashed) at `/photos_privacy/pass/{node}`. |

`hook_node_insert/update` (`photos_access_node_insert` / `_node_update`) persist the selected
privacy via `photos_access_update_access()`, which also moves the album's files between the public
and private file systems as needed. Changing privacy re-writes the album's node access records.

## Reading an album's current privacy

The value is not in config; query the `photos_access_album` table by `nid`, e.g. in PHP:

```php
$viewid = \Drupal::database()->select('photos_access_album', 'a')
  ->fields('a', ['viewid'])->condition('nid', $nid)->execute()->fetchField();
```

## Notes

- The flag is keyed by node type, so you can enable privacy for the `photos` type and leave
  other album-like types public (or vice-versa).
- Locked/User-list/Password all rely on node grants (see
  [../api/access-model.md](../api/access-model.md)); after changing grants you may need a node
  access rebuild.
