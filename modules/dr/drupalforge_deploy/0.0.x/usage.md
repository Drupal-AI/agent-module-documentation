<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Assemble a Drupal Forge "DrupalPod" launch URL from your site's Git remote, PHP version, and a Backup and Migrate AWS S3 backup, through a guided four-step readiness wizard.

---

Drupal Forge Deployment (`drupalforge_deploy`) is an experimental (0.0.x) module that turns "launch a copy of this site on Drupal Forge" into a few clicks. Its single admin page at `/admin/config/development/drupalforge-deploy` runs four readiness gates — a compatible Backup and Migrate AWS S3 destination, an available (non-expired) backup, a Git repository with a supported GitHub/GitLab remote on a non-detached branch, and finally URL generation. When all gates pass it builds an `https://www.drupalforge.org/drupalpod/new#…` fragment URL containing `DP_REPO_BRANCH` (the normalized repo URL plus `/tree/<branch>`), `DP_IMAGE` (a `drupalforge/deployment:php-<x.y>` tag chosen from the running PHP version), and S3/AWS deployment environment variables sourced from the configured backup destination. The module inspects the local Git checkout with shell-out `git` commands (all dynamic arguments passed through `escapeshellarg`), detects self-hosted GitLab hosts by probing their HTTPS API, and exposes a branch autocomplete endpoint. It requires `backup_migrate_aws_s3` (which pulls in `backup_migrate`), a public GitHub or GitLab remote (private repos are not yet supported), and provides one restricted permission, `administer drupalforge deploy`.

---

- Generate a Drupal Forge launch URL for a copy of an existing Drupal site without hand-building the fragment parameters.
- Detect the current site's Git repository root by walking up from the Drupal root looking for `.git`.
- Identify a supported remote automatically, preferring the upstream-tracking remote, then `origin`, then the first supported remote.
- Support GitHub.com and GitLab.com remotes out of the box, plus self-hosted GitLab hosts verifiable over HTTPS.
- Auto-detect self-hosted GitLab by probing `/api/v4/version`, `/api/v4/metadata`, then `/help` on the remote host.
- Normalize SSH (`git@host:path`), `ssh://` and `https://` remote URLs to a canonical `https://host/path` form.
- List local branches and per-remote remote branches for selection, and resolve the tracked upstream reference.
- Offer a branch autocomplete field on the deploy form backed by a JSON endpoint filtering remote branches by substring.
- Discover database backups from a Backup and Migrate AWS S3 destination (`type: awss3`) via its `listFiles()` method.
- Normalize heterogeneous backup records (arrays, objects, strings) into `id`/`label`/`created`/`size`/`expires` fields.
- Sort discovered backups newest-first and hide expired backups from the selectable list.
- Resolve S3 bucket, region and folder prefix from the destination config to compose the backup's object path.
- Resolve AWS credentials from the destination config, including Key module (`key.repository`) and `key_aws` bundle references.
- Choose a deployment container image tag matching the running PHP version (7.4 through 8.5, with a 7.4 fallback).
- Add site-defined deployment environment variables via a `KEY=VALUE` payload editable on the form and stored in config.
- Show a live "Generated URL" preview and an editable DrupalPod `KEY=VALUE` payload preview that syncs with the selection fields (JS).
- Gate the whole workflow behind the restricted `administer drupalforge deploy` permission.
- Present a step-by-step wizard that opens on the first failing readiness step and blocks the Deploy button until ready.
- Provide contextual `hook_help()` and inline guidance with copy-paste `git remote add` commands for GitHub, GitLab.com and self-hosted GitLab.
- Link out to the Backup and Migrate "Backup now", destinations and saved-backups pages from the readiness steps.
- Persist the chosen deployment environment variables (minus derived `DP_*` keys) to `drupalforge_deploy.settings`.
