<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Media Directories

## The one config object

`media_directories.settings` (schema `config/schema/media_directories.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `directory_taxonomy` | string | *(unset)* | Machine name of the vocabulary whose terms are the folders. Until this is set, the `directory` base field has no `target_bundles` restriction and the Views filter renders "Vocabulary is not selected." |
| `all_files_in_root` | boolean | `false` | `false` → Root shows only media with `directory IS NULL` ("unfiled inbox"). `true` → Root shows every media item. Affects both the Views filter's `All` option (labelled *Root directory* vs *All directories*) and the argument handler. |

Only `config/install/media_directories.settings.yml` ships (`all_files_in_root: false`), so
`directory_taxonomy` is genuinely absent on a fresh install.

## Admin UI

Route `media_directories.config_form` → **`/admin/config/media/media_directories`**
(*Configuration → Media → Media directories*), permission **`administer site configuration`**.
Form class `Drupal\media_directories\Form\MediaDirectoriesConfigForm extends ConfigFormBase`,
form id `media_directories_config_form`.

Fields:
- **Taxonomy** — select of every vocabulary plus `- None -`.
- **Create new vocabulary** — an AJAX toggle revealing a *New vocabulary name* textfield and
  a **Create** button. The machine name is derived by transliterating the label, lowercasing,
  replacing non `[a-z0-9_]` runs with `_`, collapsing repeats, trimming `_`, and truncating
  to 32 chars; it errors if that id or an identically-labelled vocabulary already exists.
  Creating also **saves the new vid as `directory_taxonomy`** in one step.
- **Show all files in Root directory** — the `all_files_in_root` checkbox.

Whenever `directory_taxonomy` changes (via *Save configuration* or via *Create*), the form
calls `drupal_flush_all_caches()` — the `directory` base field's `handler_settings`
`target_bundles` are built from the config, so cached field definitions must be discarded.

Submodules add sibling local tasks on the same base route: **Browser**
(`/admin/config/media/media_directories/browser`, weight 10) and **AI**
(`/admin/config/media/media_directories/ai`, weight 20). `media_directories_editor` and
`media_directories_ui` instead alter this form with
`hook_form_media_directories_config_form_alter()`.

## Doing it from Drush

```bash
# 1. Create the vocabulary that will hold the folders.
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  if (!Vocabulary::load("media_dirs")) {
    Vocabulary::create(["vid" => "media_dirs", "name" => "Media directories"])->save();
  }'

# 2. Point the module at it and choose the root behaviour.
drush cset media_directories.settings directory_taxonomy media_dirs -y
drush cset media_directories.settings all_files_in_root 0 -y

# 3. REQUIRED: the base field definition is cached — rebuild.
drush cr

# 4. Read it back.
drush cget media_directories.settings
```

Creating folders is just creating terms:

```bash
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  $parent = Term::create(["vid" => "media_dirs", "name" => "Press"]);
  $parent->save();
  Term::create(["vid" => "media_dirs", "name" => "2026", "parent" => [$parent->id()]])->save();
  print $parent->id();'
```

## Verifying

```bash
# Does the media entity type actually have the directory base field, bound to the vocab?
drush php:eval '
  $d = \Drupal::service("entity_field.manager")->getBaseFieldDefinitions("media")["directory"] ?? NULL;
  print $d ? "handler=" . $d->getSetting("handler") . " bundles=" . json_encode($d->getSetting("handler_settings")) . "\n" : "MISSING\n";'

# Is the exposed filter present in the media_library view (added by hook_install)?
drush php:eval '
  $v = \Drupal\views\Entity\View::load("media_library");
  print isset($v->getDisplay("default")["display_options"]["filters"]["directory"]) ? "filter present\n" : "filter absent\n";'
```

## Install-time side effects

`media_directories_install()` prepends an **exposed** filter named `directory`
(`plugin_id: media_directory`, table `media_field_data`, `identifier: directory`,
`error_message: TRUE`) to:

- `views.view.media_library` → `default`, `widget`, `widget_table` displays
- `views.view.media` → `default` display

`media_directories_uninstall()` removes those four entries again. If you rebuild those views
from scratch you lose the filter — re-add it manually or reinstall the module.

## Gotchas

- Forgetting `drush cr` after changing `directory_taxonomy` leaves the old vocabulary bound
  to the base field; the UI form does the flush for you, `drush cset` does not.
- The stored value for "root" is `NULL`, not `-1`. `-1` (`MediaDirectoryRoot::VALUE`) is only
  a *request/argument* sentinel; `hook_media_presave()` nulls any target id `<= 0`.
- The base module renders the directory as a plain `options_select` widget (weight 2). The
  Vue browser's drag-and-drop folder management comes from `media_directories_browser`.
