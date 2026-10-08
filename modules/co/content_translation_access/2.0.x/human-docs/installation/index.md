# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- Core **Content Translation** (`content_translation`) enabled — this is a hard
  dependency. Content Translation in turn relies on core's Language module and a
  multilingual site setup.
- No third‑party Composer packages or external libraries.
- Under the hood the module depends on core issue #2918354 for hook support; on a
  current Drupal 10.5/11 site this is already available.

## Install with Composer

From the project root:

```bash
composer require drupal/content_translation_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_translation_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Make sure core Content Translation is on, then enable this module:

```bash
drush en content_translation content_translation_access -y
```

## Submodules

The project ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Content Translation Access (User)** | `content_translation_access_user` | User‑level handling for translation access, on top of the base module's per‑role permissions. Enable it only if you need that behaviour. |

Enable it when you need it:

```bash
drush en content_translation_access_user -y
```

## Configure the permissions

This module has no settings form — its whole job is expressed through
permissions. After enabling, go to **People → Permissions**
(`/admin/people/permissions`) and assign the new translation permissions to the
appropriate roles, scoped by operation, content type, and language. See
[the overview](../index.md) for how the permission model behaves.

## Verify it worked

Grant a test role permission to translate one content type into one language
only. Log in as a user in that role and confirm they can create/edit that
translation but are blocked from translating a different type or into a different
language. Because the access handler defaults to neutral, a role you have granted
nothing to should have no translation access at all — a quick way to confirm the
module is enforcing rather than leaking access.
