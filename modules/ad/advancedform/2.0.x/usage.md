Advanced Form declutters Drupal node edit forms by hiding administrator-configured fields with CSS, with a client-side toggle button to reveal the full form on demand.

---

Advanced Form is a small UI convenience for teams of trusted content editors who work with long, busy node edit forms. An administrator enters a list of CSS-selector rules on the module's settings page; on every node add/edit form the module injects a generated `<style>` block that sets `display: none` on the matching elements, and prepends a "Show additional fields" / "Hide additional fields" toggle button so editors can flip the whole form between a slimmed-down view and full detail. The form is given an `advanced-form-filtered` body class (plus one `role-<name>` class per current user role), and JavaScript adds `selected-<label>` classes as options-select widgets change, so rules can be made conditional on the value chosen in the form (for example, only hide certain fields when a particular taxonomy term is selected). The hiding is entirely client-side and cosmetic: the fields remain present in the DOM and fully submittable, so this is a tidiness aid, not a way to restrict data or permissions. The 2.0.x release applies only to node forms via `hook_form_node_form_alter()`. Configuration lives in the single `advancedform.settings` config object (`rules_global`), and the settings route is gated by the `administer advanced form settings` permission.

---

- Hide the revision-information fieldset on all node forms so it stops distracting editors.
- Collapse a cluttered e-commerce product edit form down to the handful of fields editors actually change.
- Give content editors a one-click "Show additional fields" toggle to reveal advanced options only when needed.
- Demonstrate a site to editors the way they will see it, while keeping admin fields reachable in the same session.
- Hide the promotion options (sticky / promoted to front page) on node forms for a given content type.
- Hide the authoring-information fieldset (author, published-on date) for routine editors.
- Hide the URL-alias / path settings on node forms where an automatic alias module already handles them.
- Hide the meta-tags or SEO field group unless an editor explicitly opts to edit it.
- Conditionally show extra fields only when a "Landing page" taxonomy term is selected, using a `selected-landing-page` context class.
- Show shipping-related fields on a product form only when a "Physical" product type option is chosen.
- Reduce onboarding friction for new editors by presenting a minimal form first, full form on toggle.
- Tidy a demonstration/tutoring site so the edit UI looks simple without changing any real permissions.
- Hide the comment-settings fieldset on node forms when comments are managed elsewhere.
- Hide the menu-settings fieldset on node forms for content types that never appear in menus.
- Apply role-specific hiding by combining rules with the auto-added `role-<name>` form class.
- Keep a field visually hidden yet still validated and submitted, avoiding the need for custom field-access code.
- Standardize a "clean" default edit experience across a team while preserving each editor's full control.
- Debug which rule hides what by inspecting the injected `edit-advancedform-css` style element.
- Hide a translation or language field group on node forms for single-language workflows.
- Provide a lightweight alternative to permission-based form filtering when you trust your editors.
