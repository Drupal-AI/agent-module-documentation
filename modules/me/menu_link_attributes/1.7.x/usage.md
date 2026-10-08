Menu Link Attributes lets site builders add configurable HTML attributes (CSS classes, `target`, `rel`, `id`, `data-*`, etc.) to individual menu links and their `<li>` container elements directly from the menu link edit form.

---

Drupal's menu link content form has no built-in way to attach arbitrary HTML attributes to a link, so this module adds an **Attributes** fieldset to the menu link add/edit form. Which attributes appear is fully configurable at **Admin → Structure → Menus → Available attributes** (`/admin/config/menu_link_attributes/config`), where an administrator edits a small YAML document; each attribute can define a `label`, `description`, input `type` (textfield, select, checkboxes, managed_file, …), select `options`, and a `default_value`. Out of the box it ships `container_class`, `class`, and `target`. Attributes whose name starts with `container_` (or that set `container: true`) are applied to the menu item's `<li>` container instead of the `<a>` element, via a `hook_preprocess_menu()` implementation. Values are stored inside the menu link's `link` field `options` (`attributes` and `container_attributes` keys), so they render automatically through Drupal's link/menu theming. Two permissions gate the feature: *use menu link attributes* controls who can set values on the link form, and *administer menu link attributes* controls who can define the available attribute list. It also handles multilingual menu links, keeping attribute values in sync across translations.

---

- Add a custom CSS `class` to a single menu link for targeted styling.
- Add classes to the menu item `<li>` container via `container_class`.
- Open a specific menu link in a new tab by setting `target` to `_blank`.
- Force a link to open in the same window with `target` `_self`.
- Add `rel="nofollow"` or `rel="noopener"` to outbound menu links.
- Attach a unique `id` attribute to a menu link for anchor/JS targeting.
- Add `data-*` attributes (e.g. `data-toggle`, `data-analytics`) for JS behaviors.
- Add ARIA attributes like `aria-label` to improve menu accessibility.
- Add a `title` tooltip attribute to a menu link.
- Give call-to-action menu links a button class (e.g. `btn btn-primary`).
- Define a select-list attribute so editors pick from preset values (e.g. icon names).
- Provide a checkboxes attribute to toggle multiple utility classes at once.
- Set a `default_value` so new links get a class automatically.
- Configure a `managed_file` attribute to attach an uploaded asset reference.
- Restrict who can edit link attributes with the *use menu link attributes* permission.
- Restrict who can define the attribute list with *administer menu link attributes*.
- Style dropdown/mega-menu containers by classing the parent `<li>`.
- Add icon-font classes (e.g. `fa fa-home`) to navigation links.
- Mark external links with a class for CSS "external link" icons.
- Highlight promotional menu items with a distinct wrapper class.
- Ship the available-attributes definition as exportable configuration between environments.
- Keep attribute values consistent across translated menu links on multilingual sites.
- Add tracking hooks (`data-gtm-*`) to menu links for analytics.
- Provide theme-agnostic hooks for JavaScript menu enhancements (sticky, off-canvas).
- Add `accesskey` or `tabindex` attributes for keyboard navigation.
- Bulk-fix legacy malformed `class` values via the shipped update hook.
