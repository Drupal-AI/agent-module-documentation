# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No module dependencies and no Composer/PHP library requirements.
- A **writable public filesystem** — the module saves generated CSS to
  `public://custom_css_adder/`, so that directory must be writable.

> **Before you install:** this project is marked **Unsupported / Obsolete**, is
> **not covered** by a security advisory policy, and has a documented bug in its
> preview theme‑switch path. Consider whether a maintained alternative fits better,
> and test carefully if you proceed.

## Install with Composer

The Composer package name (`cssditor`) differs from the module machine name
(`custom_css_adder`). Require it by the package name:

```bash
composer require drupal/cssditor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cssditor -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `custom_css_adder` — not `cssditor`:

```bash
drush en custom_css_adder -y
```

Editing custom CSS requires the **Administer themes** (`administer themes`)
permission, which administrators have by default.

## Verify it worked

Go to **Appearance → Settings** and open any theme's settings form. A **CSS
customization** section should now appear. Enable it, paste a small test rule
(for example changing a background colour), save, and load a front‑end page to
confirm your CSS is applied. See the [main guide](../index.md#how-to-use-it) for the
full walkthrough.
