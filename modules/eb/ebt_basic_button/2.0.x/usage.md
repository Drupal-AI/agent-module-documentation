<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Basic Button is one of the Extra Block Types (EBT) family: it installs a reusable `ebt_basic_button` block content type with a link field and a rich per-instance "Block settings" widget (colours, hover colours, alignment, shape, size, stretched, custom classes) so editors can drop styled button blocks into Layout Builder in a few clicks.

---

Installing the module creates a `block_content` bundle `ebt_basic_button` with two fields:
`field_ebt_basic_button_link` (core Link) and `field_ebt_settings` (an `ebt_settings` field type
provided by the required `ebt_core` module). The field widget `ebt_settings_basic_button`
(`EbtSettingsBasicButtonWidget`, extending `ebt_core`'s `EbtSettingsDefaultWidget`) renders a
"Link options" details group with: open-in-new-tab, add `nofollow`, Title Color, Background Color
(defaults to the EBT Core global background colour), a "Custom hover colors" toggle revealing Hover
Title/Background colour fields, alignment (left/center/right), shape (square/round/circle), size
(small/medium/large), stretched, and a custom class name. Colours are validated by ebt_core's
`validateColorElement` and classes by `EbtGenericValidator::validateClassElement`. On render,
`EbtBasicButtonHooks::preprocessBlock()` (a `hook_preprocess_block`) calls the
`ebt_basic_button.generate_custom_css` service (`GenerateCustomCSS`) to emit a scoped inline
`<style>` block (each colour passed through `Html::escape`) targeting `.ebt-basic-button` within a
per-block CSS class, exposed to the twig templates as `button_styles`. Two templates
(`block--block-content--ebt-basic-button.html.twig`, `block--inline-block--ebt-basic-button.html.twig`)
render the button. It depends on `ebt_core`, `paragraphs`, and core `link`; global colour/breakpoint
defaults live in EBT Core's settings (`/admin/config/content/ebt-settings`). No permissions or Drush
of its own — block placement uses core block content / Layout Builder permissions.

---

- Add a styled call-to-action button block through Layout Builder without writing CSS.
- Create reusable button blocks in the *Block library* and place them in regions or layouts.
- Set per-button title and background colours from the block edit form.
- Configure distinct hover title/background colours with the "Custom hover colors" toggle.
- Pick a button shape: square, rounded, or circular.
- Choose a button size: small, medium, or large.
- Stretch a button to full container width.
- Align a button left, center, or right within its block.
- Open the button link in a new browser tab.
- Add `rel="nofollow"` to the button link for SEO control on sponsored/external links.
- Apply custom CSS classes to a single button block for bespoke styling.
- Inherit a site-wide default button background colour from EBT Core settings.
- Build landing pages by combining EBT Basic Button with other EBT block types.
- Keep button styling scoped per block via generated inline CSS (no global stylesheet edits).
- Provide editors a consistent button UI across content types and layouts.
- Use only this block type standalone without installing the rest of the EBT suite.
- Theme the button markup by overriding `block--block-content--ebt-basic-button.html.twig`.
- Add link buttons inside inline blocks created directly in Layout Builder.
- Produce brand-coloured buttons that match a design system via hover-state colours.
- Give non-developers safe, validated colour and class inputs for buttons.
