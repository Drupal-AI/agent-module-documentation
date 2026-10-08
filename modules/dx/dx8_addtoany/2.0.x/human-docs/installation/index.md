# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An **Acquia Site Studio** subscription and the Site Studio module, installed and
  configured — this module only does anything within Site Studio.
- The **AddToAny** module, which supplies the actual share‑button functionality this
  module exposes.

There are no additional third‑party Composer or PHP library requirements beyond
those brought in by Site Studio and AddToAny.

## Install with Composer

From the project root:

```bash
composer require drupal/dx8_addtoany -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Install AddToAny the same way if it isn't already present:

```bash
composer require drupal/addtoany -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dx8_addtoany -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dx8_addtoany -y
```

## Verify it worked

Open the Site Studio editor and look in the **element sidebar** — an **AddToAny**
element should now be listed. Drag it onto a page, choose a couple of networks, and
save; the share buttons should appear on the rendered page with its URL and title
detected automatically.
