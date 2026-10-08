<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Deck Diff (entity_reference_deck_diff) — agent index

Feature submodule of **Entity Reference Deck**. Adds a revision-compare action and AJAX modal.
Depends on `entity_reference_deck` and contrib **`diff`**. Core `^11.4 || ^12`. Version 1.0.0-beta5.
No permission or config of its own.

## What it provides
- Action plugin **`diff`** (`src/Plugin/EntityReferenceDeckAction/DiffEntityReferenceDeckAction.php`),
  group per core settings (default weight 10).
- Diff layout plugin **`erdeck_split_fields`**
  (`src/Plugin/diff/Layout/ErdeckSplitFieldsDiffLayout.php`; escapes the revision log with `Xss::filter`).
- Route **`entity_reference_deck_diff.dialog`**
  (`/entity-reference-deck/diff/{entity_type_id}/{entity_id}/{left_revision_id}/{right_revision_id}/{filter}`),
  controller `EntityReferenceDeckDiffDialogController::dialog()` returning an `OpenModalDialogCommand`.
- Custom access check service `access_check.entity_reference_deck_diff.dialog`
  (`EntityReferenceDeckDiffDialogAccess`) — requires view access to the entity and both revisions and
  that both revisions belong to the entity.

## Operate
Enable after `entity_reference_deck` with `diff` installed. The action appears on cards for
revisionable entities; toggle/reorder it on the core settings form.
