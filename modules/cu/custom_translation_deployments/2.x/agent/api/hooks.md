<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# custom_translation_deployments — hooks, mechanism & deploy workflow

All source is in `custom_translation_deployments.module` (implementations) and
`custom_translation_deployments.api.php` (the extension hook). There is no config, route, service,
form, permission, or Drush command.

## Install / enable

- `composer require drupal/custom_translation_deployments`, then
  `drush en custom_translation_deployments -y`. Core `locale` is a hard dependency
  (`drupal:locale`) and is enabled with it.
- Nothing to configure. The only relevant setting is core locale's translations path
  (`locale.settings:translation.path`, set under *Configuration → Media → File system*), which is
  where you place the `.po` files (e.g. `sites/default/files/translations` or a repo `translations`
  dir).

## The extension hook — `hook_custom_translation_deployments_files()`

Defined/documented in `custom_translation_deployments.api.php`. An implementation returns an array
of items; each item is a locale "project" descriptor:

- `name` — project machine name; combines with `version` to form the expected file name
  `NAME-VERSION.LANGUAGE.po`.
- `project_type` — e.g. `module`.
- `core` — e.g. `8.x` (a path segment in `server_pattern`, not a real compatibility gate).
- `version` — a **static, non-`dev`** identifier (the comments stress not using `dev`, because
  locale skips remote update checks for `dev` versions).
- `server_pattern` — the remote URL template locale uses if it looks up the project remotely.
- `status` — `1` to enable.

Example (from `.api.php`; yields the file `custom-mycompany.LANGUAGE.po`):

    function mymodule_custom_translation_deployments_files() {
      $items = [];
      $items[] = [
        'name' => 'custom',
        'project_type' => 'module',
        'core' => '8.x',
        'version' => 'mycompany',
        'server_pattern' => 'http://ftp.drupal.org/files/translations/%core/%project/%project-%version.%language.po',
        'status' => 1,
      ];
      return $items;
    }

## Built-in default project

`custom_translation_deployments_custom_translation_deployments_files()` (the module implementing
its own hook) registers one project: `name => project_specific`, `version => custom`,
`project_type => module`, `core => 8.x`, `status => 1`. So with the module enabled you can drop a
`project_specific-custom.LANGUAGE.po` file in the translations directory with no PHP at all.

## How the projects reach locale

- `custom_translation_deployments_cache_flush()` (`hook_cache_flush`): calls
  `\Drupal::moduleHandler()->invokeAll('custom_translation_deployments_files')`, skips items that
  are empty or missing `name`, sets the ownership flag constant
  `CUSTOM_TRANSLATION_DEPLOYMENTS_DATA_KEY` (`'is_custom_translation_deployment_object'`) to TRUE on
  each, and persists them via the `locale.project` service
  (`LocaleProjectStorageInterface::set($item['name'], $item)`). If a project with that name already
  exists and is **not** owned by this module (flag absent), it is left untouched — this module will
  not clobber a real contrib project's stored entry.
- `custom_translation_deployments_locale_translation_projects_alter(&$projects)`
  (`hook_locale_translation_projects_alter`): re-runs the same `invokeAll`, adds an `info => ['name'
  => …]` sub-array and the ownership flag, and merges each item into `$projects[$item['name']]` so
  the projects appear during a locale translation update.

Because the projects live in locale's normal project list/storage, core's existing
translation-update batch/cron handles the actual `.po` parsing and import into `locales_source` /
`locales_target`. This module contributes **no** file I/O or network I/O of its own.

## File-name / discovery rules (verified by the kernel test)

`tests/src/Kernel/CustomTranslationTest.php` places `project_specific-custom.{nb,sv}.po` and
`mymodule-myversion.{nb,sv}.po` into the translations path, runs the standard locale update batch
with `use_remote => FALSE`, and asserts the source strings gain the expected translations. This
confirms: file name = `NAME-VERSION.LANGUAGE.po`, files are found by the configured
`locale.settings:translation.path`, and local files import without any remote fetch.

## Deploy workflow (intended use)

1. Keep `.po` files (e.g. `project_specific-custom.nb.po`) in version control, typically in a repo
   `translations/` directory, and point locale's translation path at it.
2. Deploy code as usual (the files travel with it).
3. As a deploy step, run `drush locale:update` (a.k.a. `drush locale-update`) so core imports the
   deployed files alongside contrib translations. A cache flush also re-registers the projects via
   `hook_cache_flush`.

## Notes

- The default `server_pattern` targets `ftp.drupal.org`; for a **local**, version-controlled
  workflow the files are imported from disk and no remote download of these custom project names is
  needed (they do not exist on drupal.org). Run locale updates with local files present so import is
  purely local.
- `core: '8.x'` in the descriptors is just a path token in `server_pattern`; the module itself runs
  on 8–11 per `core_version_requirement`.
