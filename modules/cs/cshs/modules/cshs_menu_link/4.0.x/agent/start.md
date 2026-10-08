# cshs_menu_link — agent start

Submodule of **cshs**. Converts the menu_ui "Parent item" select on node forms (and taxonomy
term forms when `taxonomy_menu_ui` is enabled) into the CSHS hierarchical drill-down. Requires
`cshs` + core `menu_ui`. No configuration and no permissions.

- Implemented in `cshs_menu_link.module` via `hook_form_BASE_FORM_ID_alter()`:
  `cshs_menu_link_form_node_form_alter()` and `cshs_menu_link_form_taxonomy_term_form_alter()`
  set the parent-item element `#type` to `cshs` (`CshsElement::ID`) and attach the
  `cshs_menu_link/cshs_menu_link` library.
- It no-ops if the element was already transformed into a CSHS widget by something else.
- For the underlying widget/element behavior, see the parent module's docs (widget, form
  element).
