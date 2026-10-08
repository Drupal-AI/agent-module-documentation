# Installation

## Requirements

Entity Reference Revisions has one core dependency and no third-party libraries. It
needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Field** module (`field`) enabled — Drupal enables it automatically as a
  dependency when you turn on ERR (and it is enabled on virtually every site
  already).

There are no PHP library requirements. Optionally, the **Diff** module
(`drupal/diff`) integrates with ERR so that revisioned references appear in entity
revision comparisons — install it separately only if you want that feature.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_revisions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. In practice you will often find ERR already present,
because it is a dependency of the Paragraphs module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_revisions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_revisions -y
```

ERR has no required configuration and no settings form. Once enabled, the
**Entity reference revisions** field type is available to add to any fieldable
entity type through Drupal's Field UI (see the
[main guide](../index.md#how-to-use-it) for where it appears).

## Verify it worked

Go to **Structure → Content types → [any type] → Manage fields → Add field**. In
the list of field types you should now see **Entity reference revisions**. You may
also want to review the new **Delete orphan revisions** permission at
**People → Permissions**, which controls access to the orphan-cleanup admin form.
