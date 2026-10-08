# Installation

## Requirements

Username Enumeration Prevention is dependency‑light. It needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **User** module (`user`) — this is the only dependency, and it is always
  present in a Drupal site.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/username_enumeration_prevention -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/username_enumeration_prevention -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en username_enumeration_prevention -y
```

That's all. Both protections — the generic forgot‑password response and the
403→404 conversion on user routes — are active immediately. There is **no
configuration**.

## Submodules

This module ships **no submodules**.

## After enabling — check one permission

Because the core **access user profiles** permission lets a role view user pages
directly (re‑exposing usernames), verify that the **anonymous** role does not have
it, at *People → Permissions*. The module also surfaces a warning on the **status
report** (*Reports → Status report*) when anonymous users hold that permission.

## Verify it worked

Visit a user page for an id that exists but you can't access (while logged out, for
example) — it should return a **404**, not a 403. And on the forgot‑password form
(`/user/password`), submitting an unknown name or email should give the same
neutral response as a known one.
