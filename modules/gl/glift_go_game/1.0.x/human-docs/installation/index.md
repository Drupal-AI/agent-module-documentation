# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other modules are required. The **Glift** JavaScript viewer library is
  bundled with the module, so there is no separate library download.

## Install with Composer

From the project root:

```bash
composer require drupal/glift_go_game -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/glift_go_game -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en glift_go_game -y
```

## Enable the filter

The module does nothing until you turn on its text‑format filter. Go to
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit the format your content uses, tick the
**Glift go game** filter, and save.

## Verify it worked

In a piece of content that uses the filtered format, add
`[glift]https://example.com/some-game.sgf[/glift]` (pointing at a real SGF file)
and view the content. If an interactive Go board renders in place of the tag, the
module and filter are working.
