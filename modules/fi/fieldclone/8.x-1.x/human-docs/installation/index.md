# Installation

## Requirements

- **Drupal 8.7.7+, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- The **Replicate** module (`drupal/replicate`) — a contributed dependency that
  performs the underlying field-value copying. Composer installs it for you when you
  require Field Clone.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fieldclone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Replicate
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fieldclone -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Field Clone (Replicate is enabled automatically as a dependency):

```bash
drush en fieldclone -y
```

## Verify it worked

Pick an existing node and note its ID and a field it has (for example node 17 with
`field_common`). Open a matching add form with a clone parameter, such as
`node/add/page?fieldclone=node:17:field_common`. The new form should open with that
field pre-filled from the source node. If you lack view access to the source or the
field, the module returns an error and copies nothing — that is the expected
access-checked behavior.
