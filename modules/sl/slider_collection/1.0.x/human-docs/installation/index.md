# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) enabled — the sliders are built as a Views
  style, so this is the only module dependency.
- The **JavaScript slider library** for whichever submodule you enable (Swiper or
  Tiny Slider). The submodules ship a `composer.libraries.json` so the library can
  be pulled in via the Composer merge plugin (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/slider_collection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slider_collection -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

### Pulling in the slider library

Each library submodule declares its front-end library in a
`composer.libraries.json` file, which you include using the Composer merge plugin:

1. Add the merge plugin if you do not already have it:

   ```bash
   composer require 'wikimedia/composer-merge-plugin:^2.0'
   ```

2. In your project `composer.json`, add the include(s) under the `extra` section.
   To pull in only the Swiper library, for example:

   ```json
   {
     "extra": {
       "merge-plugin": {
         "include": [
           "web/modules/contrib/slider_collection/modules/sc_swiper/composer.libraries.json"
         ],
         "recurse": true
       }
     }
   }
   ```

   You can point the include at all submodules
   (`web/modules/contrib/*/modules/*/composer.libraries.json`) or at just the one
   library you intend to use.

## Enable the module and a library submodule

Enable the base module together with at least one library submodule — the base
alone does nothing visible:

```bash
drush en slider_collection sc_swiper -y
```

## Submodules

| Submodule | Machine name | Slider library |
|-----------|--------------|----------------|
| **Swiper** | `sc_swiper` | Swiper — the current, full-featured standard. |
| **Tiny Slider** | `sc_tinyslider` | Tiny Slider 2 — small, vanilla JavaScript. |

Enable whichever you need (`drush en sc_tinyslider -y` for Tiny Slider). Each
submodule requires the base Slider collection module.

## Verify it worked

Create a View listing some content and, for the display format, choose the slider
style provided by the submodule you enabled. Save and view the page — the listed
items should render as a working slider.
