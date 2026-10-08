# Installation

## Requirements

Responsive views pager needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2||^10||^11`).
- Core's **Views** module (part of the standard install) for the pager to plug
  into.
- The **Mobile Detect** module (`mobile_detect`), which wraps the Mobile_Detect
  PHP class used for device detection. This is a required dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_views_pager -W
```

The `-W` (`--with-all-dependencies`) flag pulls in **Mobile Detect** and any
other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/responsive_views_pager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_views_pager -y
```

Mobile Detect is enabled automatically as a dependency.

## Verify it worked

Edit any View, open the **Pager** section, and click **Use pager**. The pager
options should now include **Paged output, dynamic pager**. Select it, open its
**Settings**, and you should see fields for Desktop, Tablet, and Mobile item
counts.

> **Caching note:** With Varnish, a CDN, or other external caching in front of
> your site, additional configuration may be needed so device detection stays
> reliable — the Mobile Detect library relies on User‑Agent and HTTP headers.
> Test thoroughly to avoid serving one device's item count to another.
