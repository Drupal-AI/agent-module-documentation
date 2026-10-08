# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies and no external PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/codefilter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/codefilter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en codefilter -y
```

## Turn on the filter

Enabling the module does not change any output on its own — the filter has to be
switched on inside a **text format**. Go to **Configuration → Content authoring →
Text formats and editors**, configure the format you want, tick the **Code
filter**, check the filter processing order, and save. The full steps are in the
"How to use it" section of the [guide](../index.md).

## Verify it worked

In a piece of content using the format where you enabled the filter, write
something like:

```
<code><?php print "Hello, world!"; ?></code>
```

On the rendered page it should appear as a formatted code block with the angle
brackets intact — not interpreted as markup.
