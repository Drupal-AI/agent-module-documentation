<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revision Summary — service API

Inject or fetch `revision_summary.compare_revisions`.

```php
$cmp = \Drupal::service('revision_summary.compare_revisions');
$entity = Node::load($nid);            // the "new" revision (loaded entity)
$old_vid = 1461634;                    // revision id to compare against

// Map of changed field machine name => human label.
$changed = $cmp->listChangedFields($entity, $old_vid, $watched_fields = []);

// Added/removed lines for one field.
$delta = $cmp->listChangesInField($entity, $old_vid, 'body');
// => ['added' => [...], 'removed' => [...]]

// Renderable markup.
$build  = $cmp->listChangesInFieldAsMarkup($entity, $old_vid, 'body');
$inline = $cmp->giveFieldNameWithChangesInlineAsMarkup($entity, $old_vid, 'field_x', 'Label');
```

Notes:
- Internally uses `diff.entity_comparison::compareRevisions`; the diff id format is `{id}:node.{field}`.
- Currently node-centric (hard-coded `node` storage / `nid` column in the fallback SQL).
- `latestRevisionIdWithChangedField($entity,$field,$fallback)` runs raw SQL against `node_revision__{field}`; treat `$field` as trusted code, never request input.
- No access checking is performed — gate output yourself before showing it to users.
