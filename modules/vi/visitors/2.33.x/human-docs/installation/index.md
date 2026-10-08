# Installation

## Requirements

Visitors is a bigger module than most and pulls in a few libraries:

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core **Views** and **Path** modules (enabled automatically as dependencies).
- The **Charts** module and its **Chart.js** sub‑provider (`charts_chartjs`) — the reports
  are drawn with Chart.js.
- Two third‑party PHP libraries, installed automatically by Composer:
  - **matomo/device‑detector** (`^6.1`) — device, browser and OS detection.
  - **geoip2/geoip2** (`~2.0`) — used by the optional GeoIP submodule for geolocation.

Because of those library dependencies, always install this module **with Composer** (not
by downloading a tarball) so the libraries land in `vendor/`.

## Install with Composer

From the project root:

```bash
composer require drupal/visitors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Charts, device‑detector,
geoip2, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/visitors -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en visitors -y
```

Enabling Visitors also enables its Views/Path/Charts dependencies. Once on, the tracker
starts recording visits according to the default visibility rules, and the reports
appear at `/visitors` for users with the *access visitors* permission.

## Optional submodule — Visitors GeoIP

For country/region/city reports, enable the bundled **Visitors GeoIP**
(`visitors_geoip`) submodule:

```bash
drush en visitors_geoip -y
```

It uses the geoip2/geoip2 library and a MaxMind database; its own Drush commands handle
downloading the database and rebuilding geolocation data for existing log rows. See the
submodule's nested docs for details.

## Verify it worked

Visit a few pages of your site as an anonymous user, then log in as an administrator and
open **`/visitors`**. You should see hits starting to appear in the reports. If you want
to fine‑tune what is tracked and how long logs are kept, see
[Configuration](../configuration/index.md).
