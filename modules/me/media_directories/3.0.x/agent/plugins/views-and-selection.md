<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins the base module provides

Media Directories defines **no plugin types**. It provides three plugin *instances*.

## 1. Entity reference selection `media_directory:default`

`Drupal\media_directories\Plugin\EntityReferenceSelection\DirectorySelection`,
`#[EntityReferenceSelection(id: 'media_directory:default', label: 'Media directory',
group: 'default', weight: 0, entity_types: ['taxonomy_term'])]`,
`extends TermSelection`.

It overrides `getReferenceableEntities()` only for the "no match string, no limit" case
(i.e. building a full select list). Then it:

- loads the full term tree per target vocabulary with `loadTree($vid, 0, NULL, TRUE)`,
- skips unpublished terms (and their descendants) unless the user has *administer taxonomy*,
- labels each option with `str_repeat('−', $term->depth + 1) . Html::escape($label)` — the
  U+2212 MINUS SIGN, one more than the depth, so a plain `<select>` renders the hierarchy.

Reuse it on any taxonomy entity reference field:

```php
$field->setSetting('handler', 'media_directory:default');
$field->setSetting('handler_settings', ['target_bundles' => ['media_dirs' => 'media_dirs']]);
```

## 2. Views filter `media_directory`

`Drupal\media_directories\Plugin\views\filter\MediaDirectory`, `#[ViewsFilter("media_directory")]`,
`extends ManyToOne`. Registered onto `media_field_data.directory` by
`MediaDirectoriesHooks::viewsDataAlter()` as *"Media directory filter"*. Config schema:
`views.filter.media_directory` (extends `views.filter.many_to_one`, adds `error_message`).

Behaviour worth knowing:

- `init()` **ignores any stored `vid`** and overwrites `$this->options['vid']` from
  `media_directories.settings:directory_taxonomy` on every request.
- `valueForm()` builds a multi-select of the whole term tree, indented with `−`. If no
  vocabulary is configured it renders a link to the settings form instead.
- `exposedTranslate()` renames the exposed `All` option to **"Root directory"** — or
  **"All directories"** when `all_files_in_root` is on.
- `query()` special-cases `All`: it emits `directory IS NULL`, plus an OR-ed
  `directory IS NOT NULL` when `all_files_in_root` is TRUE (i.e. show everything).
  Any other value falls through to `ManyToOne::query()`.
- `acceptExposedInput()` / `validateExposed()` keep `All` alive through Views' normal
  "empty input" filtering by stashing it in `$this->validatedExposedInput`.
- `getCacheContexts()` adds `user` (term access is per-user).
- `calculateDependencies()` adds the vocabulary and every selected term as config/content
  dependencies.
- `buildExposeForm()` adds an extra **"Display error message"** checkbox (`error_message`).

Adding it to a view from code (this is the exact array `hook_install()` injects):

```php
$filter = [
  'id' => 'directory', 'table' => 'media_field_data', 'field' => 'directory',
  'relationship' => 'none', 'group_type' => 'group', 'admin_label' => '',
  'operator' => 'or', 'value' => [], 'group' => 1, 'exposed' => TRUE,
  'expose' => [
    'operator_id' => 'directory_op', 'label' => 'Directory', 'description' => '',
    'use_operator' => FALSE, 'operator' => 'directory_op', 'identifier' => 'directory',
    'required' => FALSE, 'remember' => FALSE, 'multiple' => FALSE,
    'remember_roles' => [], 'reduce' => FALSE,
  ],
  'is_grouped' => FALSE, 'group_info' => [], 'reduce_duplicates' => FALSE,
  'error_message' => TRUE, 'entity_type' => 'media', 'entity_field' => 'directory',
  'plugin_id' => 'media_directory',
];
$view = \Drupal\views\Entity\View::load('my_media_view');
$display = &$view->getDisplay('default');
$display['display_options']['filters'] = array_merge(['directory' => $filter], $display['display_options']['filters']);
$view->save();
```

## 3. Views argument (contextual filter) `media_directory`

`Drupal\media_directories\Plugin\views\argument\MediaDirectoryArgument`,
`#[ViewsArgument("media_directory")]`, `extends ArgumentPluginBase`. Registered on the same
`media_field_data.directory` field as *"Media directory"*.

- `query()`: when the argument equals `MediaDirectoryRoot::VALUE` (`-1`) it emits
  `directory IS NULL` — plus an OR-ed `IS NOT NULL` when `all_files_in_root` is on. Otherwise
  it emits `directory = :placeholder` (or `!=` with a `IS NULL` OR when the *Exclude* option
  is set).
- `title()`: honours `break_phrase`; returns the *empty field name* (default "Uncategorized")
  for no argument, and *invalid input* (default "Invalid input") when the value is exactly
  `[-1]`. `titleQuery()` is not overridden to load labels — it returns the raw ids.
- `getSortName()` is "Numerical"; `getContextDefinition()` falls back to an `integer`
  context.

Use `/my-page/-1` for "root", `/my-page/12` for term 12.

## What is *not* here

No field types, no field widgets/formatters, no blocks, no permissions, no Drush commands,
no queue workers. The widget (`media_directories_browser_widget`), the CKEditor 5 plugins and
the text filters all come from submodules.
