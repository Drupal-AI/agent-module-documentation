# File Permissions — manual setup guide

**File Permissions** (`file_permissions`) is a **Drush-only** tool for setting up
correct local filesystem permissions on a Drupal site. It has **no admin UI** —
everything happens on the command line. Its job is to take the pain out of getting
Drupal's files directories right: it creates `sites/default/files` and
`sites/default/private` if they are missing, records them in configuration, writes
the protective `.htaccess` files into them, and — most importantly — sets and
maintains correct ownership and permissions on those directories.

This is the module to reach for when you see the familiar warnings *"The directory
sites/default/files is not writable"* or *"The directory sites/default/private is
not writable"* on the status report, or when you want a repeatable step in a
deployment or CI pipeline that normalizes file permissions instead of fixing them
by hand.

Because it is about permissions, it operates directly on the filesystem
(`chmod`/`chown`) and needs to run as a user with enough privilege — it will ask
for `sudo` access. It has no runtime access-control role; think of it as a
setup/hardening helper. Ensuring the files directories have correct ownership and
the expected `.htaccess` (which blocks direct execution of certain files) is a
small but genuine part of hardening a Drupal file setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and run the `drush fp` command.

There is **no configuration page** — this module provides Drush commands only. The
command and its options are covered in "How to use it" below.

## Where it lives in the admin menu

Nowhere — File Permissions adds no admin pages, menu links, or settings forms. You
interact with it entirely through the `drush fp` command.

## How to use it

Once enabled, run the command from your site root:

```bash
drush fp
```

That auto-detects your web server user and group, creates the public and private
files directories as needed, writes their `.htaccess` files, and fixes ownership
and permissions.

- If auto-detection of the web server user/group fails, provide them explicitly:

  ```bash
  drush fp --user=www-data --group=www-data
  ```

- To preview the changes without applying them:

  ```bash
  drush fp --dry-run
  ```

Because the command adjusts ownership, a root user is generally required, which is
why it may prompt for `sudo`. **Avoid running it with `sudo` unnecessarily**,
though — doing so can create files owned by `root`, which is not what you want for
Drupal's files directories.
