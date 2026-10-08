# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Redirect](https://www.drupal.org/project/redirect)** module,
  **version 1.12 or newer** (`redirect`) — for support on older Redirect
  releases, see the project's issue queue. Composer pulls Redirect in for you.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Redirect module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redirect_widget -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_widget -y
```

## Turn on the widget for a content type

Enabling the module isn't quite enough — you also expose the widget per content
type on its **Manage form display**:

1. Go to **Structure → Content types → *(your type)* → Manage form display**.
2. Ensure the **URL redirects (`url_redirects`)** field is not disabled.
3. Save.

## Verify it worked

Edit a node of that content type. The redirect sidebar element provided by this
module should replace the Redirect module's default one — type a destination to
redirect that page, or clear it to remove the redirect. Settings for the widget
are at `/admin/config/search/redirect/widget`.
