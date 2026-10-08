# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).
- No other Drupal module dependencies, and no third‑party Composer or PHP library
  requirements.

> **Before you install:** this module is **obsolete and unsupported**, and it is
> **not covered by the security advisory policy**. Install it only if you need it
> for an existing site or as a code reference — not for new work.

## Install with Composer

From the project root:

```bash
composer require drupal/pluggable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pluggable -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pluggable -y
```

## Verify it worked

Because Pluggable is a developer framework, the clearest check is to add a field
backed by a `pluggable_item` derivative to a content type at **Structure →
Content types → *(type)* → Manage fields** and confirm the **Pluggable select**
and **Pluggable radios** widgets are offered on **Manage form display**, with your
plugin‑provided options appearing as values.
