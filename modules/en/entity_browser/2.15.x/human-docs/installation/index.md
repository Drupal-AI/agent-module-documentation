# Installation

## Requirements

Entity Browser needs **Drupal 10.2+ or 11** and has no required contrib
dependencies of its own — the core it ships against is `^10.2 || ^11`.

A few optional modules unlock extra features when installed:

- **Inline Entity Form** (`inline_entity_form`) — enables Entity Browser's
  Inline Entity Form submodule (`entity_browser_entity_form`), which adds an
  **Entity form** widget so editors can create referenced entities inline,
  right inside a browser.
- **Token** (`token`) — adds token support in view/display configuration.
- **Entity Embed** (`entity_embed`) — lets editors embed browsed entities into
  rich-text fields through a CKEditor button.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_browser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_browser -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_browser -y
```

Once enabled, the browser screens appear under **Configuration → Content
authoring → Entity browsers** (`/admin/config/content/entity_browser`).

## Optional: enable the Inline Entity Form submodule

If you want editors to create new entities inline from within a browser, enable
the bundled Inline Entity Form integration (it requires the contrib
`inline_entity_form` module):

```bash
drush en entity_browser_entity_form -y
```

This adds the **Entity form** widget as a selection source when you build a
browser.

## Verify it worked

Log in as an administrator and go to
`/admin/config/content/entity_browser`. You should see the **Entity Browsers**
list with an **+ Add Entity browser** button:

![The Entity Browsers list after installation](../images/list.png)

If the page loads and the **Add Entity browser** button is present, the module
is installed correctly. Next, review the
[four plugin layers](../configuration/index.md) and then
[create your first browser](../creating-a-browser/index.md).
