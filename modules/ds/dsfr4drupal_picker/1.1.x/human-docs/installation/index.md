# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **FontIconPicker** JavaScript library
  ([fonticonpicker.github.io](https://fonticonpicker.github.io/), jQuery‑based),
  installed into your site's `libraries/` folder — see below. The status report
  shows an error until it is present.
- Core's **CKEditor**/Editor if you want the in‑editor icon/pictogram buttons.
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

## Install the FontIconPicker library

The picker needs the FontIconPicker library at
`libraries/fonticonpicker/`. Choose one approach:

**Manual.** Download the library from
[fonticonpicker.github.io](https://fonticonpicker.github.io/) and place it in
`web/libraries/fonticonpicker` (i.e. the root `libraries` folder).

**Composer, via composer‑merge‑plugin (recommended by the maintainers).** This
keeps the library version tracked by the module maintainers:

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

Then require both the module and the library, and Composer installs the library
automatically:

```bash
composer require drupal/dsfr4drupal_picker fonticonpicker/fonticonpicker
```

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
| **Link** | `dsfr4drupal_picker_link` | Integration for using the picker with links. |
| **Media** | `dsfr4drupal_picker_media` | A **Pictogram** media type (created automatically on install) for contributing your own custom pictograms. |

For example:

```bash
drush en dsfr4drupal_picker_media -y
```

## Verify it worked

Check the **status report** (`/admin/reports/status`) and confirm there is no
warning about a missing FontIconPicker library. Then add a field to a content
type (**Structure → Content types → *(type)* → Manage fields → Add field**) and
confirm the DSFR **icon** and **pictogram** field types are offered. See
[Configuration](../configuration/index.md) for the per‑field options.
