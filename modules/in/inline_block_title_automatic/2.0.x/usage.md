<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Inline Block Title Automatic removes the confusing "block placement label" (title) and "Display title" controls from block_content blocks placed in Layout Builder, so content authors never have to decide on a placement title.

---

When you add or configure a `block_content` block (a reusable library block or an inline block) inside Layout Builder, core shows a required **placement label** and a **Display title** checkbox that duplicate the block's own "Block description"/`info` field and confuse editors. This module hooks `layout_builder_add_block` and `layout_builder_update_block` (via `hook_form_FORM_ID_alter()` bridging to `\Drupal\inline_block_title_automatic\FormAlter`) and, for reusable `block_content` blocks (`$form['settings']['provider']['#value'] === 'block_content'`) and inline blocks (`$form['settings']['block_form']['#block'] instanceof BlockContent`), converts both `$form['settings']['label']` and `$form['settings']['label_display']` to hidden `#type => 'value'` elements. The label defaults to `'Inline block'` when empty, and `label_display` is forced to `FALSE` (title not shown). The result: authors can't set or display a placement title, the block's description stays purely administrative, and any user-facing heading must come from a real field. There is no settings form, config, permission, Drush command, or plugin — enabling the module (with Layout Builder) is the whole setup.

---

- Stop content authors from being asked for a "title" every time they place an inline block.
- Hide the redundant "Display title" checkbox on block_content blocks in Layout Builder.
- Keep the block "description"/info field purely administrative, not user-facing.
- Prevent accidental display of an internal block label on the front end.
- Simplify the Add block / Configure block form for editors using Layout Builder.
- Enforce that visible headings come from real fields, not the block placement label.
- Default every inline block's placement label to "Inline block" automatically.
- Remove a confusing decision from the inline-block authoring flow.
- Apply consistent title-less behavior to both reusable and inline block_content blocks.
- Clean up Layout Builder UX on a content-authoring-heavy site.
- Avoid duplicate/mismatched titles between the block description and the displayed title.
- Standardize inline block placement across a team without training on the title field.
- Reduce support questions about "what is the placement label for?".
- Pair with a design system where block headings are dedicated fields.
- Keep Layout Builder sections tidy by suppressing placement titles.
- Ensure imported/pattern blocks don't surface an internal label.
- Streamline landing-page building with Layout Builder inline blocks.
- Prevent editors from toggling title display on individually placed blocks.
- Make inline block placement a one-step action (choose block, no title prompt).
- Roll the behavior out globally just by enabling the module (no per-block config).
