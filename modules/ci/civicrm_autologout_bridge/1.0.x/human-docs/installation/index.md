# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **[Automated Logout](https://www.drupal.org/project/autologout)** module,
  version **2.x or later** — this module extends Automated Logout's session
  keep-alive mechanism and requires it to be installed and configured.
- **CiviCRM** installed with Drupal integration (the `civicrm` module).

No additional modules or libraries are needed. Automated Logout's own configuration
(timeout duration, logout redirect, cross-tab cookie synchronisation) continues to
apply as normal.

## Install with Composer

From the project root:

```bash
composer require drupal/civicrm_autologout_bridge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/civicrm_autologout_bridge -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en civicrm_autologout_bridge -y
```

That's it — there is no configuration step. Once enabled, the module attaches its
JavaScript automatically to CiviCRM pages for authenticated users.

## Verify it worked

Open a CiviCRM page, open your browser's developer console, and run:

```js
document.body.addEventListener('preventAutologout', () => console.log('bridge signalled'));
```

Then scroll the page or trigger any CiviCRM AJAX action (open a popup, submit an
inline edit). Within about five seconds you should see `bridge signalled` logged in
the console, confirming the keep-alive is firing.

> **Advanced:** the only tunable value is the debounce interval (`SIGNAL_INTERVAL`)
> in `js/civicrm_autologout_bridge.js`. There is no UI for it; most sites never need
> to change it.
