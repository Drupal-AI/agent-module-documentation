# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Options** (`options`) and **User** (`user`) modules — part of Drupal core.
- The contributed **Entity Content Visibility**
  (`entity_content_visibility`) module, which provides the per‑popup visibility rules.
  Composer installs it for you when you use the `-W` flag below.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/popup_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity Content Visibility and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/popup_entity -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en popup_entity -y
```

Drupal enables the Entity Content Visibility dependency automatically.

## Grant permissions

Popup Entity ships several granular permissions. On **People → Permissions**
(`/admin/people/permissions`) grant, as appropriate for each role:

- **View popup entity** — needed to see published popups.
- **Add popup entity** / **Edit popup entity** / **Delete popup entity** — for editors who
  manage popup content.
- **Administer popup entity** — full control, including the global settings page and the
  collection list. This permission also short‑circuits the individual access checks, so treat
  it as the "popup administrator" grant.

## Verify it worked

1. Go to **`/popup_entity_popup/add`**, create a simple popup with some body text, set a
   visibility condition (or leave it site‑wide), and **publish** it.
2. Visit a front‑end page that matches the popup's visibility rules. The modal should appear
   (after any configured delay) with a working close button.
3. Manage your popups any time from **`/admin/content/popup_entity_popup`**.
