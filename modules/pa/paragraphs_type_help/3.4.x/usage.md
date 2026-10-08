<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Type Help provides a fieldable "Paragraphs Type Help" content entity whose rich-text/image content is shown to editors (and optionally site visitors) as an extra field on a Paragraph type's form and view displays, keyed by paragraph bundle plus a specific form/view mode.

---

The module defines a translatable, revisionable `paragraphs_type_help` content entity managed at `/admin/content/paragraphs-type-help`. Each help item references a target **Paragraph Type** (`host_bundle`), an optional **Active Paragraph Form mode** (`host_form_mode`, defaults to `default`) and **View mode** (`host_view_mode`), a **weight**, a published flag, and two Field-UI fields — `help_text` (formatted long text) and `help_image` (image). Via `hook_entity_extra_field_info()` the module exposes an extra field `paragraphs_type_help__<help_view_mode>` on every Paragraph bundle's form and view displays; the "Rendered as Default" form extra field is enabled by default, view extra fields are opt-in. When a paragraph subform is built (`hook_field_widget_single_element_*_paragraphs_form_alter` for the stable, classic, and previewer widgets) or a paragraph is viewed (`hook_paragraph_view`), the module loads all published help entities matching that bundle and mode (`ParagraphsTypeHelp::loadPublishedByHostDisplay`, with fallback to the `default` mode) and renders them, ordered by weight. Templates use `paragraphs-type-help.html.twig` with a cascade of `hook_theme_suggestions` (per view mode, per bundle, per bundle+form/view mode, per entity id). Two permissions gate it: `administer paragraphs_type_help entity` (entity-type admin / field UI) and `manage paragraphs_type_help entity` (create/edit/delete help), both `restrict access: true`. An optional Views (`paragraphs_type_help_admin`) provides the admin listing. Requires the Paragraphs module plus core image/options/text.

---

- Show contextual editor guidance inside a Paragraph's edit form explaining what each field is for.
- Attach a screenshot/annotated image to a Paragraph type showing how the inputs map to the rendered output.
- Provide different help for the same Paragraph type across different form modes (e.g. a simplified vs. full editing form).
- Display help to end users on a Paragraph's rendered view mode (opt-in per view display).
- Give shorter help text on a "preview" view mode and fuller help on the default view mode.
- Centrally manage all Paragraph help content from one admin list at `/admin/content/paragraphs-type-help`.
- Order multiple help snippets for one Paragraph type using the weight field.
- Translate help text and images per language (entity is translatable).
- Keep a revision history of help content and roll back changes.
- Publish/unpublish a help item to toggle its visibility without deleting it.
- Auto-generate a default admin label from the Paragraph type when none is entered.
- Fall back to the `default` form/view mode help when a specific mode has no dedicated help.
- Wrap the help extra field in a collapsible "Need Help?" fieldset using Field Group.
- Restyle the help block on the edit form via the shipped `host_edit_form` CSS library.
- Add editor onboarding notes for newly introduced Paragraph bundles.
- Document expected image dimensions or content rules for a media/hero Paragraph.
- Provide WYSIWYG-formatted help (links, lists, emphasis) using a rich text format.
- Give per-bundle help that only appears when help content actually exists (empty-safe rendering).
- Customize the help entity's own view display fields at `/admin/structure/paragraphs-type-help/display`.
- Override the help markup per Paragraph bundle using the template suggestion `paragraphs_type_help__<bundle>`.
- Restrict who can create/manage help versus who can administer the entity type via the two permissions.
