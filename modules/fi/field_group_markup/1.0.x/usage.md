Field Group Markup adds a "Markup" formatter to the Field Group module so you can drop arbitrary processed HTML (with token support) into an entity's form or view display.

---

The module ships a single Field Group formatter plugin (`markup`) that becomes selectable when you add a field group on any entity's *Manage form display* or *Manage display* tab. Instead of grouping fields visually, the group renders a block of rich text you author in a `text_format` widget, so the output is filtered through a Drupal text format and can contain any HTML that format allows. The text is run through the token service (`\Drupal::token()->replace()`), so tokens like `[node:title]` or `[current-user:name]` resolve against the rendered entity. It reuses the standard Field Group chrome — element ID, CSS classes (default `form-wrapper`), and the "display element also when empty" toggle — and wraps everything in a `field_group_html_element` div. It works in both `form` and `view` contexts. There is no admin settings page and no permissions; all configuration lives inside the field group itself and is stored in the display config entity. Because output is processed text, it is a lightweight way to inject instructions, headings, legal copy, or layout scaffolding without writing a template or a custom block.

---

- Add explanatory help text or instructions above a set of fields on a node edit form.
- Insert a section heading and description between field groups on a complex form.
- Show contextual guidance (e.g. formatting rules) inside a form only where editors need it.
- Render static legal or disclaimer copy on a content view display.
- Inject a token-populated greeting such as "Editing [node:title]" into a form.
- Display computed context like `[current-user:name]` or `[node:changed]` as markup.
- Add a horizontal rule or spacer block between form regions.
- Provide a styled callout box by pairing custom HTML with a permissive text format.
- Add microcopy next to a tricky field (e.g. an API key field) explaining where to get the value.
- Scaffold layout wrappers with custom CSS classes for theming a form.
- Embed a link to documentation or a related admin page inside an edit form.
- Add a "review before publishing" reminder near the moderation/status fields.
- Show branding or a logo image (via HTML) at the top of a view display.
- Group and label read-only informational content on a view mode.
- Insert an accessibility note or ARIA-friendly heading structure into a display.
- Provide inline terms-and-conditions text on a registration or profile form.
- Add token-based summaries (author, dates) to a teaser or full view display.
- Create empty structural placeholders that always render via the "show when empty" setting.
- Replace a trivial custom preprocess/template tweak with configurable markup.
- Localize instructional copy by choosing a translatable text value per language.
