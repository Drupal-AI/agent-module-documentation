# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The contributed **Webform** module (`webform`) — this is a required dependency.
  Webform Analysis extends Webform's results screens.
- An internet connection for viewers of the charts, since the pie and column
  charts are drawn with **Google Charts** (loaded from Google). Plain tables need
  no external service.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_analysis -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you do not already have Webform, add it too:

```bash
composer require drupal/webform drupal/webform_analysis -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/webform_analysis -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_analysis -y
```

Enabling it also pulls in the Webform module if it is not already on.

## Submodule — Webform Node Analysis

The module ships one optional submodule, **Webform Node Analysis**
(`webform_node_analysis`), which extends the same analysis to webforms attached to
nodes via a webform field. Enable it only if you use webform fields on nodes:

```bash
drush en webform_node_analysis -y
```

## Access

Webform Analysis does not define its own permission. Who can see a webform's
Analysis tab is controlled by Webform's own results‑access permissions (such as
"view any webform submission"). Make sure the roles that should see analysis
already have the appropriate Webform submission‑results access.

## Verify it worked

Go to a webform's results — **Structure → Webforms → (a webform) → Results** — and
you should now see an **Analysis** tab. Open it to configure the statistics; see
[Configuration](../configuration/index.md).
