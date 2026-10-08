# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Datetime** module (`datetime`), enabled automatically as a dependency.
- The external **xdan jQuery DateTimePicker** JavaScript/CSS library, installed
  at `/libraries/jquery-datetimepicker`. This is a hard requirement for the
  picker to appear — without it the field renders as a plain text input.

## Install with Composer

From the project root:

```bash
composer require drupal/single_datetime -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/single_datetime -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the xdan DateTimePicker library

The module does **not** bundle the JavaScript library; you must add it yourself.
Download it from <https://github.com/xdan/datetimepicker> and place it so that
the files live under `/libraries/jquery-datetimepicker` in your web root — for
example `web/libraries/jquery-datetimepicker/build/jquery.datetimepicker.full.min.js`
and the matching CSS. If your site supports the Composer `asset-packagist`
workflow you can require it that way instead; the key is that the final path is
`/libraries/jquery-datetimepicker`.

If the library is missing, the widget still saves and loads values — it just
shows a plain text field instead of the calendar popup, so an absent library is
an easy problem to spot and fix.

## Enable the module

```bash
drush en single_datetime -y
```

Then assign a widget to a date field as described in
[Configuration](../configuration/index.md).

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| Single DateTime Range | `single_datetime_range` | A single-input picker widget for `daterange` (start + end) fields. |
| Single DateTime Exposed | `single_datetime_exposed` | Automatically attaches the picker to Views exposed date filters. |

For example:

```bash
drush en single_datetime_range -y
```
