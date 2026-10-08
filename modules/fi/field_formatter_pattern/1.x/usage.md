Field Formatter pattern adds an HTML5 `pattern` (regex) attribute and a custom validation message to text-field and textarea edit widgets, configured per field on Manage form display.

---

Despite its name, this module does not provide a field *display* formatter. It hooks into the entity **edit form**: on Manage form display it adds two third-party settings — a **Pattern** (an HTML5 `pattern` regular expression) and a **Pattern error message** — to a fixed list of core text widgets (`string_textfield`, `string_textarea`, `text_textfield`, `text_textarea`, `text_textarea_with_summary`, `key_value_textarea`; other modules can register more via `hook_field_formatter_pattern_widget_settings()`). At render time it copies the pattern onto the widget input's `pattern` attribute and the message onto its `title` attribute, so the browser enforces the regex client-side when a content author submits the form. It requires no other modules, adds no permissions, and stores its settings inside the form-display config as third-party settings under the `field_formatter_pattern` namespace.

---

- Require a phone number field to match a digits-and-dashes pattern before the node form will submit.
- Enforce a postal/ZIP code format on an address text field.
- Constrain a "SKU" or product-code field to an uppercase alphanumeric pattern.
- Force a slug/machine-name style value (lowercase letters, digits, hyphens) on a plain text field.
- Validate an ISBN, VAT, or tax-ID field against a fixed character pattern.
- Require a hex color value (e.g. `#` plus six hex digits) in a text field.
- Restrict a "Twitter/X handle" field to `@` followed by allowed characters.
- Ensure a coupon-code field is exactly N characters of a given alphabet.
- Keep a "year" text field to four digits.
- Enforce a currency-amount pattern (digits, optional decimal) on a plain text field.
- Constrain a username-like custom text field to a safe character set.
- Require an internal reference number to follow a department-specific format.
- Add a human-readable hint (via the error message → input `title` tooltip) telling editors the expected format.
- Apply format rules on user-profile text fields (the settings appear on any entity's Manage form display, not just nodes).
- Constrain a taxonomy-term text field or a custom entity's text field the same way.
- Enforce a license-plate or serial-number pattern on an inventory content type.
- Require a specific date-string shape in a plain text field where you are not using a real date field.
- Limit an "extension" or "port" text field to a numeric range expressed as a regex.
- Give site builders per-field validation without writing a custom FieldConstraint or validation module.
- Register additional custom text widgets as pattern-eligible from your own module with `hook_field_formatter_pattern_widget_settings()`.
- Show the active pattern inline on the Manage form display summary line so builders can see it at a glance.
- Note: because the check is the browser's native HTML5 `pattern` attribute, treat it as an editor-convenience guardrail on the edit form, not as a server-side validation constraint.
