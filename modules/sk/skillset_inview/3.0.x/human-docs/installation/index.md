# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Block** (`block`) and **Serialization** (`serialization`) modules —
  Drupal enables these automatically as dependencies.
- A few **front-end JavaScript libraries** placed under your site's `/libraries`
  directory (see below). Drupal's core supports loading these directly through the
  module's `*.libraries.yml`, so the Libraries API module is *not* needed.

## Install with Composer

From the project root:

```bash
composer require drupal/skillset_inview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/skillset_inview -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Place the JavaScript libraries

The animated bars and the colour picker rely on three libraries that you download
and drop into your site's `/libraries` folder:

| Library | Where it goes | Notes |
|---------|---------------|-------|
| **jquery.easing** (1.3.2) | `/libraries/jquery.easing` | Powers the bar easing animation. |
| **jquery.inview** | `/libraries/jquery.inview` | Detects when the block scrolls into view to trigger the animation. |
| **farbtastic** (1.3) | `/libraries/farbtastic/` (e.g. `farbtastic.min.js` plus the rest of its contents) | The colour picker used by the colour form — no longer part of Drupal core from 10 onward, so you supply it yourself. |

## Enable the module

```bash
drush en skillset_inview -y
```

## Verify it worked

Add the Skillset field or place the Skillset Inview block (see
[Configuration](../configuration/index.md)), add a couple of skills with
percentage values, and load the page. Scroll the block into view — the bars
should animate in, and reset if you scroll it back out of view.
