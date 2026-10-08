# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Node** (`node`) and **Content Moderation** (`content_moderation`)
  modules. Content Moderation is essential — the whole feature is built around
  moderated draft/published revisions. Enable a moderation workflow on the content
  types you want to use it with.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/hold_my_draft -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hold_my_draft -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hold_my_draft -y
```

## Grant the permissions

Hold My Draft provides **separate permissions** for *starting* a draft‑hold and
for *completing* (releasing) one. Go to **People → Permissions**
(`/admin/people/permissions`) and grant them to the roles that should manage
draft‑holds — you can give some roles only the ability to start a hold and others
the ability to release it.

## Verify it worked

On a node whose content type uses a Content Moderation workflow, open the
**Revisions** tab (`/node/{id}/revisions`) as a user with the permission. The
draft‑hold action should be available. See "How to use it" in the
[overview](../index.md) for the full pause‑fix‑resume flow.
