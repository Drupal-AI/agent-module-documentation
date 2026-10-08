# Installation

## Requirements

- **Drupal 10, 11 or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- The **Paragraphs** module (`paragraphs`), which is the only dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraph_anchors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Paragraphs and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraph_anchors -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraph_anchors -y
```

## Permissions

The module adds two permissions, which you can review at **People → Permissions**
(`/admin/people/permissions`):

- **Administer Paragraph Anchors settings** — grants access to the settings form.
  Restricted by default; grant it only to administrators.
- **Access "copy anchor link" buttons** — required for the copy‑link icon button to
  appear at all. To keep the feature working out of the box, this is granted to the
  **Anonymous** and **Authenticated user** roles automatically on install. If you
  only want, say, logged‑in editors to see the button, revoke it from the roles
  that should not (for example Anonymous).

## Verify it worked

Go to **Configuration → Content → Paragraph Anchors**
(`/admin/config/content/paragraph-anchors`) — the settings form should load. After
you enable anchors on a bundle there (see
[Configuration](../configuration/index.md)), edit a paragraph of that type: you
should see a greyed‑out, monospaced **Generated Anchor ID** field with a hint about
using `#your-slug` to link to that section.
