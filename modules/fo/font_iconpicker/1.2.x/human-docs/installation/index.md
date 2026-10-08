# Installation

## Requirements

Font Icon Picker needs:

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Field** module (always present), the only module dependency.
- The **jQuery fontIconPicker** JavaScript library, installed into your site's
  `libraries` folder (see below).
- Your own **icon font** — a stylesheet plus its font files — that you want the
  picker to offer.

## Install the module with Composer

From the project root:

```bash
composer require drupal/font_iconpicker -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/font_iconpicker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the fontIconPicker library

The module needs the third-party fontIconPicker library present at
`/libraries/fonticonpicker`. There are two ways to get it:

**Manual install.** Download the library from
<https://fonticonpicker.github.io/> and place it in your site's root `libraries`
folder, at `/libraries/fonticonpicker`.

**Composer install (recommended)** using the composer-merge-plugin, so the
maintainers keep the library version in step with the module:

```bash
composer require wikimedia/composer-merge-plugin
```

Then add the module's library manifest to the `extra` section of your root
`composer.json` (replace `[web-root]` with your web root, usually `web`):

```json
"extra": {
    "merge-plugin": {
        "include": [
            "[web-root]/modules/contrib/font_iconpicker/composer.libraries.json"
        ]
    }
}
```

Then require both the module and the library, and Composer installs the library to
`/libraries` automatically:

```bash
composer require drupal/font_iconpicker fonticonpicker/fonticonpicker
```

If the library is not installed correctly, Drupal's **Status report** shows a
requirement message.

## Enable the module

```bash
drush en font_iconpicker -y
```

## Verify it worked

1. Check the **Status report** (`/admin/reports/status`) — there should be no
   warning about a missing fontIconPicker library.
2. Go to **Configuration → User interface → Font Icon Picker**
   (`/admin/config/user-interface/font-iconpicker`) and set up your icon font
   (see [Configuration](../configuration/index.md)).
3. On a content type's **Manage fields**, confirm **Font Icon Picker** appears as
   a field type you can add.
