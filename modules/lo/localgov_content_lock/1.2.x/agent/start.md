<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Content Lock (localgov_content_lock) — agent index

Thin glue/config module that switches on the **Content Lock** module for LocalGov Drupal. Version
**1.2.0** (dir `1.2.x`). Core `^10.2 || ^11`. License GPL-2.0-or-later.

## What it is
It reimplements nothing. It depends on Content Lock and does three things:
- `hook_install()` writes `types.node = ['*' => '*']` into `content_lock.settings`, enabling pessimistic
  edit-locking for every node bundle (existing and future). Skipped when `$is_syncing`.
- Adds a **local task tab** "Locked" on `/admin/content` (`localgov_content_lock.links.task.yml`).
- Adds an **admin menu link** "Locked content" (`localgov_content_lock.links.menu.yml`).
  Both point at Content Lock's `view.locked_content.page_1`.

## Dependencies
- Module dep: `content_lock:content_lock` (info.yml).
- Composer: `drupal/content_lock: ^3.0` (composer.json). No PHP or library deps.

## What it provides
- **No routes, permissions, services, plugins, hooks, drush commands, or config schema of its own.**
- `.module` is an empty file-doc stub. All lock behaviour, permissions, and the timeout (default
  30 min) live in Content Lock at `/admin/config/content/content_lock`.
- No settings form (`configure` is null).

## Files
- `localgov_content_lock.install` — the one-shot install config write.
- `localgov_content_lock.links.menu.yml` / `.links.task.yml` — admin/content links.
- `tests/src/Functional/ContentLockTest.php` — asserts a node locks on edit and appears at
  `/admin/content/locked-content`.

## Solution docs
- [config/install.md](config/install.md) — install behaviour, the config it writes, links, and how
  to change the timeout / lock-break permissions (all in Content Lock).
