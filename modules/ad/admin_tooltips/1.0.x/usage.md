<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin Tooltips lets site builders attach a tooltip text to a field from the Manage form display settings, and shows that text as a hover tooltip next to the field widget on entity add/edit forms to guide editors.

---

Admin Tooltips adds a "Tooltip settings" text box to every field's widget settings on the Manage form display page (e.g. `admin/structure/types/manage/article/form-display`). Whatever a site builder enters there is stored as a widget third-party setting (`admin_tooltips.admin_tooltip.admin_tooltip_text`, schema in `config/schema/admin_tooltips.schema.yml`). On the entity add/edit form the module then renders that text as a small info-icon tooltip beside the widget: `admin_tooltips_field_widget_single_element_form_alter()` reads the third-party setting and stashes it on the element as `#admin_tooltip` (choosing the right sub-element for `datetime`/`datelist`, entity-reference `target_id`, and `link`/`linkit` `uri` widgets), attaches the `admin_tooltips/tooltips` library, and `admin_tooltips_preprocess_form_element()` copies it into a template variable. A `hook_theme_suggestions` alter adds the `form_element__admin_tooltips` (and container) suggestion so the bundled `templates/form-element--admin-tooltips.html.twig` renders an SVG info icon and a pop-out box containing the tooltip text; a longer text (>120 chars) gets the `admin-tooltip--fixed-size` scrollable variant. The widget settings summary is also augmented (`hook_field_widget_settings_summary_alter`) to show a truncated preview of the configured tooltip. The module is pure form/theme integration — no routes, controllers, permissions, services or Drush commands — and the template and `css/admin_tooltips.css` can both be overridden from the site theme. Configuring a tooltip requires the standard permission to manage the entity's form display, and the tooltip is only visible to users who can reach that entry form.

---

- Add a hover tooltip with guidance text to a field on entity add/edit forms.
- Explain a field's purpose to editors without cluttering the form with description text.
- Configure the tooltip per field from the Manage form display page.
- Give a long-form policy note its own scrollable tooltip pop-out (over 120 characters).
- Attach help to a datetime/date-list field widget.
- Attach help to an entity-reference (`target_id`) field widget.
- Attach help to a link or Linkit field's URL input.
- Attach help to a plain single-value widget (falls back to the element wrapper).
- Show a truncated preview of the tooltip in the widget settings summary.
- Keep field help visible on hover instead of always-on description text.
- Provide editorial onboarding hints on complex content types.
- Standardise per-field guidance across a content model.
- Override the tooltip markup by copying the module template into the site theme.
- Restyle the tooltip via CSS overrides in the site theme.
- Add guidance without creating or changing any content or field storage.
- Document expected formatting or examples for a text field.
- Clarify units or conventions for a numeric field.
- Warn editors about downstream effects of a specific field.
- Reduce support questions by embedding help where editors work.
- Apply tooltips to fields on nodes, taxonomy terms, media, users or any fieldable entity form.
