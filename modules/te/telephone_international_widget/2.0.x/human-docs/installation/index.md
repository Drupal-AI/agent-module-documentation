# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Telephone** module (`telephone`) — a declared dependency, enabled
  automatically.
- The **`jackocnr/intl-tel-input`** JavaScript library. The module expects this to
  be available via the Libraries API and lists it as a `drupal-library`. Composer
  is the supported way to get it — see the note below and the module's own README.

## Install with Composer

From the project root:

```bash
composer require drupal/telephone_international_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The module is set up so that `intl-tel-input` is pulled in
as a `drupal-library`; if your project is not already configured to place
`drupal-library` packages into a libraries directory, follow the module's README to
get the library and its Composer setup in place — the widget will not work without
the JavaScript library present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/telephone_international_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en telephone_international_widget -y
```

## Set the widget on a field

Enabling the module does not change any existing fields. To use it:

1. Go to the content type (or other entity) that has a **telephone** field and open
   **Manage form display**.
2. Set that field's **Widget** to the Telephone International Widget.
3. Save.

## Verify it worked

Add or edit content using that form. The telephone field should now show a country
selector with flags, format the number as you type, and flag numbers that do not
validate for the selected country. Remember that this validation is client‑side
only — enforce anything you depend on with server‑side validation as well.
