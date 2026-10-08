# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer**.
- Core **CKEditor 5** (`ckeditor5`) and core **Image** (`image`).
- The **`masterminds/html5`** library (`^2.1`) for HTML parsing — Composer
  installs it automatically with the command below.
- The active **3.x** line supports **CKEditor 5 only**. (Older 7.x‑1.x / 8.x‑2.x
  branches were for CKEditor 4 and are no longer the recommended path.)

> **Heads‑up:** the current release is a **beta** (3.0.0‑beta5). Test before
> relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_mentions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies,
including `masterminds/html5`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_mentions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_mentions -y
```

## Submodules

Enable these individually only if you need them:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Mentions Entity** | `ckeditor_mentions_entity` | Lets editors mention entities other than users (for example taxonomy terms), and can create mentioned entities where that fits your workflow. |
| **Mentions Realname** | `ckeditor_mentions_realname` | Shows real display names in the suggestions instead of raw usernames (integrates with the Realname module). |

For example:

```bash
drush en ckeditor_mentions_realname -y
```

## Enable mentions on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format that uses CKEditor 5.
2. In the CKEditor 5 toolbar configuration, enable the mentions feature for that
   format.
3. Save the format.

## Grant the mention permission

The autocomplete callback is protected by a dedicated permission. At **People →
Permissions** (`/admin/people/permissions`), grant **Use inline mentions** to the
roles that should be able to look up and insert mentions — content authors,
commenters, and the like. Because the lookup endpoint can be used to probe whether
users exist, **do not grant it to the anonymous role**.

## Verify it worked

As a user with the permission, edit a CKEditor 5 field on a mention‑enabled
format, type `@`, and confirm the autocomplete list appears and inserting a match
produces a link.
