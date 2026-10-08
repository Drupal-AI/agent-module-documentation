# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) — the only module dependency, and it's part
  of core (enabled on most sites already).
- To actually animate slides you need a **slideshow engine**. The bundled
  **Views Slideshow Cycle** submodule provides one, but it in turn needs the
  external **jQuery Cycle** library installed under your site's `/libraries`
  directory. Without an engine, the base module has no animation to drive.

## Install with Composer

From the project root:

```bash
composer require drupal/views_slideshow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_slideshow -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the jQuery Cycle library

The Cycle engine relies on the external jQuery Cycle library, which is **not**
shipped with the module. Download it and place it under your site's `/libraries`
directory (for example `libraries/jquery.cycle/`) as described on the module's
project page. Without it, the Cycle slideshow won't rotate.

## Enable the module

Enable the base module and the Cycle engine submodule:

```bash
drush en views_slideshow views_slideshow_cycle -y
```

The base **Views Slideshow** module is an API on its own — you'll almost always
want the Cycle submodule (or another engine) enabled too, or there's nothing to
animate the slides.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Views Slideshow Cycle** | `views_slideshow_cycle` | The jQuery Cycle slideshow engine — the *slideshow type* that actually rotates the slides. This is the standard engine most sites use, and it needs the jQuery Cycle library installed under `/libraries`. |

After enabling, build your slideshow in the Views UI — see the
[overview](../index.md#how-to-use-it).
