<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Styles Bootstrap — agent index

Submodule of **Block Styles**. Registers five Bootstrap block wrapper styles (Styles API
`type: block`) usable from the *Block Styles Template* fieldset on any block. No PHP, no config,
no permissions (`configure: null`) — it is pure `*.themes.yml` + templates + a CSS/JS library.

- **The five styles, their template files, which set a button label, and the JS/CSS libraries** →
  [theming/bootstrap-styles.md](theming/bootstrap-styles.md)

Applied exactly like any Block Styles style: pick it in the block form; it is stored as the `theme`
of a `block_styles.blocks.<block_id>` config entity. See the parent module's
[configure/block-styles.md](../../../../2.0.x/agent/configure/block-styles.md).

The five style ids:
`block__bootstrap__card`, `block__bootstrap__collapse`, `block__bootstrap__dropdown`,
`block__bootstrap__modal`, `block__bootstrap__popover`. All but `card` set `extras.label: 1`
(enabling the button-label field). A Bootstrap theme / Bootstrap CSS+JS is expected.
