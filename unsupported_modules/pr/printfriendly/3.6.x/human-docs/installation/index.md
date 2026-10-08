# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no module dependencies and no third‑party Composer or PHP library
requirements — the PrintFriendly widget is loaded at runtime from
`cdn.printfriendly.com`, not installed locally. No API key is needed for the basic
print/PDF/email button (some advanced PrintFriendly capabilities, such as printing
password‑protected or JavaScript‑rendered pages, require a PrintFriendly **Pro**
subscription on their side).

## Install with Composer

From the project root:

```bash
composer require drupal/printfriendly -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/printfriendly -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en printfriendly -y
```

## Next steps

The button won't appear until you choose which content types show it and grant the
viewing permission:

1. Open the settings form at `/admin/config/printfriendly/config` and select the
   content types (and optional teasers) plus a button image.
2. Grant the **Access printfriendly** permission (at **People → Permissions**) to
   the roles that should see the button; grant **Administer printfriendly** only to
   trusted admins.

See the [Configuration](../configuration/index.md) guide for every option. There
are no submodules.
