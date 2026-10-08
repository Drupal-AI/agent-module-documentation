<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Block adds a config-only "EBT Block" block content type that embeds any Drupal block (View, content block, or programmatic block) via Block Field and wraps it with the shared Extra Block Types design settings.

---

EBT Block is one module in the Extra Block Types (EBT) family. Enabling it installs a `block_content` bundle named `ebt_block` with three fields: a rich-text **Body**, a **Block** field (`field_ebt_block_block`, provided by the Block Field module) that lets an editor pick and configure any available block plugin to embed, and a **Block settings** field (`field_ebt_settings`, an `ebt_settings` field type contributed by the base `ebt_core` module) exposing EBT's design options — margins, paddings, borders, border colour/style/radius, background colour/image/video, edge-to-edge and container width. The module ships only YAML configuration (the block type, field definitions, and form/view displays) and two Twig templates; it contains no PHP `src/` code. The inline `<style>` output and all field/widget/formatter behaviour for the settings field come from `ebt_core`. Blocks of this type are created at Structure » Block layout » Add content block » EBT Block and are typically placed with Layout Builder; the embedded block continues to enforce its own access.

---

- Embed an existing View inside a styled EBT block placed via Layout Builder.
- Wrap a reusable custom content block with EBT margin/padding/border styling.
- Place a programmatically defined block plugin without writing block-placement code.
- Add a background colour or background image around any embedded block.
- Give an embedded block an edge-to-edge (full-viewport-width) treatment.
- Constrain an embedded block to a preset container max-width.
- Compose Body rich text together with an embedded block in one placeable unit.
- Reuse a single EBT Block content block in multiple regions or layouts.
- Apply EBT Core's site-wide default colours and breakpoints to an embedded block.
- Add rounded corners / custom border colour and style to a block region.
- Build a landing-page section that combines editorial copy and a dynamic View listing.
- Select the embedded block plugin from grouped categories (Views, Content, Menus, Forms, etc.).
- Add the block to the Layout Builder "Add block" inline flow as an inline block.
- Standardise block styling across a site using the EBT settings tab instead of custom CSS.
- Keep the embedded block's own permissions and cacheability intact while restyling it.
- Install just this EBT block type without pulling in the rest of the EBT family.
- Provide content editors a no-code way to embed and style blocks.
- Use with Layout Builder Modal for a smoother block-adding UI.
- Override the two shipped Twig templates in a theme to customise EBT block markup.
- Translate the Body/Block fields where the block type is configured translatable.
