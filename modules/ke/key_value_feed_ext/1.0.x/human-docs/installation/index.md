# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Feeds** module (`feeds`) — provides the import framework.
- The **Key Value Field** module (`key_value_field`) — provides the `key_value` and
  `key_value_long` field types this module maps into.

Both are enabled as dependencies. You'll also need at least one entity with a
`key_value` or `key_value_long` field for an importer to write to.

## Install with Composer

From the project root:

```bash
composer require drupal/key_value_feed_ext -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Feeds and Key Value
Field and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/key_value_feed_ext -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en key_value_feed_ext -y
```

Or enable **Key Value Field Feeds Extension** on the **Extend** page
(`/admin/modules`). Feeds and Key Value Field are enabled as dependencies.

## Verify it worked

Go to a Feed Type's **Mapping** tab (**Structure → Feed types → *(your feed type)* →
Mapping**). When you add a mapping target, **Key Value (Plain Text)** and **Key
Value Long (Formatted Text)** should appear in the list of available targets.

> **Heads up:** This release is a beta and is not covered by Drupal's security
> advisory policy.
