# Config Revision — manual setup guide

**Config Revision** (`config_revision`) brings revisioning to Drupal's
*configuration* entities. Content entities (nodes, media, and so on) have kept a
change history for years, but configuration entities — views, image styles, field
definitions, workflows — do not. When a config edit breaks something, there is no
built-in way to see what changed or roll it back short of digging through
config-sync tooling. Config Revision fills that gap by saving a new revision every
time a config entity is saved, so you can review the history and revert a bad
change.

Under the hood it adds a lightweight, bundleable, non-translatable revision entity.
Its admin settings page lets you choose *which* config entity types should become
revisionable — so you can keep the feature focused on the config that matters to
you rather than tracking everything. It sensibly ignores changes made during a
configuration import, so deploying config through `drush cim` does not flood the
history with noise.

This is an administrative and governance tool, and the history it keeps is itself
sensitive: configuration can include access rules, permissions, and field
definitions, so the revision log is effectively a record of how the site's
behaviour changed over time. Keep the feature admin-gated, and treat reverting a
config revision with the same care as any live config change — a revert alters the
running site immediately. Note also that for the revision UI to work properly the
module relies on a core patch (drupal.org issue [#2350939]), and this release is an
early beta (1.0.0-beta1), so test on a non-production copy first. It depends only on
core's System module (plus Webform where that integration applies).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no dedicated field-by-field settings page documented here — the module's
admin settings simply let you pick which config entity types become revisionable.
See "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) and apply the core
   patch the module notes it needs for the revision UI.
2. Visit the module's admin settings page and mark the config entity types you want
   to make revisionable. From then on, every save of one of those config entities
   creates a new revision.
3. When you need to investigate or undo a change, open the revision history for that
   config entity, compare revisions, and revert to an earlier one if required.
   Because a revert changes live site behaviour, review it as carefully as you would
   any configuration change, and restrict who can perform it to trusted
   administrators.
