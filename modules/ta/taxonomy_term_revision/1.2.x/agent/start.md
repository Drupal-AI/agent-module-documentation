<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Term Revision (taxonomy_term_revision) — agent index

Gives taxonomy terms the revision UI that nodes have: a **Revisions** tab listing every saved
version, plus view / revert / delete operations, an editable revision-log-message field, and it
wires the `taxonomy_term` entity so Content Moderation workflows can target terms. Pure code — no
settings form, no config object/schema, no Drush. Requires core `taxonomy` (and `system`).

- **configure route:** none (nothing to configure).
- Defines **4 permissions**; no Drush commands; no plugin types; no config schema.

## What you'd do → doc

- **Operate the revision UI (list / view / revert / delete a term revision)** → [api/revision-ui.md](api/revision-ui.md)
- **Grant who may list / view / revert / delete term revisions** → [permissions/permissions.md](permissions/permissions.md)
- **Understand the behavior it forces (new revision on every term save, log-message field, moderation handler)** → [hooks/hooks.md](hooks/hooks.md)

## Key facts (real machine names)

- Module: `taxonomy_term_revision`; package `revision`; `core_version_requirement: ^8.8 || ^9 || ^10 || ^11`.
- Routes: `taxonomy_term_revision.all`, `taxonomy_term_revision.view`, `taxonomy_term_revision.revert`, `taxonomy_term_revision.delete`.
- Local task tab: `entity.taxonomy_term.revisions` (base route `entity.taxonomy_term.canonical`).
- Controller: `Drupal\taxonomy_term_revision\Controller\TermRevisionController` (`getRevisions`, `revisionShow`, `revisionPageTitle`).
- Forms: `Drupal\taxonomy_term_revision\Form\TermRevisionRevertForm`, `…\Form\TermRevisionDeleteForm` (both `ConfirmFormBase`).
- Permissions: `view term revision list`, `view term revision data`, `revert term revision`, `delete term revision`.
- Hooks (in `taxonomy_term_revision.module`): `hook_entity_base_field_info_alter`, `hook_entity_presave`, `hook_entity_type_alter`, `hook_help`.
- Logger channel: `taxonomy_term_revision` (revert/delete write an info entry). Read table: `taxonomy_term_revision`.
