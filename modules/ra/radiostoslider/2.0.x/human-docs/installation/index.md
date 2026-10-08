# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Options** module (`options`) — required for the List fields this widget
  applies to; Drupal enables it as a dependency.
- The **radios‑to‑slider** JavaScript library (downloaded separately — see below).

## Install with Composer

From the project root:

```bash
composer require drupal/radiostoslider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/radiostoslider -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Download the JavaScript library (required)

The slider effect comes from an external library that is not shipped with the module.
Download the **Radios to Slider** library and extract it into your site's libraries
directory so the files live at:

```
/libraries/radios-to-slider/
```

Without this library the widget cannot render the slider.

## Enable the module

```bash
drush en radiostoslider -y
```

## Verify it worked

Go to the **Manage form display** of an entity type that has a single‑value List
(options) field (**Structure → Content types → *(type)* → Manage form display**). The
**Radios to slider** widget should be available for that field. Select it, save, and
add/edit an item of that type — the options should appear as a slider rather than
radio buttons. If they still appear as plain radios, re‑check that the library is in
`/libraries/radios-to-slider/`.
