# Config Translation Sync — manual setup guide

**Config Translation Sync** (`config_translation_sync`) keeps your *configuration
translations* consistent across environments during deployments. It extends Drupal
core's Configuration Translation module: when you import or deploy configuration,
this module ensures the translated configuration — the translations of things like
your site name, views labels, field labels, and other config strings — stays in sync
rather than drifting or being lost.

The problem it addresses is a familiar multilingual headache. You translate
configuration on one environment, deploy configuration to another, and the
translations quietly go missing or fall out of step because they are not carried
along cleanly by the standard config workflow. Config Translation Sync closes that
gap with a Drush command (`drush crst`) that re-synchronizes translated
configuration on demand. It supports include and exclude patterns for fine-grained
control over which config is synced, can be restricted to specific language codes,
and logs its changes for transparency and debugging.

> **Note on automatic sync (version 1.0.2):** the module also ships an internal
> config-import subscriber intended to run this synchronization automatically after
> every `drush cim`. In the 1.0.2 release that subscriber is not wired into Drupal's
> service container, so it does not actually run on import — treat `drush crst` as the
> way to trigger a sync (for example, as an explicit step in your deployment script).

This is a multilingual and configuration-management tool. It manages *translation
configuration*, not content, and has no access-control role beyond its own
permission. It depends on core's **Configuration Translation** module and requires
Drupal 10, 11, or 12 (this is the 1.0.2 release). The typical home for it is a deployment
script: keep translated configuration consistent between local, staging, and
production, and ensure translations are not lost when configuration changes ship.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Settings page

The module adds a settings page at **Configuration → Development → Config Translation
Sync** (`/admin/config/development/config-translation-sync`), reachable by users with
the *Administer Config Translation Sync* permission. It has two fields:

- **Enabled languages** — the default set of languages a sync targets when you do not
  pass `--langcode`.
- **Excluded configuration names** — one config name or `*`-wildcard pattern per line,
  skipped when you do not pass `--exclude`.

These are only defaults for the sync command; saving the form does not itself run a
sync.

## How to use it

The synchronization is driven by the `drush crst` command (in 1.0.2 the automatic
import hook does not run — see the note above — so add `crst` to your deployment
script where you want a sync to happen):

- Run synchronization manually:

  ```bash
  drush crst
  ```

- Re-synchronize only specific configuration objects:

  ```bash
  drush crst --config-names=system.site,views.view.frontpage
  ```

- Include a set but exclude particular items (patterns supported):

  ```bash
  drush crst --config-names=views.view.* --exclude=views.view.frontpage
  ```

- Restrict synchronization to specific languages:

  ```bash
  drush crst --langcode=ru,en
  ```

Add `drush crst` to your deployment scripts if you want an explicit re-sync step
after configuration is imported. The module logs the changes it makes, which is
helpful when debugging why a particular translation did or did not update.
