# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core`) and **Paragraphs** (`paragraphs`) — the shared base and
  field system that every Extra Paragraph Types module builds on.
- Core **Datetime** (`datetime`) — the countdown's target date is a datetime value.

Composer resolves the module's dependencies for you with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_countdown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the EPT base and Paragraphs alongside this
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ept_countdown -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ept_countdown -y
```

Drupal will enable `ept_core`, Paragraphs, and Datetime too if they aren't already
on.

## Verify it worked

Edit content that has a Paragraphs field allowing the Countdown type (or add such a
field first). Add a **Countdown** paragraph, set a target date/time, and save — an
animated countdown should render as its own section. Confirm the timezone behaviour
matches your intent before publishing.
