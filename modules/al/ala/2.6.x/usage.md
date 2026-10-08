Adds a richer widget and formatter for core Link fields, letting editors pick a CSS class (from a preset list), a link target, an icon class, text/background colours, extra HTML attributes, and per-role visibility.

---

Advanced Link Attributes extends core's `link` field with a field widget (`ala_field_widget`, extends `LinkWidget`) and a field formatter (`ala`, extends `LinkFormatter`). On *Manage form display* the widget adds an "Advanced settings" details group whose sub-elements are toggled by widget settings: a target `<select>` (`_self/_blank/_parent/_top`), an icon-class textfield, text/background colour textfields (with a small `ala/color` JS helper), a role-visibility multi-select, a class `<select>`, and textfields for any "extra attributes". The class list is either a **Global List** (from the module's `ala.settings.ala_default_classes`, edited at `/admin/config/ala`, route `ala.admin_settings`, permission `administer site configuration`) or a **Custom List** entered per widget, in `key|label` lines. Extra attribute names come from the global `ala.settings.ala_extra_attributes` (comma-separated). All of these are stored in the link item's `options` array. The formatter then renders them: the chosen class is applied to the link element or its parent (via `ala_preprocess_field`), colours become an inline `style`, the icon is emitted (as an `<i>` tag inside the link, a class, or a data attribute), the link title is token-replaced, and role visibility hides the link for users not in the selected roles. The formatter also inherits core Link formatter settings (trim length, rel=nofollow, open-in-new-window, url-only/plain). The module provides config schema for both widget and formatter settings; no permissions of its own, no Drush, no plugin types.

---

- Let editors choose a Bootstrap-style button class (e.g. `btn btn-primary`) for a link from a preset list.
- Maintain a site-wide global list of allowed link classes at `/admin/config/ala`.
- Define a per-field custom list of allowed classes when a field needs its own set.
- Apply the chosen class to the link element itself or to its parent wrapper.
- Let editors set the link target (`_blank` to open in a new tab, `_self`, `_parent`, `_top`).
- Add an icon (Font Awesome-style class) to a link, positioned left or right of the text.
- Render the icon as an inline `<i>` tag, as an extra class, or as a data attribute.
- Give editors text-colour and background-colour pickers for individual links/buttons.
- Show or hide a link based on the current user's roles (per-link role visibility).
- Expose arbitrary extra HTML attributes (e.g. `title`, `data-*`) as editable fields on the link.
- Token-replace the link title using entity tokens (auto-escaped by the link generator).
- Trim long link text to a configured length in the display formatter.
- Add `rel="nofollow"` or force new-window behaviour via inherited core Link formatter settings.
- Build a set of call-to-action buttons with consistent classes across content.
- Restrict promotional links to authenticated users or a specific role.
- Style menu-like link lists without adding custom templates.
- Keep link styling choices in content while constraining them to an approved class list.
- Provide editors a target selector without exposing raw HTML.
- Reuse the same class list across many link fields via the global list.
- Attach analytics/data attributes to specific outbound links.
- Standardise button markup for a design system using preset class keys and labels.
