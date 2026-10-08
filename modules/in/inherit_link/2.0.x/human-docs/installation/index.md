# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- The third-party jQuery **InheritLink** plugin, placed in your site's libraries
  folder (see below). This is required for the behaviour to run.
- No other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/inherit_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inherit_link -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Add the jQuery InheritLink plugin

The module integrates a jQuery plugin that is **not** distributed on Composer.
Download it from its GitHub repository and place the script at:

```text
libraries/InheritLink/InheritLink.js
```

You can get it from
`https://github.com/AliagaDev/InheritLink/archive/master.zip` (project page:
`https://github.com/AliagaDev/InheritLink`). Unzip it and copy `InheritLink.js`
into the path above inside your site's `libraries/` directory. The Drupal library
only attaches to a page when at least one Inherit Link configuration entity
exists.

## Enable the module

Enable the main module, and — unless you plan to wire everything up in code —
also enable the UI submodule to get the admin screen and the default
configuration entities:

```bash
drush en inherit_link inherit_link_ui -y
```

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| Inherit Link UI | `inherit_link_ui` | A management screen at `admin/config/inherit_link` plus default inheritance rules, so you can add/edit/delete rules through the UI instead of code. |

## Verify it worked

If you enabled the UI submodule, log in as an administrator and open
`admin/config/inherit_link` — you should see the list of inheritance rules
(including the shipped defaults for `.inherit-link` and
`.node--view-mode-teaser`). Then view a page that renders a teaser and confirm the
whole teaser is clickable while its inner links still work independently. If
nothing happens, re-check that `InheritLink.js` is at
`libraries/InheritLink/InheritLink.js` and that at least one rule exists.
