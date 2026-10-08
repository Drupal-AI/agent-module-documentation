# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no module dependencies and no third‑party PHP libraries.

> **Environment warning:** Loki deliberately returns server errors. Install and
> enable it only in **development, staging, or a controlled test environment** —
> never on a production site serving real users.

## Install with Composer

From the project root:

```bash
composer require drupal/loki -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/loki -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en loki -y
```

Enabling the module does **not** start injecting errors — the chaos is off until
you turn it on and set a probability in the settings form. See
[Configuration](../configuration/index.md).

## Verify it worked

Open **Configuration → Development → Loki** (`/admin/config/development/loki`) —
you should see the Loki settings form. To confirm the behaviour, enable it with a
high failure percentage for the **anonymous** role, then request a page as an
anonymous visitor (for example with `curl`) a few times; you should see 5xx
responses mixed in with normal ones. Turn it back off when you're done.
