# Installation

## Requirements

Vendor Stream Wrapper is self-contained:

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- No third-party Composer or PHP library requirements, and no other contrib
  modules.
- A Composer-managed site (so there is a `vendor/` directory to point at). The
  module looks for it at `../vendor` then `./vendor` by default, or at
  `$settings['vendor_file_path']` if you set that in `settings.php`.

## Install with Composer

From the project root:

```bash
composer require drupal/vendor_stream_wrapper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/vendor_stream_wrapper -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en vendor_stream_wrapper -y
```

**Next step is required:** enabling the module registers the `vendor://` wrapper,
but no vendor files are web-accessible until you add safe-list patterns. Drupal's
status report will show a warning until you do. See the
[overview](../index.md#how-to-use-it) for how to add patterns and reference vendor
assets.

## Verify it worked

Open **Configuration → Media → Vendor Stream Wrapper**
(`/admin/config/media/vendor-stream-wrapper`) — the allowed-patterns form should
load. After you add a pattern and reference a vendor asset in a library, load a
page that uses that library and confirm the asset resolves to a `/vendor_files/...`
URL.
