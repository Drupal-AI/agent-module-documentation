Views Conditional adds a Views field that outputs different content based on an IF/THEN/ELSE condition comparing another field in the same row against a value.

---

Views Conditional provides a single Views field handler, "Views: Views Conditional" (`views_conditional_field`), that you add to a view's Fields section like any other field. In its settings you pick one earlier field to test ("If this field..."), choose a comparison operator ("Is..."), and enter a value to compare against; you then supply the text to output when the condition is true ("Then output this...") and, optionally, text to output when it is false ("Otherwise, output this..."). Operators include equals, not equals, greater/less than (and or-equal variants), empty, not empty, contains, does not contain, and string-length comparisons (length equal/not-equal/greater/less). Both the compare value and the output text accept replacement tokens: `{{ field_machine_name }}` for any field that appears above this one in the field list, plus `DATE_UNIX` and `DATE_STAMP` for the current time. Because the handler only reads fields rendered before it, the Views Conditional field must be placed AFTER every field it references, and those source fields are typically set to "Exclude from display" so only the conditional output shows. Options also let you translate the Then/Or text before token substitution and strip HTML tags from the output. It requires only core Views and stores its settings inside the view configuration (no separate config entity or admin settings form).

---

- Show a "Free" badge when a price field equals 0 and a formatted price otherwise.
- Display "In stock" / "Out of stock" text based on a stock-quantity field.
- Output a colored status label ("Published"/"Draft") derived from a status field.
- Render a "New" flag when a created-date field is greater than a threshold.
- Show "No image" placeholder text when an image field is empty.
- Emit a call-to-action button only when a link field is not empty.
- Compare two rendered fields by referencing both with `{{ }}` tokens.
- Display "Featured" when a boolean/flag field contains a given value.
- Hide-or-show wording when a field does NOT contain a substring.
- Show "Too long" when a text field's length is greater than a limit (length operators).
- Warn "Missing summary" when a body/summary field is empty.
- Output a star rating label mapped from a numeric rating field.
- Show membership tier text based on a role or points field value.
- Display "Expired" vs "Active" by comparing a date field to `DATE_UNIX`.
- Build an at-a-glance dashboard column that turns raw values into human-readable states.
- Combine excluded fields into one composed cell of custom markup.
- Add conditional icons or emoji next to rows meeting a criterion.
- Localize the Then/Or output via the per-display translation context.
- Strip tags from a rendered source field so a clean value can be compared.
- Provide fallback text ("N/A") when a field is empty using the Empty operator.
- Flag overdue items where a due-date field is less than the current timestamp.
- Show discount messaging when an original vs sale price comparison is true.
- Render different admin-view hints depending on a workflow-state field.
- Display "Complete"/"Incomplete" based on whether a required field is filled.
- Insert conditional CSS classes/markup by embedding tokens in the Then output.
