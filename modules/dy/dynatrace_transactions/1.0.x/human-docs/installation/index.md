# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`, with
  support back to 8.8).
- A **Dynatrace** environment where you can configure request attributes and
  transaction naming — this is where the captured name is actually put to use.
- No additional module, Composer, or JavaScript library dependencies beyond Drupal
  core.

## Install with Composer

From the project root:

```bash
composer require drupal/dynatrace_transactions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynatrace_transactions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynatrace_transactions -y
```

## Finish the setup in Dynatrace

There is no Drupal configuration form. Once the module is enabled it produces the
transaction names; the remaining work is in your **Dynatrace** environment —
capture the name as a **request attribute** and configure transaction naming to use
it. See the [overview](../index.md) for the step‑by‑step.

## Verify it worked

After enabling the module and completing the Dynatrace‑side configuration, generate
some traffic and check your Dynatrace environment: requests should now appear under
names built from their route, entity bundle, and the acting user's highest‑weight
role, rather than generic PHP entry‑point names.

> **Note on security coverage:** this project is *not* covered by Drupal's security
> advisory policy, and it is minimally maintained. Factor that into your risk
> assessment, and remember that transaction names carry the user's role out to
> Dynatrace — keep that destination trusted.
