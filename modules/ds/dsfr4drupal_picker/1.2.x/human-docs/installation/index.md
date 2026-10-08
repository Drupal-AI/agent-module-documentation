# Installation

## Requirements

- **Drupal 10.3, 11 or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core **Field** module (declared as a dependency).
- PHP's **iconv** extension (`ext-iconv`).
- The **DSFR** library (`@gouvfr/dsfr`), installed at `libraries/dsfr/dist/`. Its
  icons and pictograms are auto-detected. The status report shows an error until
  it is present.
- The **FontIconPicker** JavaScript library
  ([fonticonpicker.github.io](https://fonticonpicker.github.io/), jQuery-based),
  installed at `libraries/fonticonpicker/`. The status report shows an error
  until it is present.
- Core's **CKEditor 5**/Editor if you want the in-editor icon/pictogram buttons.
- Recommended: the base **DSFR for Drupal** theme, since this module is part of
  the DSFR for Drupal suite.

## Install with Composer

From the project root:

```bash
composer require drupal/dsfr4drupal_picker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dsfr4drupal_picker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the libraries

The module needs two libraries in your webroot `libraries/` folder: the **DSFR**
library at `libraries/dsfr/dist/` and **FontIconPicker** at
`libraries/fonticonpicker/`. The recommended way is to let Composer install both
from the module's manifest.

**Composer, via composer-merge-plugin (recommended by the maintainers).** This
keeps the library versions tracked by the module maintainers:

```bash
composer require wikimedia/composer-merge-plugin
```

Then add the module's library manifest to the `extra` section of your root
`composer.json` (replace `[web-root]` with your web root, usually `web`):

```json
"extra": {
    "merge-plugin": {
        "include": [
            "[web-root]/modules/contrib/dsfr4drupal_picker/composer.libraries.json"
        ]
    }
}
```

Then require the module and the libraries, and Composer installs them
automatically into `libraries/`:

```bash
composer require drupal/dsfr4drupal_picker fonticonpicker/fonticonpicker gouv/dsfr
```

**Manual.** Alternatively, download **FontIconPicker** from
[fonticonpicker.github.io](https://fonticonpicker.github.io/) and place it in
`web/libraries/fonticonpicker`, and install the **DSFR** distribution under
`web/libraries/dsfr/dist`.

(The project page also documents an alternative using a custom `repositories`
entry pinning `fonticonpicker/fonticonpicker` v3.1.1, if you prefer not to use
the merge plugin.)

## Enable the module

```bash
drush en dsfr4drupal_picker -y
```

## Submodules

Enable only the ones you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Examples** | `dsfr4drupal_picker_examples` | Example configuration demonstrating the picker fields. |
| **Link** | `dsfr4drupal_picker_link` | A link-icon widget for attaching a DSFR icon to a link field. |
| **Media** | `dsfr4drupal_picker_media` | A **Pictogram** media type (created automatically on install), with a category taxonomy, for contributing your own custom pictograms. |

For example:

```bash
drush en dsfr4drupal_picker_media -y
```

## Verify it worked

Check the **status report** (`/admin/reports/status`) and confirm there is no
warning about a missing **DSFR library** or **FontIconPicker library**. Then add
a field to a content type (**Structure → Content types → *(type)* → Manage fields
→ Add field**) and confirm the DSFR **icon** and **pictogram** field types are
offered. See [Configuration](../configuration/index.md) for the per-field options.
