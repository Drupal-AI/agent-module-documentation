# Installation

Installing Bootstrap Datepicker is a **two-part** job: install the Drupal module,
and separately download the third-party JavaScript/CSS library it renders with.
The calendar popup will not appear until both are in place (the field still saves
without the library, just with the plain input).

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Datetime**, **Datetime Range** and **System** modules — all standard,
  and enabled automatically as dependencies.
- The **uxsolutions/bootstrap-datepicker** JavaScript/CSS library, installed at
  `/libraries/bootstrap-datepicker` (see below).

There are no third-party *Composer* packages and no submodules.

## Install the module with Composer

From the project root:

```bash
composer require drupal/bootstrap_datepicker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_datepicker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the JavaScript library

The module needs the actual bootstrap-datepicker library files present in your
site's `libraries` directory. Download the library from
<https://github.com/uxsolutions/bootstrap-datepicker> and place it so that the
files live under:

```
web/libraries/bootstrap-datepicker/
```

(The exact `web/` prefix depends on your project's docroot — the important part is
that the module can find the library at the path `/libraries/bootstrap-datepicker`.)

A quick way to fetch a release:

```bash
mkdir -p web/libraries/bootstrap-datepicker
cd web/libraries/bootstrap-datepicker
# download and unpack a release from the project's GitHub releases page,
# so that the dist/ (js + css) files end up under this folder.
```

If you use `composer/installers` with an asset repository, you may be able to pull
the library in via Composer as `bower-asset`/`npm-asset` instead — but a manual
download into `/libraries/bootstrap-datepicker` always works.

> **How to tell it's missing:** if you select the widget and the field renders as
> an ordinary text/date input with no calendar popping up, the library isn't being
> found. Double-check the folder path and that the library's JS and CSS files are
> present.

## Enable the module

```bash
drush en bootstrap_datepicker -y
```

## Verify it worked

1. On a content type with a Date/time field, go to **Manage form display**
   (e.g. `/admin/structure/types/manage/article/form-display`) and set that
   field's **Widget** to **Bootstrap Datepicker**, then **Save**.
2. Open the node add/edit form for that content type. Clicking into the date field
   should now show the Bootstrap calendar popup.

For choosing options like format, language and date ranges, see the "How to use
it" section on the [overview page](../index.md).
