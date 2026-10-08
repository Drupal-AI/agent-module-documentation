Link Class adds a **Link with class** field widget for core Link fields, letting editors attach one or more CSS classes to each link value.

---

Core's Link field stores a URI and link text but gives editors no way to add a CSS class (e.g. to style a link as a button). Link Class provides a replacement field widget, **Link with class** (plugin id `link_class_field_widget`), that subclasses core's `LinkWidget` and adds a class control beneath each link. The widget offers three modes, chosen per form-display: **manual** (editors type free-form classes into a textfield), **select** (editors pick from a curated `key|label` list you define), and **force** (a fixed class string is applied to every link automatically, with no editor input). Modes and their class lists are configured in the widget settings on Structure → Manage form display, and stored on the field's `entity_form_display` component under `field.widget.settings.link_class_field_widget`. The chosen class is written into the link value's `options.attributes.class`, exactly where core's link formatter renders it onto the `<a>` tag, so no extra formatter is needed. There is no global settings form, no permissions, and no Drush commands — everything lives in per-field widget settings. It depends only on core `link`. It is a small, focused tool for giving editors controlled CSS styling of individual links.

---

- Let editors style a Link field value as a button (e.g. `btn btn-primary`).
- Offer a fixed set of link styles editors choose from a dropdown (select mode).
- Force a standard class onto every link in a call-to-action field (force mode).
- Allow power editors to type arbitrary CSS classes on links (manual mode).
- Add a `button` class to hero/CTA link fields site-wide.
- Give footer links a consistent utility class without editor effort.
- Present a "Default button / Primary button" style picker on a link field.
- Apply framework classes (Bootstrap, Tailwind) to editorial links.
- Restrict link styling to an approved allow-list via select mode.
- Add tracking/analytics classes to marketing links.
- Style download links distinctly by forcing a `download-link` class.
- Configure different class options per field via form-display widget settings.
- Add multiple space-separated classes to a single link.
- Provide editors a labelled style list while storing terse class strings.
- Convert a plain link field into a styled button field with no theming change.
- Keep link markup consistent across content types by forcing a class.
- Let a banner link always render as `btn btn-cta` regardless of editor.
- Give icon links a class hook for CSS/JS behaviours.
- Offer brand button variants (primary/secondary/ghost) as a select list.
- Export the per-field widget/class configuration between environments as config.
- Swap an existing Link field's widget to Link with class without data migration.
- Provide a curated style dropdown so non-technical editors can't type bad classes.
- Add a `nav-link` class to menu-style link fields.
- Reuse one class list across several link fields by configuring each widget.
- Style paragraph/CTA component link fields with a chosen class.
