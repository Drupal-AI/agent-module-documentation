<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ATD translation discovery — how it works and how to operate it

## Install / enable
`drush en atd -y`. Requires core `locale` (auto-enabled as a dependency). No configuration UI, no
config objects, no permissions — enabling the module is the entire setup.

## The single mechanism
`src/Hook/AtdTranslationInfo.php` — class `Drupal\atd\Hook\AtdTranslationInfo`, method
`systemInfoAlter(array &$info, Extension $file, string $type)`, registered with the attribute
`#[Hook('system_info_alter')]` (Drupal 11 OOP hooks). It implements `hook_system_info_alter()`.

For each extension being processed it checks `is_dir($file->getPath() . '/translations')`. If that
directory exists it writes two keys into the extension's `$info` array:

- `interface translation project` = `$file->getName()` (the extension machine name).
- `interface translation server pattern` = `<extension path>/translations/%project.%language.po`.

Two class constants drive this: `TRANSLATION_DIRECTORY = 'translations'` and
`INTERFACE_TRANSLATION_SERVER_PATTERN = '%project.%language.po'`. Nothing is added when the directory
is absent (verified by the unit test `AtdTranslationInfoTest`). ATD makes no network calls and does
not itself read or parse the `.po` files — it only points core's locale system at them.

## Convention an extension must follow
1. Add a `translations/` directory in the extension root (module, theme or profile).
2. Place one `.po` file per language named `<project>.<langcode>.po`, e.g. `mymodule.nl.po`,
   `mytheme.de.po`. `%project` is the extension machine name; `%language` is the langcode.
3. Add an `.htaccess` to `translations/` to keep the files from being served directly (README note).

## Import workflow
1. `drush cr` — rebuild caches so the altered system info (the two interface-translation keys) is
   applied to the extension.
2. `drush locale-check` — detect available local translation updates.
3. `drush locale-update` — import the discovered `.po` strings into `locales_target`.

Re-run `locale-check` + `locale-update` after any `.po` change. Per the README, when extracting
templates with `potx` you must extract each module/submodule separately — `locale-check`/`update` do
not follow map extractions.

## Generating the `.po` templates (optional)
Install `drupal/potx` (suggested dep), visit `admin/config/regional/translate/extract`, extract the
template for the target extension, translate it, then rename to the `%project.%language.po` pattern
and drop it into the extension's `translations/` directory.

## Scope / what it does NOT provide
No routes, forms, permissions, services, config schema, entities, fields, plugins, or Drush commands.
The only runtime effect is the two info-array keys above. `tests/modules/atd_test` is a test fixture
(ships `translations/atd_test.netl.po` for a fake `netl` language) used by the kernel test
`AtdTranslationDiscoveryKernelTest`; it is not installed on production sites.
