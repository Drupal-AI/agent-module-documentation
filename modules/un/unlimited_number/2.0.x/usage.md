Unlimited Number provides a Form API render element (`#type => unlimited_number`) and a matching integer-field widget ("Unlimited or Number") that let a user pick between an "Unlimited" choice and typing a specific number — the classic cardinality-style "-1 = unlimited / N = limited" control.

---

The module ships two things. First, a `FormElement` (`Drupal\unlimited_number\Element\UnlimitedNumber`, `#type => unlimited_number`) that renders two radios — "Unlimited" and "Limited" — where choosing "Limited" reveals an inline `#type => number` field. When submitted, the element resolves to a single scalar: the string constant `UnlimitedNumber::UNLIMITED` (`'unlimited'`) if the unlimited radio is chosen, or the entered integer if a number is typed. It honours `#min`, `#max`, `#step`, `#field_prefix`, `#field_suffix`, `#default_value`, and custom radio labels via `#options['unlimited']` / `#options['limited']`. Second, a `FieldWidget` (`UnlimitedNumberWidget`, id `unlimited_number`, label "Unlimited or Number") that plugs that element into any **integer** field's edit form. The widget extends core's `NumberWidget` and adds three settings — `value_unlimited` (the integer actually stored when the user picks "Unlimited", default `0`), `label_unlimited`, and `label_number` — so "unlimited" is persisted as a real integer value of your choosing (e.g. `0` or `-1`). There is no admin UI, no permissions, and no Drush; the only configuration surface is the widget's settings on an entity form display. Config schema is provided for those widget settings (`field.widget.settings.unlimited_number`). Use it in custom forms via the render element, or on content by setting an integer field's form widget to "Unlimited or Number".

---

- Give an integer field an "Unlimited or a specific number" control on the node/entity edit form.
- Store "unlimited" as `0` in an integer field while letting editors type any other limit.
- Store "unlimited" as `-1` (core cardinality convention) by setting the widget's `value_unlimited` to `-1`.
- Build a custom settings form where an admin chooses "Unlimited" or enters a numeric cap.
- Add a per-user "max items" field that can be either unlimited or a concrete number.
- Model a subscription/seat limit that is either unlimited or a fixed integer.
- Offer an "unlimited downloads" vs "N downloads" choice on a product-like content type.
- Rename the radios to domain wording (e.g. "No limit" / "Set a limit") via `#options`.
- Rename the widget radios to "Forever" / "Until a number" through the widget's `label_unlimited` / `label_number` settings.
- Capture a rate limit that may be unlimited without using a separate checkbox + number pair.
- Replace an awkward "-1 means unlimited, but type it yourself" number field with a guided radios+number UI.
- Add `#min` / `#max` bounds to the numeric branch so typed limits stay within a valid range.
- Attach `#field_prefix` / `#field_suffix` (e.g. "$", "items") to the numeric input in a custom form.
- Require a value: the element forces a number when "Limited" is chosen, erroring otherwise.
- Provide a cardinality-like control in a config form for a module that has an "unlimited or N" option.
- Collect "unlimited or numeric" quota values in a webform-style custom form built with Form API.
- Let editors express "no expiry (unlimited) or after N days" as an integer with a clean UI.
- Prefill the control from stored data via `#default_value` (an integer, or `'unlimited'`).
- Use `#step` to constrain the numeric branch to increments (e.g. multiples of 5).
- Drive AJAX off the element by passing `#ajax` (propagated to the radios and number sub-elements).
- Model "unlimited or fixed" pricing tiers, storage caps, or API quotas on a content type.
- Keep the stored data a plain integer column (no extra field type) so Views/queries stay simple.
- Present a "Maximum attempts: unlimited / N" control on a quiz or form-limit configuration.
- Configure the widget entirely through config (entity_form_display) so it deploys with your site config.
- Reuse the same "unlimited or number" pattern across multiple integer fields by assigning the widget to each.
