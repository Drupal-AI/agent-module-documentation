Field Group bootstrap adds a large set of Bootstrap 5 field-group formatters to the Field Group module, letting you wrap groups of fields on entity form and view displays in accordions, tabs, cards, modals, offcanvas panels, popovers, toasts, multistep wizards and more — intended for use with a Bootstrap 5 based theme.

---

The module extends `field_group` with plugins in `src/Plugin/field_group/FieldGroupFormatter/`, most supporting both the `form` and `view` contexts. Included formatters: Bootstrap Accordion, Tab/Tabs, Card, Modal, Offcanvas, Popovers, Toast, Toggle, Horizontal Form, Floating Labels, Grid, Multistep, Scrollspy (ScrollSpy) and Table, plus a `TwigElement` ("Twig element") formatter that renders an admin-entered inline Twig template around the group's contents. Each formatter provides a `settingsForm()`/`settingsSummary()` (e.g. accordion default panel, "always open", flush styling, Bootstrap icon classes) and emits Bootstrap 5 markup and CSS classes; matching render Element classes live in `src/Element/`, and behaviour JS ships in `js/` (accordion cookie state, multistep, popovers) via `field_group_bootstrap.libraries.yml`. There is no admin settings page (`configure` is null) and no permissions — you choose a formatter per field group on *Manage form display* / *Manage display* exactly like any other Field Group formatter. Requires `field_group` and a Bootstrap 5 theme to render correctly.

---

- Group fields into a Bootstrap 5 accordion on a node edit form or view display.
- Organise a long edit form into Bootstrap tabs.
- Wrap a group of fields in a Bootstrap card.
- Present a field group inside a Bootstrap modal dialog.
- Slide a group of fields in from the side with a Bootstrap offcanvas panel.
- Attach Bootstrap popovers to grouped content.
- Show grouped content as Bootstrap toast notifications.
- Add a Bootstrap toggle/collapse around fields.
- Lay out a form as a Bootstrap horizontal form.
- Use Bootstrap floating labels on grouped form fields.
- Arrange fields in a Bootstrap grid.
- Build a multistep form wizard from field groups.
- Add scrollspy navigation across grouped sections.
- Render grouped fields as a Bootstrap table (vertical or horizontal).
- Set which accordion panel is open by default.
- Add Bootstrap icon classes to accordion headers.
- Remove the accordion background with the "flush" option.
- Render arbitrary custom markup around a group via an inline Twig template (Twig element formatter).
- Keep accordion open/closed state across page loads using a cookie.
- Reuse Bootstrap components for editorial UX without hand-writing templates.
- Apply the same Bootstrap grouping on both the form and the rendered view.
- Provide a consistent Bootstrap 5 look across content-entry screens.
