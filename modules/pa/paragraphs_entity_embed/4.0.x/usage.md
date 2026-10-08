<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Entity Embed lets editors embed Paragraph entities inline in any CKEditor 5 rich-text field via a "Paragraphs" toolbar button, storing each embed as a reusable `embedded_paragraphs` entity referenced by a `<drupal-paragraph>` tag.

---

The module builds on Embed, Entity Embed, and Paragraphs to add paragraph embedding to CKEditor 5. It ships an `embedded_paragraphs` content entity (revisionable; base fields `label` and a `paragraph` entity_reference_revisions to a Paragraph) that wraps the paragraph an editor creates in the embed dialog, plus a shipped `embed.button` config entity `paragraphs` (embed type `paragraphs_entity_embed`). Enabling embedding on a text format is two steps in `admin/config/content/formats`: turn on the **"Display embedded paragraphs"** filter (`paragraphs_entity_embed`, a reversible transform filter) and add the **Paragraphs** button to the CKEditor 5 toolbar (CKEditor 5 plugin `paragraphs_entity_embed_paragraphsEmbed` / `DrupalParagraph`). In the editor the button opens an iframe dialog (routes `paragraphs_entity_embed.dialog` / `..._edit.dialog`) where the editor picks a paragraph type and fills the inline Paragraphs form (widget `entity_reference_embed_paragraphs`); on save a `<drupal-paragraph>` element carrying data attributes (`data-embed-button`, `data-paragraph-id`, `data-paragraph-revision-id`, `data-entity-label`, `data-align`) is inserted into the markup. On render the filter swaps that tag for the embedded paragraph, displayed through the `paragraph.embed` view mode via the `entity_reference_revisions` Entity Embed Display plugin. Five permissions gate the embed entity (view/add/edit/delete/administer paragraphs entity embed); the embed type offers settings to restrict allowed paragraph types and the add mode (dropdown/button/select). There is no single global settings page — configuration is per text format plus the embed button.

---

- Embed a call-to-action paragraph inside the body text of an article.
- Insert a reusable "card" or "stat" paragraph mid-article via the CKEditor Paragraphs button.
- Let editors drop a media/image paragraph into rich text without a separate field.
- Embed an accordion or tabs paragraph within WYSIWYG content.
- Reuse a single embedded paragraph across multiple rich-text fields.
- Enable paragraph embedding only on selected text formats (e.g. Full HTML).
- Restrict which paragraph bundles can be embedded via the embed type's type filter.
- Choose the paragraph add mode (dropdown, button, or select) in the embed dialog.
- Align an embedded paragraph left/right/center via the `data-align` attribute.
- Edit an already-embedded paragraph in place through the edit dialog.
- Gate who can add/edit/delete embedded paragraphs with the module's permissions.
- Render embedded paragraphs through the dedicated `paragraph.embed` view mode.
- Combine with Views Entity Embed to embed both views and paragraphs in the editor.
- Store embeds as `embedded_paragraphs` entities so they are revisionable and queryable.
- Provide marketing teams a way to insert branded components into body copy.
- Keep structured paragraph components while still authoring in free-form rich text.
- Insert a quote or pull-quote paragraph inside an article body.
- Add a webform or view paragraph into a page's rich text region.
- Migrate inline HTML snippets to structured, reusable paragraph embeds.
- Let a text format expose the Paragraphs button only to roles with the add permission.
- Display the same embedded paragraph consistently wherever the `<drupal-paragraph>` tag appears.
- Build long-form content mixing prose and rich paragraph components in one field.
- Control the embedded paragraph's rendered markup by configuring the embed view mode.
- Use the `entity_reference` Entity Embed Display to reuse an entity-reference-revisions formatter.
