<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Behaviour notes — README claims vs. the shipped code (1.0.3)

The `README.md` describes a few features that are **not actually present** in the source of this
version. When advising on this module, ground guidance in the code, not the README.

- **"Contextual link on inline blocks to convert them to reusable" / "Make reusable" contextual
  menu.** No such route, link, or contextual-link definition exists. There is no
  `*.links.contextual.yml`, and `routing.yml` defines only the settings route. The **only** way to
  make a block reusable is to choose "Create reusable block" *while adding a new custom block*
  (`layout_builder_reusable_blocks_configure_block_submit_handler`, see
  [../api/promote-to-reusable.md](../api/promote-to-reusable.md)). An already-placed inline block
  cannot be promoted through a contextual action.

- **"Confirm the action in the dialog."** There is no confirm form/dialog for promotion; it happens
  silently on the add-block save.

- **In-place editing of reusable blocks is OFF by default.** `allow_editing_reusable_blocks` defaults
  to `FALSE`. Until an admin turns it on, `LayoutBuilderReusableContentBlock` adds nothing over core
  and reusable blocks are **not** editable from Layout Builder (the README's "Edit Reusable Blocks"
  feature is opt-in, not default).

- **Warning message only appears when editing is enabled.** The warning render is nested inside the
  `if ($allow_editing)` branch, so with editing off you never see a warning (there is nothing to warn
  about, since no edit form is shown).

- **No config is shipped.** README mentions export/import of `layout_builder_reusable_blocks.settings`,
  but there is no `config/install` default and no `config/schema`. The object exists only after the
  settings form is first saved; defaults are code `?? …` fallbacks.

- **`make_all_blocks_reusable` affects only newly *added* custom inline blocks** via the add-block
  form alter — it does not retroactively convert existing inline blocks.
