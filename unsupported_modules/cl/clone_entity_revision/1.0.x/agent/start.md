<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clone Entity Revision (clone_entity_revision) — agent index

Adds a **Clone** operation to each node revision on the node **Revisions** tab. Clicking it
opens a confirm form that deep-duplicates *that specific revision* into a **brand-new node** —
recursively cloning referenced **paragraphs** and making independent copies of **file/image**
fields. Installed as **1.0.4**. Core `^10 || ^11`. License GPL-2.0-or-later. Package `Entity Revision`.

## Names — read carefully (two different spellings)

- **Module machine name** (for `drush en`, hooks, services, PHP namespace, all `*.yml` file
  prefixes): **`clone_entity_revision`** — correctly spelled, because the info file is
  `clone_entity_revision.info.yml`.
- **drupal.org project + primary Composer package**: **`drupal/clone_enity_revision`** —
  genuinely misspelled ("enity"), and the module's *directory* on disk is `clone_enity_revision`.
- **`drupal/clone_entity_revision`** is only a **metapackage alias** that requires
  `drupal/clone_enity_revision:^1`.

So: `composer require drupal/clone_enity_revision` (misspelled), then
`drush en clone_entity_revision` (correct). The `project:` key in the info.yml is
`clone_enity_revision`.

## Dependencies

- Core modules (hard, from `.info.yml`): **`node`**, **`content_moderation`**.
  Note: the source code never references content_moderation — the dependency is declared but the
  module contains no moderation-specific logic (see below).
- Optional at runtime (checked via `moduleHandler->moduleExists()`): **`paragraphs`**, **`file`**.
- No third-party Composer/PHP libraries. No `composer.json` ships in the module.

## What it provides (from source)

- **Permission** (`.permissions.yml`): `clone_entity_revision.clone` — *"Node clone revisions"*,
  `restrict access: FALSE`. Single permission gating the whole feature.
- **Route** `clone_entity_revision.revision_clone_confirm` (`.routing.yml`):
  `/node/{node}/revisions/{node_revision}/clone` → `_form: NodeRevisionCloneForm`.
  Access requirement: **`_permission: clone_entity_revision.clone`**.
  `node_revision` is an `entity_revision:node` param.
- **Route subscriber** `RouteSubscriber` (`.services.yml`, tag `event_subscriber`): overrides the
  core `entity.node.version_history` route's `_controller` to this module's `NodeController`.
- **Controller** `NodeController extends \Drupal\node\Controller\NodeController`: overrides
  `revisionOverview()` to inject a **Clone** link into each revision row's operations `#links`
  (only when the current user has the clone permission and the revision is a translation-affected
  revision).
- **Confirm form** `NodeRevisionCloneForm extends ConfirmFormBase`: does the actual cloning in
  `submitForm()` / `handleCloneParagraph()`.
- **Hook**: `clone_entity_revision_help()` (help page text) — the only hook. No install/update
  hooks, no config, **no config schema**, no templates, no libraries, no Drush commands.

## Behaviour notes (accurate to code)

- The clone is a plain `$entity->createDuplicate()` plus recursive handling of two field types.
  It **does not** set any moderation state; whatever `moderation_state` the revision carried is
  duplicated like any other field (any moderation defaulting is core's doing, not this module's).
  Docs elsewhere that say the clone "starts in an appropriate moderation state" overstate this —
  there is no such code.
- **Paragraphs**: `entity_reference_revisions` fields whose `target_type` is `paragraph` are
  recursively duplicated (each nested paragraph is cloned and re-referenced by new
  target_id/target_revision_id).
- **File/image**: for `file`/`image` fields, each referenced `File` is byte-copied on disk
  (`fileSystem->copy($uri, $uri, FileExists::Rename)`), a new `File` entity is created, and item
  meta (`alt`, `title`, `width`, `height`, `description`, `display`) is carried over — so the new
  node has independent file copies.
- `created` and `changed` are reset to the request time. **Author (`uid`) is NOT reset** — the new
  node keeps the source revision's author.
- After save the user sees a message linking to the new node's edit form and is redirected back to
  the source node's version history.

## Solution docs

- **Clone route, controller override, confirm-form / duplication mechanics** →
  [clone-flow.md](clone-flow.md)
