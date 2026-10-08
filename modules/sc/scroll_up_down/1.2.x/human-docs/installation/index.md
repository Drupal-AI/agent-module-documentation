# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No dependent modules, no PHP version requirement, and no third-party Composer or
  JavaScript libraries — the module ships its own vanilla JavaScript.
- Any modern browser that supports smooth scrolling (`window.scrollTo({behavior: 'smooth'})`).

## Install with Composer

From the project root:

```bash
composer require drupal/scroll_up_down -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scroll_up_down -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scroll_up_down -y
```

That is all it takes. The scroll-up and scroll-down buttons are attached to all
pages immediately for any user who has permission to see them.

## Choose who sees the buttons

Scroll Up Down provides its own permission controlling who may view the arrows. Go
to **People → Permissions** (`/admin/people/permissions`), find the Scroll Up Down
entry, grant it to the roles that should see the buttons, and click **Save
permissions**.

## Verify it worked

Open a page that is long enough to scroll and scroll down. The floating buttons
should fade into view — one to jump back to the top, one to jump to the bottom —
and fade out again as you return near the top of the page.
