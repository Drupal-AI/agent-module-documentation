# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer**.
- The **`geoip2/geoip2`** PHP library (`^3`), pulled in automatically by Composer.
  It's used by the Local and Webservice plugins.
- No dependencies on other Drupal modules.
- **For the Local plugin only:** a MaxMind **GeoLite2** database file
  (`GeoLite2-City.mmdb` or `GeoLite2-Country.mmdb`) placed in your public files
  directory — supply it yourself or use the update submodule below.
- **For the Webservice plugin only:** a MaxMind account ID and license key.

## Install with Composer

From the project root:

```bash
composer require drupal/geoip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in `geoip2/geoip2`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geoip -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geoip -y
```

The default active source after install is the **CDN** plugin, which works
immediately if your site sits behind Cloudflare or CloudFront.

## Submodule — GeoLite2 Database Update

If you plan to use the **Local** plugin, the optional submodule automates keeping
the database current:

- **GeoLite2 Database Update** (`geolite2_update`) — downloads and refreshes the
  GeoLite2 `.mmdb` database automatically on cron, or on demand via the Drush
  command `drush geolite2:update`.

```bash
drush en geolite2_update -y
```

## Handling the MaxMind credentials safely

Both the Webservice plugin and the update submodule need MaxMind credentials (a
license key). Treat that key as a secret — don't hard-code it in a committed file.
With DDEV, store it in an environment variable and load it into the container:

```bash
ddev dotenv set .ddev/.env --maxmind-license-key=<value>
ddev restart
```

Then reference the value where the module or submodule expects it (or from
`settings.php` via `getenv('MAXMIND_LICENSE_KEY')`). Keep `.ddev/.env` out of
version control.

## Verify it worked

Go to **Configuration → System → GeoIP** (`/admin/config/system/geoip`). Use the
form's **manual IP lookup** to test the active plugin against a known IP — you
should get back a country code. If you're using the Local plugin, the site's
**Status report** (`/admin/reports/status`) tells you whether a database file is
present and warns if it's over a month old.

Next, see [Configuration](../configuration/index.md) to choose and set up your
geolocation source.
