<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Styles Bootstrap is a submodule of Block Styles that registers five ready-made Bootstrap-flavoured block wrapper styles — card, collapse, dropdown, modal and popover — selectable from the Block Styles fieldset on any block.

---

It ships no PHP logic of its own (`block_styles_bootstrap.module` is empty). It provides a
`block_styles_bootstrap.themes.yml` declaring five Styles API styles of `type: block` —
`block__bootstrap__card`, `block__bootstrap__collapse`, `block__bootstrap__dropdown`,
`block__bootstrap__modal` and `block__bootstrap__popover` — each with a Twig template under
`templates/bootstrap_*/`, plus a `block_styles_bootstrap.libraries.yml` with the CSS/JS for the
modal, dropdown and collapse variants. Four of the five (collapse, dropdown, modal, popover) set
`extras.label: 1`, which makes the parent module enable the **"Text for button label"** field on the
block form so you can label the trigger button; the card style has no button. Because it just adds
styles to the Styles API registry, you use it exactly like any Block Styles style: pick one in a
block's *Block Styles Template* fieldset, and the choice is saved in a `block_styles.blocks.<block_id>`
config entity (`theme` = the chosen `block__bootstrap__*` id). It depends on `block_styles` (and,
transitively, `styles_api`). Note the templates target Bootstrap markup/classes; a Bootstrap-based
theme (or Bootstrap's CSS/JS) is expected for the components to look and behave correctly.

---

- Wrap a block's content in a Bootstrap **card**.
- Turn a block into a Bootstrap **collapse**/accordion panel with a labelled toggle.
- Present a block as a Bootstrap **dropdown** menu opened by a button.
- Show a block inside a Bootstrap **modal** launched from a button.
- Attach a Bootstrap **popover** to a block.
- Give the modal/collapse/dropdown/popover trigger a custom button label via the block form.
- Apply a consistent card layout to menu, search or custom blocks.
- Collapse a long informational block to save vertical space.
- Move a promotional block into a modal to declutter the page.
- Build an FAQ-style set of collapsible blocks.
- Provide a dropdown of links/content from a single block.
- Reuse the same Bootstrap style across many blocks for visual consistency.
- Add the module's bundled CSS/JS for modal, dropdown and collapse behaviour automatically.
- Restyle a block without writing a theme hook or template yourself.
- Combine a Bootstrap style with extra wrapper CSS classes from Block Styles.
- Prototype Bootstrap component wrappers quickly on existing blocks.
- Export the chosen Bootstrap style per block as config (`block_styles.blocks.*`).
- Offer editors a menu of Bootstrap wrappers in the block UI.
- Use the card style as a neutral panelled container for any block.
- Trigger a newsletter or contact block in a modal.
