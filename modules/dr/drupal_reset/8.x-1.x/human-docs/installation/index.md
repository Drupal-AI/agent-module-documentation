# Installation

> ## ⚠️ Development environments only
>
> Install Drupal Reset **only** on local or disposable development sites. It
> exists to wipe a site so you can reinstall from scratch. Never add it to a
> production or staging environment, and never leave it enabled where an
> untrusted account could reach it.

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No module dependencies, no third‑party Composer packages, and no external
  library requirements.
- A full **database and files backup** taken before you ever run the reset.

## Install with Composer

From the project root:

```bash
composer require drupal/drupal_reset -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupal_reset -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupal_reset -y
```

## Lock down the permission

Immediately after enabling, restrict who can use the reset:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the **`drupal reset`** permission — it is flagged as
   restrict‑access/security‑sensitive.
3. Grant it **only** to a single trusted developer role. Do not give it to your
   general administrator role.
4. Click **Save permissions**.

## Verify it worked

As a user with the `drupal reset` permission, confirm the form loads at
**Configuration → Development → Drupal Reset**
(`/admin/config/development/drupal_reset`). **Do not submit it** unless you
genuinely intend to wipe the site — see
[How to use it](../index.md#how-to-use-it) for what each option does.
