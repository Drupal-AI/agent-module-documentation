# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** module enabled — the module's only declared dependency.
- For genuine **file** protection (not just entity protection), Drupal's
  **private file system** must be configured (a `private://` path set in
  `settings.php`) and your restricted media stored there. See the
  [Configuration](../configuration/index.md) notes.

There are no third‑party Composer or PHP library requirements.

> **Remember:** this is an experimental, proof‑of‑concept module its maintainers do
> not consider production‑ready. Review the code and test it against your site's
> needs before deploying it.

## Install with Composer

From the project root:

```bash
composer require drupal/media_private_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_private_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_private_access -y
```

By itself, enabling the module changes nothing: it leaves every media type
unaltered until you explicitly assign an access mode to a type on the settings
page.

## Verify it worked

Log in as an administrator and visit **Configuration → Media → Media Private
Access Settings** (`/admin/config/media/media-private-access`). If the settings
page loads, the module is installed. Continue to
[Configuration](../configuration/index.md) to choose an access mode for each media
type you want to protect — and read the file‑bytes caveat before you rely on it.
