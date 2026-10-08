# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **System** module (`system`, 8.4+) — always present in a Drupal install.

There are no third‑party Composer or PHP library requirements.

> **Before you install:** the maintainers recommend *against* installing this
> module unless you specifically need to preserve the pre‑8.4 publishing UI.
> Drupal core's current publishing UX is generally the better choice for new
> sites.

## Install with Composer

From the project root:

```bash
composer require drupal/publishing_dropbutton -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/publishing_dropbutton -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en publishing_dropbutton -y
```

## Finish the setup

Enabling the module isn't quite enough on its own — for each content type where
you want the dropbutton, go to **Structure → Content types → *(bundle)* → Manage
form display** and move the **Status** field into the **Disabled** region. See the
[overview](../index.md) for details.

## Verify it worked

After hiding the Status field on a content type, add or edit a node of that type.
The separate *Published* checkbox should be gone, replaced by a dropbutton‑style
publishing control (or the moderation‑state dropbutton if Content Moderation is
in use).
