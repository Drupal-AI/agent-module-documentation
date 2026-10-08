# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- The **ScrollUp JavaScript library**, installed into `/libraries` (see below).
  The module integrates the library but does not bundle it.
- No other contributed modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_scrollup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jquery_scrollup -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the ScrollUp library

The module needs the ScrollUp plugin file present on disk. You have two options.

**Managed by Composer (recommended).** Add the
[Composer Merge Plugin](https://github.com/wikimedia/composer-merge-plugin) and
point it at the module's bundled library manifest:

```bash
composer require wikimedia/composer-merge-plugin
```

Then, in your **root** `composer.json`, add the module's
`composer.libraries.json` to the merge‑plugin include list:

```json
"extra": {
    "merge-plugin": {
        "include": [
            "modules/contrib/jquery_scrollup/composer.libraries.json"
        ]
    }
}
```

Adjust the path if your contrib modules live under `web/` or `docroot/`. Then run:

```bash
composer update --lock
```

**Manual download.** Alternatively, download the library from
<https://github.com/markgoodyear/scrollup> and place it in `/libraries` so this
path exists:

```
/libraries/scrollup/dist/jquery.scrollUp.min.js
```

## Enable the module

```bash
drush en jquery_scrollup -y
```

## Verify it worked

Load a page long enough to scroll, then scroll down. The "back to top" button
should appear; clicking it should glide you smoothly to the top. To fine‑tune its
look and behavior, see [Configuration](../configuration/index.md).
