Link attributes provides a field widget that lets editors set HTML attributes (target, rel, class, title, id, ARIA label, accesskey, and custom ones) on individual link-field values.

---

Core's Link field stores only a URI and link text, with no way to add attributes such as `target="_blank"`, `rel="nofollow"`, a CSS class, or an ARIA label. Link attributes adds a replacement widget, **Link (with attributes)**, that exposes a configurable set of attribute inputs beneath each link. Which attributes appear is controlled per form-display, so a call-to-action field can offer `class` and `target` while a footer field offers only `rel`. Available attributes are defined as lightweight **YAML plugins** (`*.link_attributes.yml`) discovered by a plugin manager, so modules can add new attributes without PHP, and `hook_link_attributes_plugin_alter()` lets you tweak or default them. Built-in attributes include id, name, target (as a select of `_self`/`_blank`), rel, class, accesskey, aria-label and title. The widget also lets you set placeholders and control whether the attributes panel starts open. Two submodules extend the concept: `link_attributes_menu_link_content` brings the same attributes to content menu links, and `linkit_attributes` combines attributes with the Linkit autocomplete widget. Attributes are stored in the link field's `options` and rendered automatically. It is a small, near-universal enhancement for editorial link control, accessibility, and SEO.

---

- Add `target="_blank"` to open a link in a new tab.
- Add `rel="nofollow"` to sponsored or user-submitted links for SEO.
- Add `rel="noopener noreferrer"` for security on external links.
- Attach a CSS class (e.g. `button button--primary`) to a link field.
- Set an `aria-label` on a link for screen-reader accessibility.
- Give a link a `title` tooltip attribute.
- Add an `id` anchor to a specific link.
- Choose which attributes editors can edit per form-display.
- Offer only `class` and `target` on a call-to-action field.
- Restrict a footer link field to just the `rel` attribute.
- Define a brand-new custom attribute via a YAML plugin, no PHP needed.
- Default the `target` attribute to `_blank` via a plugin alter hook.
- Add attributes to menu links with the menu-link-content submodule.
- Combine Linkit autocomplete with attribute settings (linkit submodule).
- Build styled button links inside body/CTA components.
- Mark download links with a data/class attribute for JS behaviour.
- Add `accesskey` shortcuts to primary navigation links.
- Set placeholder text for the URL and link-text inputs.
- Control whether the attributes panel is expanded by default.
- Add tracking classes to links for analytics.
- Provide consistent external-link styling site-wide.
- Let editors flag links to open in a new window without editing markup.
- Add ARIA labels to icon-only links for WCAG compliance.
- Export the enabled-attributes configuration between environments.
