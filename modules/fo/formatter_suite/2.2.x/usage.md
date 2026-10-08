Formatter Suite is a collection of 18 general-purpose field formatters that give editors and site builders far more control over how numbers, dates, timestamps, text, links, email addresses, files, images, and entity/user references are displayed — all configured on an entity's *Manage display* tab.

---

The module adds field formatter plugins (in `src/Plugin/Field/FieldFormatter/`) selectable per field in the Field UI's *Manage display* and in Views. Number formatters ("General number", "Number with bar indicator", "Number with min/max", "Bytes with KB/MB/GB suffix") support decimal places, positive/negative notation styles, thousands/decimal separators, zero padding, scientific/percentage notation, and byte-size suffixes. Date/time and timestamp formatters render multi-value date fields as lists with custom or named formats or "time ago" relative text. Link/reference formatters ("General link", "General file link", "General email", "General entity reference", "General user reference", "Rendered entity list") add configurable title text (field title, URL text, or manual), custom CSS classes, `rel`/`target` options, list separators, and open-in-new-window behavior. "General image" adds URL/link options around images, "Image with embedded data URL" inlines images as `data:` URIs, and "Text with expand/collapse buttons" truncates long text with JS-driven show/hide buttons. There is no admin settings page (`configure` is null) and no permissions; each formatter stores its settings in the field's display config. Admin-entered settings such as custom title text and list separators are passed through `Xss::filterAdmin()` before rendering. The module is maintained by SDSC and its formatters extend core `FormatterBase`/core formatters.

---

- Format decimal/integer/float fields with a chosen number of decimal places and thousands/decimal separators.
- Display numbers in scientific (E-notation or superscript) or percentage notation.
- Zero-pad numbers to a fixed width and choose positive/negative styling.
- Show a numeric field as a horizontal bar indicator (gauge) scaled between min and max.
- Annotate a number with its configured minimum and maximum.
- Render an integer byte count as a human-readable KB / MB / GB / TB size.
- Present multi-value date fields as a formatted list using a named or custom date format.
- Show dates or timestamps as relative "time ago" text (e.g. "3 days ago").
- Format `created`/`changed`/timestamp fields as a list with a chosen format.
- Turn a link field into one or more links with custom title text, classes, and `rel`/`target` options.
- Open link/file/reference links in a new window/tab with proper `rel="noopener"` handling.
- Display an email field as a `mailto:` link with custom link text.
- Render a file field as a download link with a custom label and CSS classes.
- Render an entity reference as a link, plain text, or the fully rendered entity, as a separated list.
- Render a user reference with configurable display (name/link) and separators.
- Show an image with an optional wrapping link to the file, entity, or a custom URL.
- Inline small images directly into the page as base64 `data:` URLs to avoid extra requests.
- Truncate long text/formatted-text fields with JavaScript expand/collapse buttons and custom labels.
- Use a custom separator string between multiple field values in list formatters.
- Apply custom CSS classes to formatted output for theming without template overrides.
- Configure link title from the URL itself when a link field has no title text.
- Provide consistent number/date/link presentation across many content types via reusable formatters.
- Replace core's limited link/number formatters with richer, settings-driven equivalents in Views.
