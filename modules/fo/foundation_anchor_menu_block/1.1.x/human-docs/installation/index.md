# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Block** (`block`) and **Block Content** (`block_content`) modules — these
  are hard dependencies and Drupal enables them automatically.
- The **ZURB Foundation Sites** front‑end library must be available to your theme,
  because the anchor menu is built on Foundation's Magellan component. The companion
  [Foundation Sites](https://www.drupal.org/project/foundation_sites) module is the
  usual way to register it.
- *(Optional)* **Entity Embed** and **Entity Browser** if you want to embed Anchor
  Custom Blocks inside the CKEditor WYSIWYG.

## Install with Composer

Because this module pulls in the ZURB Foundation front‑end library, your project
needs the **asset‑packagist** repository configured before you install — the same
setup the Foundation Sites module documents. Add this to your root `composer.json`
if it isn't already there:

```json
"repositories": [
    {
        "type": "composer",
        "url": "https://asset-packagist.org"
    }
]
```

Then require the module from the project root:

```bash
composer require drupal/foundation_anchor_menu_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. See the
[Foundation Sites Composer instructions](https://www.drupal.org/project/foundation_sites)
for the details of installing the Foundation front‑end library itself.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/foundation_anchor_menu_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en foundation_anchor_menu_block -y
```

## Verify it worked

Go to **Structure → Block layout**, place the **Dynamic Anchor Menu Block**, and
add an **Anchor Custom Block** (with an ID and a Title) to a page. Load that page as
a visitor: the anchor menu should build itself and clicking an entry should scroll
you to the matching section. If nothing appears, confirm the Foundation Sites
library is actually loading in your theme — the menu depends on it.
