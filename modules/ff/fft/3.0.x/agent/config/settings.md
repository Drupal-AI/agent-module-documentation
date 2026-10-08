<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FFT settings — the template directory

## The form and route

- Route **`fft.admin_settings`** → path `/admin/config/content/fft`, form
  `\Drupal\fft\Form\SettingsForm`, title *"Field Formatter settings"*, permission
  **`administer site configuration`** (`fft.routing.yml`).
- Menu link `fft.admin_settings` under *Configuration → Content authoring*
  (`fft.links.menu.yml`, parent `system.admin_config_content`).

`SettingsForm` extends `ConfigFormBase`, form id `fft_admin_settings_form`, editable config
`fft.settings`.

## Config object `fft.settings`

Single key, defined in `config/install/fft.settings.yml`:

```yaml
fft_storage_dir: 'sites/all/formatter'
```

| Key | Type | Meaning |
|---|---|---|
| `fft_storage_dir` | string (required textfield) | Directory scanned for `*.html.twig` templates. |

`fft_storage_dir()` in `fft.module` reads this value; `fft_get_templates()` scans it. The form has
only `buildForm()`/`submitForm()`; the field is `#required` but there is **no `validateForm()`**.

There is **no `config/schema/`** directory, so config-schema tooling has no definition for this key.

## Operating notes

- **The shipped default `sites/all/formatter` is a Drupal 7 path** and does not exist on Drupal 8+.
  Until you change it to a directory that exists, `fft_get_templates()` logs
  *"Template directory @dir does not exist"* and the formatter/Views-style template dropdowns are
  empty. This is the first setup step.
- Point it at a directory that is part of the site's codebase / deployment and holds the Twig
  templates (they are code — the same class of thing as a theme's templates), then rebuild cache.
- Change it from the UI, or with Drush:

  ```bash
  drush cset fft.settings fft_storage_dir 'themes/custom/mytheme/fft' -y
  drush cr
  ```

- The path is used verbatim by `file_system->scanDirectory()`; templates must additionally carry a
  `{# Template Name: … #}` header and a name starting with `fft` (field formatter) or `views`
  (vff Views style) to be listed — see [../fields/formatter.md](../fields/formatter.md).
