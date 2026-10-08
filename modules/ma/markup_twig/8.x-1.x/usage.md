Markup Twig extends the contrib Markup field so that a markup field's configured text is rendered as a Twig template instead of static HTML.

---

The Markup module provides a "markup" field type whose value is set once in the field configuration and shown, unchanged, on the entity form and/or the entity display. Markup Twig adds a matching field widget and field formatter (both labelled "Markup Twig") that run that configured text through Drupal's `inline_template` render element, so the markup can use Twig syntax — variables, loops, conditionals, filters — with a context that includes the current entity, the active theme, site information and the current language. The Twig text lives in the field settings (not in per-node content), and editing it is gated by a dedicated "Administer markup fields" permission, so it is intended for trusted administrators / site builders who author templates as part of the site configuration. Choosing the plain Markup widget/formatter instead renders the same text literally, without Twig evaluation.

---

- Show a computed banner or notice on a content type by rendering Twig in a markup field.
- Print the current entity's title or a field value inside otherwise-static markup (`{{ node.title }}`).
- Build a small entity-aware template (e.g. a call-to-action) without writing a custom module.
- Add conditional markup that only appears for logged-in users (`is_admin`, `logged_in` context).
- Insert the site name or slogan into a markup field via the global context (`site_name`, `site_slogan`).
- Reference the active theme name or path from a markup field (`theme`, `theme_directory`).
- Render a file/image URL pulled from another field on the same entity.
- Combine several of an entity's fields into one formatted display block.
- Use Twig Tweak's `|view` filter inside a markup field to embed another field's rendered output.
- Localize markup by branching on the current language (`language` context variable).
- Provide a per-view-mode variation of a markup field using the formatter's `formatter_field_view_mode` context.
- Add helper text or dynamic instructions on the node edit form via the Markup Twig widget.
- Apply a text format's filters to the Twig output (the result is passed through `check_markup`).
- Keep a single-value informational field on a bundle whose content is derived rather than typed.
- Replace small custom preprocess/template code with an editable markup field template.
- Show front-page-only content using the `is_front` context flag.
- Render a taxonomy term or user field the same way by using the dynamic entity-type context key.
- Prototype display logic quickly during site building, then move it to a theme template later.
- Standardize a repeated marketing block across bundles as a configured Twig markup field.
- Display base path / base URL aware links inside markup (`base_path`, `base_root`).
