# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- No module dependencies and no third‑party PHP libraries. The Facebook social‑plugin
  script is loaded from Facebook at runtime.

> **Heads up:** the Like button needs a publicly reachable URL for Facebook to fetch,
> so it may not render correctly on a local or not‑yet‑public site. Test it on a
> live environment.

## Install with Composer

From the project root:

```bash
composer require drupal/fblikebutton -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fblikebutton -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fblikebutton -y
```

## Verify it worked

Open the settings form (route `fblikebutton.settings`, under **Configuration**),
choose the content type(s) that should show the button, and grant the *Access FB
Like button* permission to the appropriate roles (see
[Configuration](../configuration/index.md)). Then view a node of a selected type on
the live site — the Facebook Like button should appear. If it does not, confirm the
page URL is publicly reachable.
