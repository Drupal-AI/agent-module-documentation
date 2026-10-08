Conditional Fields lets site builders define dependencies between fields on entity forms — showing, hiding, requiring, filling, or disabling one field based on the state and value of another — without writing code, by exposing Drupal's client-side States API through an admin UI.

---

Drupal core has a States API that can make form elements react to each other, but it is only available to developers in code. Conditional Fields brings that power to the admin UI: for any entity bundle (node, media, user, comment, block content, taxonomy, paragraph, and more) you pick a **dependent** field and one or more **controlling** fields, then declare a condition — e.g. "show this field only when that checkbox is checked" or "make this required when that select equals a given value". Each dependency has a **state** (visible/invisible, required/optional, enabled/disabled, filled/emptied, checked/unchecked, collapsed/expanded, read-only, etc.), an **effect** (show/hide, fade, slide) and a **condition trigger** (value, empty, filled, checked, and more). Values can be matched with AND, OR, XOR, NOT or regular-expression logic across multiple entered values. Dependencies are edited at Admin → Structure → Conditional Fields, or via a "Manage Dependencies" tab added to each bundle's configuration page. Field-widget-specific behavior is provided by pluggable **handler plugins** (`ConditionalFieldsHandler`), so checkboxes, selects, radios, entity references, dates, links and text fields each translate their value into the correct States selector. The module builds the final `#states` array and attaches it to the render element at form build time, and it also supports server-side effects such as auto-filling a field with a value.

---

- Show a "Other, please specify" text field only when a select list is set to "Other".
- Hide a set of fields until a checkbox is ticked.
- Make a field required only when another field has a specific value.
- Reveal address fields when the user selects "Ship to a different address".
- Disable a field until a prerequisite field is filled in.
- Collapse/expand a details element based on a radio choice.
- Fill a field automatically with a value when a condition is met.
- Build multi-step-like forms that progressively disclose fields.
- Require a "reason" field when a status select equals "Rejected".
- Show conditional fields on node add/edit forms per content type.
- Add dependencies to Media entity forms.
- Add dependencies to user registration/account forms.
- Add dependencies to comment forms.
- Add dependencies to custom block (block content) forms.
- Add dependencies to Paragraphs subforms.
- Match multiple allowed values with OR logic to trigger a state.
- Require that all of several values be selected using AND logic.
- Trigger a state only when exactly one value is chosen using XOR.
- Hide a field when a value is NOT selected.
- Match a controlling field against a regular expression.
- Use fade or slide animations when showing/hiding fields.
- Make a field read-only based on another field's state.
- Mark a field invalid/valid conditionally.
- Reduce form clutter for editors by hiding irrelevant fields.
- Enforce data-entry rules without custom validation code.
- Export field dependencies as configuration and deploy them between environments.
- Extend support to a custom field widget by writing a handler plugin.
- Restrict who can view/edit/delete dependencies with dedicated permissions.
