# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Next.js** module (`next:next`) — a required dependency that provides the
  base Next.js integration and the Next.js site entities this module extends.
- A **Next.js application** configured with revalidation endpoints for it to call.

There are no third‑party PHP library requirements.

> **Note:** this module is **deprecated** — its functionality has been ported into
> the Next.js module. Prefer the built‑in revalidation for new sites.

## Install with Composer

From the project root:

```bash
composer require drupal/next_tag_revalidator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Next.js module
and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/next_tag_revalidator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en next_tag_revalidator -y
```

## Verify it worked

Go to **Configuration → Web Services → Next.js sites**, edit one of your Next.js
site entities, and click **Add revalidator**. You should now see **Next.js Cache
Tag** among the available revalidator types. Continue with
[Configuration](../configuration/index.md) to set it up.
