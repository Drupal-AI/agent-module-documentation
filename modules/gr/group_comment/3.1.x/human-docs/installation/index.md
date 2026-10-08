# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Comment** module (`comment`).
- The **Group** module (`group`) — see the module's release notes for the
  supported Group version.
- A **Drupal core patch** from issue [#2879087], matched to your core version —
  the module cannot scope comments without it. This release is an **alpha** and is
  not covered by Drupal's security advisory policy; test it before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/group_comment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/group_comment -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Apply the required core patch

Group Comment depends on a core patch from issue [#2879087]. Apply the patch that
matches your Drupal version before enabling the module — the module's project page
lists the exact comment number and patch file per core version. The
[cweagans/composer-patches](https://www.drupal.org/docs/develop/using-composer/manage-dependencies#patches)
workflow is the usual way to apply core patches reproducibly.

## Enable the module

```bash
drush en group_comment -y
```

Drupal enables the Comment and Group dependencies automatically if they aren't
already on.

## Verify it worked

Make a group (or grouped entity) commentable, then post a comment as a member.
Confirm the comment becomes associated with the group and that a non‑member cannot
read it — and, importantly, check that the restriction holds in Views, JSON:API,
and REST, not only on the rendered page.
