# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No Drupal module dependencies and no third‑party PHP libraries.
- **A running Varnish server** in front of your site, configured with a compatible
  VCL. The module ships a `default.vcl` you can use as a starting point — deploy it (or
  merge it into your existing VCL) on your Varnish host.

## Install with Composer

From the project root:

```bash
composer require drupal/adv_varnish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/adv_varnish -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en adv_varnish -y
```

## Point it at Varnish and configure the VCL

Enabling the module is not enough on its own — you must:

1. Deploy the module's `default.vcl` (or integrate its logic into your VCL) on your
   Varnish server and reload Varnish.
2. In Drupal, open **Configuration → Development → Advanced Varnish**
   (`/admin/config/development/adv_varnish`) and set the Varnish server host(s), the
   secret, and your caching options — see [Configuration](../configuration/index.md).

## A note on the Varnish secret

The settings form includes a Varnish **secret** used to authenticate purge/BAN
requests to your server. Treat it as sensitive: rather than committing it in exported
config, store it in an environment variable and reference it from `settings.php` via a
`$config` override.

> **On DDEV**, save a secret without committing it:
> `ddev dotenv set .ddev/.env --varnish-secret=<value>` (keep `.ddev/.env` out of
> version control), `ddev restart`, then override the config value from `settings.php`
> using `getenv('VARNISH_SECRET')`.

## Verify it worked

After configuring the server host and secret, edit a piece of content and confirm the
change appears on the front end promptly (the module BANs the affected cache tags in
Varnish on save). You can also use the **Clear Varnish cache** form (available when the
purger is enabled) to purge a tag or URL manually and confirm the purge succeeds. If
Varnish is unreachable the module uses short timeouts so Drupal never hangs — check
your logs (enable the module's debug/logging options while testing) if purges don't
land.
