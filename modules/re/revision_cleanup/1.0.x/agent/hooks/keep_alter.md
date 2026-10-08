<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

## Invoked for integrators: `hook_revisions_cleanup_keep_alter(array &$result)`

Documented in `revision_cleanup.api.php`. Fired at the end of `RevisionCleanupService::revisionsToKeep()`
via `$this->moduleHandler->alter(['revisions_cleanup_keep'], $result)`. `$result` is the **keep** set —
revisions listed here are protected from deletion. Add entries to keep more revisions (removing entries
lets them be deleted).

Expected shape per node: `$result[$nid]['nid'] = $nid;` and `$result[$nid]['vids'][$vid] = $vid;`.

Common use — keep moderation drafts that would otherwise fall outside the day/month window:

```php
function mymodule_revisions_cleanup_keep_alter(array &$result) {
  $rows = \Drupal::database()->query("
    SELECT content_entity_id AS nid, content_entity_revision_id AS vid
      FROM {content_moderation_state_field_revision}
     WHERE content_entity_type_id = 'node'
       AND moderation_state IN ('draft', 'needs_review')
  ")->fetchAll();
  foreach ($rows as $item) {
    $result[$item->nid]['nid'] = $item->nid;
    $result[$item->nid]['vids'][$item->vid] = $item->vid;
  }
}
```

By default the module does **not** treat draft/pending moderation states specially, so intermediate
pending revisions older than the retention window are eligible for deletion unless kept here. (The
current/default revision and each language's latest translation-affected revision are always protected
independently of this hook.)

## Implemented by the module

- `hook_cron()` (`revision_cleanup_cron`) — see [../configure/settings.md](../configure/settings.md).
  Throttled to once per calendar day via state `revision_cleanup.last_cron`; only runs when config
  `on` is true; enqueues the delete set through the service.
