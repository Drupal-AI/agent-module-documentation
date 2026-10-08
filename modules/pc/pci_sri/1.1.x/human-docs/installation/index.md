# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drush**, since generating the SRI hashes is done with the `drush sri-gen`
  command.
- No third-party Composer libraries.

There are no additional requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pci_sri -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pci_sri -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pci_sri -y
```

## Generate the initial hashes

Enabling the module is not enough on its own — you must generate the SRI
configuration once:

```bash
drush sri-gen
drush cr
```

## Verify it worked

1. Review the generated configuration at **`/admin/structure/sri`**.
2. View the page source of any page — the module's JavaScript tags should now carry
   an `integrity` attribute.
3. Open the browser console and confirm nothing is being blocked. As a test, modify
   a non-aggregated JavaScript file in an installed module or theme and reload — the
   console should report that the altered script was blocked, proving SRI is
   working. (Restore the file afterward, or run `drush sri-gen` again if the change
   was intentional.)

> **Remember:** any time a JavaScript file changes legitimately, re-run
> `drush sri-gen` so the recorded hash matches the served file — otherwise the
> browser will block it.
