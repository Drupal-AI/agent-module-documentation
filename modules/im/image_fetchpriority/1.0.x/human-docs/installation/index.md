# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Image** module — the only dependency.

There are no other Composer or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_fetchpriority -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_fetchpriority -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_fetchpriority -y
```

Then clear the cache:

```bash
drush cr
```

## Verify it worked

Go to the **Manage display** tab of any entity with an image field (for example
**Structure → Content types → Article → Manage display**). Click the gear icon on an
image field using the **Image** or **Responsive Image** formatter — you should see a
new **Fetch priority** dropdown inside the **Image loading** fieldset. Set it to
**High**, save, and view the content; the rendered `<img>` tag should now carry a
`fetchpriority="high"` attribute. See the
["How to use it"](../index.md#how-to-use-it) section for guidance on the options.
