<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `directory` base field

## Definition

`MediaDirectoriesHooks::entityBaseFieldInfo()` (`#[Hook('entity_base_field_info')]`) adds one
field to the **`media`** entity type only:

```php
$fields['directory'] = BaseFieldDefinition::create('entity_reference')
  ->setLabel(t('Directory'))
  ->setDescription(t('The ID of the taxonomy term.'))
  ->setSetting('handler', 'media_directory:default')
  ->setSetting('target_type', 'taxonomy_term')
  ->setDisplayConfigurable('form', TRUE)
  ->setDisplayOptions('form', ['type' => 'options_select', 'weight' => 2]);

// Only when media_directories.settings:directory_taxonomy is set:
$fields['directory']->setSetting('handler_settings', [
  'target_bundles' => [$vocabulary => $vocabulary],
]);
```

Consequences:
- It is a **base field**, so it exists on every media bundle and needs no field config.
- It is **single-valued** and **not required** — empty means "root".
- Because `handler_settings` is derived from config, changing `directory_taxonomy` requires
  a full cache flush (the settings form does this for you).
- It is display-configurable on **form** displays only; hide it per bundle at
  `/admin/structure/media/manage/<type>/form-display`.

`MediaDirectoriesHooks::fieldWidgetCompleteOptionsSelectFormAlter()`
(`#[Hook('field_widget_complete_options_select_form_alter')]`) relabels the widget's `_none`
option to **"Root directory"** when the field name is `directory`.

## The root sentinel

```php
Drupal\media_directories\MediaDirectoryRoot::VALUE === -1;
```

`-1` is used as the *root* marker in Views arguments and exposed-filter input because `0`
would be treated as an empty value by Views. It is **never persisted**:
`MediaDirectoriesHooks::mediaPresave()` (`#[Hook('media_presave')]`) sets the field to `NULL`
whenever the incoming `target_id` is `<= 0`. So in storage:

| Meaning | `media_field_data.directory` |
|---|---|
| filed in a folder | the term id |
| root / unfiled | `NULL` |

## Reading and writing from code

```php
/** @var \Drupal\media\MediaInterface $media */
$media = \Drupal::entityTypeManager()->getStorage('media')->load($mid);

// Read.
$tid   = $media->get('directory')->target_id;          // NULL when in root
$term  = $media->get('directory')->entity;             // TermInterface|NULL
$empty = $media->get('directory')->isEmpty();

// Write: move into a folder.
$media->set('directory', $tid)->save();

// Write: move to root (either of these; -1 is normalised to NULL on presave).
$media->set('directory', NULL)->save();
$media->set('directory', \Drupal\media_directories\MediaDirectoryRoot::VALUE)->save();
```

Entity queries:

```php
$storage = \Drupal::entityTypeManager()->getStorage('media');

// Everything in one folder.
$ids = $storage->getQuery()->accessCheck(TRUE)->condition('directory', $tid)->execute();

// Everything unfiled (root, strict mode).
$ids = $storage->getQuery()->accessCheck(TRUE)->notExists('directory')->execute();
```

Creating a directory is creating a term in the configured vocabulary:

```php
$vid = \Drupal::config('media_directories.settings')->get('directory_taxonomy');
$term = \Drupal\taxonomy\Entity\Term::create([
  'vid' => $vid,
  'name' => 'Press kit',
  'parent' => [$parent_tid],   // omit or [0] for a top-level folder
]);
$term->save();
```

Deleting the term deletes the folder; the media that referenced it fall back to root because
the entity-reference value becomes dangling and reads as empty.

## Services and hooks

- Services: only `Drupal\media_directories\Hook\MediaDirectoriesHooks` (autowired hook
  class, constructor takes `ConfigFactoryInterface`). There is **no public API service** —
  read `media_directories.settings` directly.
- Hooks implemented: `help`, `field_widget_complete_options_select_form_alter`,
  `entity_base_field_info`, `views_data_alter`, `media_presave`. Legacy `.module` wrappers
  carry `#[LegacyHook]` and delegate to the class.
- Hooks invited: **none** — there is no `media_directories.api.php`.
- `hook_help()` on `help.page.media_directories` renders a one-line pointer to
  *Add vocabulary* and the settings form.
