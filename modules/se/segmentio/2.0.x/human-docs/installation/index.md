# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- A **Segment account** — you need a source **write key** from Segment for the
  module to do anything. You can create a test account at
  <https://segment.io/signup>.

Segmentio declares no contrib module dependencies and no PHP or third-party
library requirements (Segment's `analytics.js` is loaded from Segment's own
hosting at runtime).

## Install with Composer

From the project root:

```bash
composer require drupal/segmentio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/segmentio -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en segmentio -y
```

## Verify it worked

After enabling, go to **Configuration → System → Segmentio** and enter your
Segment write key (see [Configuration](../configuration/index.md)). Until a write
key is set, no tracking snippet is emitted — and if tracking would otherwise run
with no key configured, the module logs an emergency-level message noting that no
write key is present. Once the key is saved, view any page's source and you should
see the Segment settings in `drupalSettings`.
