# Installation

## Requirements

Layout Content Lock Release ties core Layout Builder to the Content Lock module. It
needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Node** module (`node`) enabled — always present on a standard site.
- Core's **Layout Builder** module (`layout_builder`) enabled.
- The contributed **Content Lock** module (`content_lock`) installed and enabled.

Drupal will pull in the core dependencies automatically, but you must have the
**Content Lock** contrib module present — install it with Composer if it isn't
already (`composer require drupal/content_lock -W`).

## Install with Composer

From the project root:

```bash
composer require drupal/layout_content_lock_release -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_content_lock_release -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_content_lock_release -y
```

That's all it takes. It works automatically — there is no configuration. (Make sure
Content Lock itself is configured for the content types you want it to lock; this
module only handles releasing the lock after a Layout Builder save.)

## Verify it worked

With Content Lock active on a content type, open a node for editing, make a change in
Layout Builder, and save. The node's content lock should be released automatically,
and you should be redirected to the node's View page rather than left on the edit
screen with the lock still held.
