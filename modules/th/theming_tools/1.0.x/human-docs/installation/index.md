# Installation

> **Development only.** Theming Tools is intended for local development and
> regression testing. Several submodules deliberately open admin routes to
> anonymous users, ship fixture content and test data, or disable render caching.
> Do not install it on a production or public-facing site.

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Some test submodules depend on the **Contact** contrib module (moved out of core
  in recent Drupal versions). Enable it if you use those submodules.
- No third-party Composer libraries beyond that.

## Install with Composer

From the project root:

```bash
composer require drupal/theming_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/theming_tools -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en theming_tools -y
```

Then enable whichever test submodules you need — for example:

```bash
drush en button dialog table tabledrag dropbutton textform textarea -y
```

Or enable everything at once from the dashboard at
`/admin/modules/theming-tools`. Because the submodules are auto-discovered, each
one you enable immediately appears both on the dashboard and in the "Theming Tools"
navigation group.

## Verify it worked

Visit `/admin/modules/theming-tools`. You should see the dashboard listing the
available test submodules with enable/disable operations. Open any enabled test
page from the "Theming Tools" navigation group to confirm the component renders in
your current admin theme.
