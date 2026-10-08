# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`).
- The **Entity Browser** module (`entity_browser`) — this module integrates with
  it, so at least one working entity browser is needed.

Optionally, **Linkit** works alongside this module in the same link UI. There are
no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_entity_browser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and pulls in Entity Browser if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_entity_browser -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Entity Browser and this module:

```bash
drush en entity_browser ckeditor5_entity_browser -y
```

## Next: configure it

The button does nothing until you have at least one entity browser configured and
enabled in a CKEditor 5 text format's link UI — see
[Configuration](../configuration/index.md).

## Verify it worked

After configuration, open a content edit form using the text format, click the link
button, and you should see the new entity-browser button(s) in the link dialog.
Clicking one opens the entity browser so you can search for and select content to
link to.
