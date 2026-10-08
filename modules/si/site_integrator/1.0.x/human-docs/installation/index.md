# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules or PHP libraries are required.

Note: this project is currently a **beta** release and is **not covered by Drupal's
security advisory policy**. Because the enhanced-iframe and merged-HTML modes fetch a
remote site server-side, weigh the proxy/SSRF considerations described in the
[overview](../index.md) before pointing it at untrusted hosts.

## Install with Composer

From the project root:

```bash
composer require drupal/site_integrator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_integrator -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_integrator -y
```

## Verify it worked

Open the site's **Configuration** page and look under the **External Data** section for
the **Integrated Sites** link. From there you can add your first integrated site — enter
its URL, choose how it should be presented (classic iframe, enhanced server-side-fetched
iframe, or merged HTML), and save. Then view the resulting page to confirm the external
content appears as expected. Grant the module's permission only to the trusted roles that
should manage integrations.
