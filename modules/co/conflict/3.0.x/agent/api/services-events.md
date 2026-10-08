<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conflict services & event pipeline

## Services (`conflict.services.yml`)

| Service id | Class | Role |
|---|---|---|
| `conflict_resolver.manager` | `ConflictResolver\ConflictResolverManager` | Public entry point: detect and resolve conflicts for a local/remote/base entity triple. |
| `conflict.field_comparator.manager` | `FieldComparatorManager` | Plugin manager for `FieldComparator` plugins. |
| `conflict.resolution_form.builder` | `Form\ConflictResolutionDialogFormBuilder` | Builds the modal (dialog) resolution UI. |
| `conflict.resolution_inline_form.builder` | `Form\ConflictResolutionInlineFormBuilder` | Builds the inline resolution UI. |
| `conflict_discovery.default` | `ConflictDiscovery\DefaultConflictDiscovery` | Event subscriber that discovers conflicting paths. |
| `conflict_resolution.merge_remote_only_changes` | `ConflictResolution\MergeRemoteOnlyChanges` | Event subscriber that auto-merges changes that only occurred remotely. |

## ConflictResolverManagerInterface

```php
$mgr = \Drupal::service('conflict_resolver.manager');

// Find conflicts between three entity versions:
$conflicts = $mgr->getConflicts($local, $remote, $base, $context = NULL);

// Resolve them (auto-merge where possible, return remaining):
$result = $mgr->resolveConflicts($local, $remote, $base, $result = NULL, $context = NULL, $conflicts = NULL);
```

## Events (`Event\EntityConflictEvents`)

| Constant | Value | Fired for |
|---|---|---|
| `ENTITY_CONFLICT_DISCOVERY` | `entity_conflict.discovery` | Discovering which paths conflict (`EntityConflictDiscoveryEvent`). |
| `ENTITY_CONFLICT_RESOLVE` | `entity_conflict.resolve` | Resolving/auto-merging conflicts (`EntityConflictResolutionEvent`). |

Subscribe to these to add custom discovery or resolution strategies (register a normal
`event_subscriber`-tagged service). `MergeRemoteOnlyChanges` is the shipped resolve subscriber;
`conflict_paragraphs` adds `MergeRemoteStructure` for Paragraph reference fields.

## Conflict types (`ConflictTypes`)

- `CONFLICT_TYPE_REMOTE = 'conflict_remote'` — only the stored (remote) value changed → mergeable.
- `CONFLICT_TYPE_LOCAL_REMOTE = 'conflict_local_remote'` — both sides changed → needs resolution.
