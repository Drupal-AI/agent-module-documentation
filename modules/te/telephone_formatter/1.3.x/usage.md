Telephone Formatter adds a single field formatter (`telephone_formatter`, label "Formatted telephone") for core `telephone` fields that reformats the stored number with Google's libphonenumber and can render it as a clickable `tel:` link.

---

The module depends on the core `telephone` module and the `giggsey/libphonenumber-for-php` library. It registers one field formatter, `telephone_formatter`, that applies only to `telephone` field types and is selected on an entity's **Manage display** screen (there is no admin settings page — `configure` is null). Instead of echoing the raw stored string, it parses the number and re-emits it in one of four libphonenumber formats: International (`format` = 1, the default), E164 (`0`), National (`2`), or RFC3966 (`3`). A **Link** checkbox (on by default) wraps the formatted number in a `tel:` link whose href is the RFC3966 form, so it is click-to-call on mobile. An optional **Default country** setting lets national/local numbers be parsed against a chosen country when the field allows non-E.164 input; the module suggests pairing it with `telephone_validation` to guarantee parseable data. If a value cannot be parsed or is invalid, the formatter falls back to printing the raw value unchanged, so it never fatals on bad data. The formatting logic lives in a reusable service, `telephone_formatter.formatter` (`Drupal\telephone_formatter\Formatter`), whose `format($input, $format, $region = NULL)` method you can call from custom code. Settings persist in the display config under `field.formatter.settings.telephone_formatter` (`format`, `link`, `default_country`).

---

- Render a stored phone number in pretty International format (e.g. `+1 202-555-0136`) instead of the raw digits.
- Turn a telephone field into a click-to-call `tel:` link on node, teaser, or user displays.
- Output numbers in strict E164 form (`+12025550136`) for machine-readable APIs or data feeds.
- Display numbers in National format for a domestic, single-country audience.
- Emit RFC3966 (`tel:+1-202-555-0136`) format explicitly for a field value.
- Normalize inconsistently entered phone numbers to one canonical display format.
- Add a default country so editors can type local numbers without the `+` country code.
- Show a formatted phone link in a View that lists contacts or businesses.
- Format a site-wide "contact us" phone field the same way on every page.
- Keep the number a plain formatted string (Link unchecked) when you don't want a link.
- Provide accessible click-to-call links for mobile visitors of a directory.
- Standardize phone display across multiple content types using display config export.
- Reformat legacy imported phone data at display time without altering stored values.
- Call `telephone_formatter.formatter`->`format()` in custom code to reformat a number.
- Reuse the formatter service to build a `tel:` URI from an arbitrary phone string.
- Degrade gracefully: invalid numbers print as-entered instead of throwing an error.
- Pair with `telephone_validation` to ensure only parseable numbers reach the formatter.
- Show international numbers correctly for a multi-country membership directory.
- Configure per-view-mode formatting (International on full, National on teaser).
- Export the formatter's display settings between environments as config.
