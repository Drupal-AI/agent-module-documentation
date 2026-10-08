# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Style Options** module (`style_options`) — a hard dependency.
- The **Domain** module — a soft dependency. With Domain installed and a domain
  negotiated, options are filtered per domain; without it (or during CLI/install
  when no domain is active), all options are shown unchanged and no errors occur.

## Install with Composer

From the project root:

```bash
composer require drupal/style_options_domain -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Style Options and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/style_options_domain -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en style_options_domain -y
```

To actually scope options by domain you will also want the **Domain** module
installed and your domains configured; otherwise the module stays inert and all
options display normally.

## Verify it worked

After enabling, add a `contexts.domain` key to a style option in one of your
`*.style_options.yml` files — disabling it by default and re-enabling it for one
domain — then rebuild caches. Visiting that domain, editors should see the option;
on other domains, they should not.
