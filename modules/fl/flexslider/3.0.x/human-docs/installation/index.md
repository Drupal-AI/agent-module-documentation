# Installation

Installing FlexSlider has **two parts**: the Drupal module (via Composer) and the
FlexSlider 2 JavaScript library (a separate download that Composer does not place
for you automatically). The sliders won't work until both are present.

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- The **FlexSlider 2** jQuery library, placed in your site's `libraries/`
  directory (see below).

## Install the module with Composer

From the project root:

```bash
composer require drupal/flexslider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/flexslider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Install the FlexSlider 2 JavaScript library

The library is **not bundled** with the module — it's an external dependency you
must add. Place it at **`[DRUPAL ROOT]/libraries/flexslider`** so that these files
exist:

- `libraries/flexslider/jquery.flexslider-min.js` (required)
- `libraries/flexslider/flexslider.css` (required)
- `libraries/flexslider/jquery.flexslider.js` (only needed for debug mode)

The easiest way is to let Composer fetch it — the module suggests
`woothemes/flexslider:~2.0`:

```bash
composer require woothemes/flexslider:~2.0
```

(You may need an appropriate `installer-paths` / asset‑packagist setup for it to
land in `libraries/`. Alternatively, download the library from the FlexSlider
project and unzip it into `libraries/flexslider` manually.)

## Enable the module

```bash
drush en flexslider -y
```

## Enable the display submodules

The base module provides optionsets; the actual display integrations come from
two submodules — enable the ones you need:

| Submodule | What it adds |
|-----------|--------------|
| **FlexSlider Fields** (`flexslider_fields`) | The **FlexSlider** image field formatter for multi‑value image fields (plus a **Responsive FlexSlider** formatter when core Responsive Image is on). |
| **FlexSlider Views Style** (`flexslider_views`) | The **FlexSlider** Views style so you can render a view's results as a slider. |

```bash
drush en flexslider_fields flexslider_views -y
```

## Verify it worked

Go to **Configuration → Media → FlexSlider**
(`/admin/config/media/flexslider`). You should see the `default` optionset and be
able to add more. Then apply the formatter to a multi‑value image field (or the
Views style to a view) and view the content — you should get a working slider. If
the slider doesn't animate, double‑check the JavaScript library is present under
`libraries/flexslider`.

## Advanced settings

A module‑wide settings form at `/admin/config/media/flexslider/advanced` lets you
toggle **debug mode** (load the unminified library JS), whether the **library
CSS** loads, and whether the **module's fix‑up CSS** loads. The defaults are fine
for most sites.
