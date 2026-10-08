# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A working **private file system** — that is, Drupal's private file path
  configured (`$settings['file_private_path']` in `settings.php`) and files stored
  under the `private://` stream wrapper. The module only affects private files.

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/private_file_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/private_file_token -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en private_file_token -y
```

The module works site‑wide the moment it is enabled — there is nothing you *must*
configure. From then on, every generated URL to a `private://` file carries a
signed `token` and `timestamp`, and requests bearing a valid, unexpired token are
allowed to download.

> **Be deliberate about enabling this.** Because it is site‑wide and not per‑file,
> turning it on changes how *all* private files on the site can be accessed. Review
> [Configuration](../configuration/index.md) and the security note first.

## Verify it worked

View a page that renders a private file or private image style, then inspect the
file's URL in the page source. It should now include `?token=...&timestamp=...`.
Opening that full URL (even without being logged in) should download the file;
without those parameters, the normal private‑file access check still applies.
