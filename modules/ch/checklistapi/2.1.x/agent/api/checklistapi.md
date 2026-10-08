# Programmatic API — loading checklists, progress, storage

Checklist API defines no plugin manager. The public surface is a set of procedural helpers
(in `checklistapi.module`), the `ChecklistapiChecklist` object, and two storage services.

## Helper functions

```php
// All definitions (fully built: items resolved via #callback, altered, sorted, #id injected).
$definitions = checklistapi_get_checklist_info();
// A single definition, or FALSE if none.
$definition  = checklistapi_get_checklist_info('my_checklist');

// Load a fully-built ChecklistapiChecklist object, or FALSE.
$checklist = checklistapi_checklist_load('my_checklist');

// Access check: $operation is 'view' | 'edit' | 'any' (default 'any'). Returns bool.
$ok = checklistapi_checklist_access('my_checklist', 'edit');
```

## `ChecklistapiChecklist` (`Drupal\checklistapi\ChecklistapiChecklist`)

Built from a definition; loads its saved progress on construction. Useful members:

```php
$checklist->id; $checklist->title; $checklist->path; $checklist->help;
$checklist->items;               // groups -> items
$checklist->savedProgress;       // the raw saved-progress array (see below)

$checklist->getNumberOfItems();
$checklist->getNumberCompleted();
$checklist->getPercentComplete();      // 0-100 (100 if no items)
$checklist->getLastUpdatedDate();      // formatted, or 'n/a'
$checklist->getLastUpdatedUser();      // display name, 'n/a', or '[missing user]'
$checklist->hasSavedProgress();        // bool
$checklist->getRouteName();            // "checklistapi.checklists.{id}"
$checklist->getUrl();                  // Url to the checklist form
$checklist->userHasAccess('view');     // wraps checklistapi_checklist_access()

$checklist->saveProgress($form_values);  // writes progress from submitted form values
$checklist->clearSavedProgress();        // deletes saved progress
```

`ChecklistapiChecklist` implements `CacheableDependencyInterface`; its cache tag is
`checklistapi:{id}` (invalidated on every save/clear).

## Saved-progress data shape

Whether stored in config or state, the saved progress is the same array (see
`config/schema/checklistapi.schema.yml`, key `progress`):

```php
[
  '#changed'         => 1700000000,   // last-changed timestamp
  '#changed_by'      => '1',          // uid of last editor
  '#completed_items' => 3,            // count of checked items
  '#items' => [
    'item_a' => ['#completed' => 1700000000, '#uid' => '1'],  // first-completion time + user
    // ... only currently-checked items are present
  ],
]
```

Each item records the timestamp and user of its **first** completion; that value is retained
as long as the item stays checked (unchecking then re-checking sets a new one).

## Storage backends

Two services implement `Drupal\checklistapi\Storage\StorageInterface`
(`setChecklistId()`, `getSavedProgress()`, `setSavedProgress(array)`, `deleteSavedProgress()`):

- `checklistapi_storage.config` (`ConfigStorage`) — default. One config object per checklist:
  `checklistapi.progress.{id}`. Exportable / deployable via config sync.
- `checklistapi_storage.state` (`StateStorage`) — state key `checklistapi.progress.{id}`.
  Per-environment; not exported.

The backend is selected per checklist by the definition's `#storage` key. To read progress in
code without the full object:

```php
$progress = \Drupal::service('checklistapi_storage.config')
  ->setChecklistId('my_checklist')
  ->getSavedProgress();
```
