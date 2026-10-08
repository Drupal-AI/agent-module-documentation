# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 | ^11`). *(Note: the project
  writes this with a single pipe rather than Composer's `||` OR syntax; if you hit
  a version‑constraint issue, that's worth checking.)*
- Core's **File** (`file`) and **Image** (`image`) modules — enabled automatically
  as dependencies.
- The **`rosell-dk/webp-convert`** PHP library (`^2.9`) — usually installed with
  the module; if not, install it separately (see below).
- **A working conversion tool** on the server — one of **cwebp** (the WebP
  command‑line binary), **Imagick**, or **GD**. Make sure at least one is
  available and choose it in the module's settings.

## Install with Composer

From the project root:

```bash
composer require drupal/image_webp_converter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If the WebP conversion library wasn't pulled in
automatically, add it explicitly:

```bash
composer require rosell-dk/webp-convert:^2.9
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_webp_converter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.
> The `cwebp` binary must be present in the environment where images are
> processed — inside the DDEV web container if you use DDEV.

## Enable the module

```bash
drush en image_webp_converter -y
```

## Allow the .webp extension on your fields

If your file or image fields don't already permit `.webp`, add it: go to
**Structure → Content types → *(your type)* → Manage fields**, edit the file or
image field, and add `webp` to the list of allowed file extensions. Otherwise
converted files may be rejected.

## Verify it worked

Confirm the module is enabled (**Extend**, or `drush pm:list | grep
image_webp_converter`) and that the settings page loads at **Configuration →
Media → Image WebP Converter Settings**
(`/admin/config/media/image-webp-converter`). Then continue to
[Configuration](../configuration/index.md).

> **Before running any site‑wide conversion, take a database backup** — the module
> rewrites source files and the references to them, and the change is not
> reversible.
