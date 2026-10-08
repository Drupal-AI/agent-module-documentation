# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The base **Charts** module (`charts`), enabled. Drupal will pull it in as a
  dependency.
- The **Kendo UI** JavaScript library (commercial — a licence is required, with a
  30‑day trial available). You install the library files manually, as described
  below.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/charts_kendo_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charts_kendo_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the Kendo UI library files

The Kendo UI library is not bundled. Create a directory `/libraries/kendo-ui` in
your web root (or project root if you don't use a `web/` directory) and add these
files:

- `kendo.all.min.js` — the Kendo UI script.
- `default-main.css` — the Kendo default theme stylesheet.
- `telerik-license.js` — a file containing your Kendo UI licence.

Copy the script and stylesheet from the Kendo CDN (for example
`kendo.cdn.telerik.com/.../js/kendo.all.min.js` and the matching
`.../themes/.../default/default-main.css`), and paste your licence into
`telerik-license.js`. **Clear caches** after adding the files.

## Enable the module

```bash
drush en charts_kendo_ui -y
```

## Verify it worked

Edit a Views chart display or a chart field formatter and open the library
selector. **Kendo UI** should now be available as a rendering library. Pick it,
save, and view the chart to confirm it renders with Kendo UI.
