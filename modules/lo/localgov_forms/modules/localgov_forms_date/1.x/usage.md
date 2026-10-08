A submodule of LocalGov Forms providing GDS-style day/month/year date and date-of-birth Webform elements with plain-English validation messages.

---

LocalGov Forms Date adds two Webform elements — `localgov_forms_date` (LocalGov Forms Date) and `localgov_forms_dob` (LocalGov Forms Date of Birth) — that render a date as three separate text inputs (Day / Month / Year) following the GOV.UK Design System date-input pattern, rather than a picker or drop-downs. Built on core's `Datelist`, they add numeric-input attributes (`inputmode`/`pattern`/placeholders), a configurable **Invalid date message**, and rewritten validation that produces clear, non-duplicated wording ("Date of birth must be a real date", "The day in Date of birth must be a number") across both Drupal 10 and 11. The module ships two UK date-format config entities (`d-m-Y` and `d-m-Y\TH:i:sO`) used for formatting validation errors. It depends on Webform and the parent localgov_forms module.

---

- Collect a date of birth on a webform as three accessible Day/Month/Year text boxes instead of a calendar widget.
- Collect any date (appointment, incident, application date) in the GOV.UK three-field pattern.
- Give residents clear, plain-English date errors ("Date of birth must be a real date") instead of core's "The %field date is invalid".
- Report exactly which part is wrong when a box contains letters ("The day in Date must be a number").
- Report which parts are missing on an incomplete date ("Date must include a month and a year").
- Customise the invalid/incomplete wording per element via the **Invalid date message** field, or leave it blank for defaults.
- Use the element's **Required message** verbatim (no italicised field name, one message per field).
- Constrain acceptable years with the element's date min/max settings.
- Present a mobile-friendly numeric keypad for each date box via `inputmode="numeric"` and `pattern="[0-9]*"`.
- Preserve exactly what a user typed (e.g. `1A`) in the box when validation fails, rather than silently coercing it to `1`.
- Use the DOB element as part of a multi-page/composite webform (it sets its default value like a datelist).
- Format submitted dates and validation errors in UK `dd-mm-yyyy` style using the shipped date-format entities.
- Build council intake forms (benefits, blue-badge, school admissions) that need a robust DOB field.
- Offer the DOB field with a helpful example hint ("For example 08/02/1982").
- Translate the custom invalid-date message alongside webform's own required message.
- Avoid PHP fatals on non-numeric date parts on Drupal 10 (the element absorbs the `\TypeError` core would otherwise throw).
- Style the day/month/year boxes with the shipped `date.css` (per-part CSS classes `localgov_forms_date__day/__month/__year`).
