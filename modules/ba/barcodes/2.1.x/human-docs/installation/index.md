# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **`tecnickcom/tc-lib-barcode`** PHP library (`^2.0`) — this is the actual
  barcode generator. Because it is a Composer requirement of the module, `composer
  require` installs it automatically; there is nothing to download by hand.
- **Drush 12+** if you want to use the `barcodes:generate` / `barcodes:formats`
  commands.

Optionally, the **Token** module (`drupal/token`) enables token replacement inside
barcode values (for example `[node:url]` in a block). It is a suggested, optional
companion.

## Install with Composer

From the project root:

```bash
composer require drupal/barcodes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`tecnickcom/tc-lib-barcode` and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/barcodes -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en barcodes -y
```

## Optional: add Token for token-aware values

```bash
composer require drupal/token -W
drush en token -y
```

With Token enabled, the Barcode block's value field gains a token browser, so you
can encode dynamic values like the current page URL.

## Next steps

There is no configuration form to visit. Head to
[Configuration](../configuration/index.md) to learn the barcode options, then use
one of the four surfaces described in
[How to use it](../index.md#how-to-use-it).
