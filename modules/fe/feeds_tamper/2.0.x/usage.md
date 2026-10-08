Feeds Tamper bridges the Feeds and Tamper modules, letting you run Tamper transformation plugins on each source value of a Feeds import before it is mapped and saved.

---

Feeds imports raw data (CSV, XML, JSON, RSS) into Drupal entities, but that data is often messy — wrong case, extra whitespace, comma-separated values that should be split, dates in the wrong format, or values that need find-and-replace. Feeds Tamper adds a **Tamper** operation to each Feeds feed type where you attach one or more Tamper plugins to any source field, in a defined order (by weight). When the feed runs, its event subscriber intercepts each parsed item and passes every source value through its configured tamper chain before Feeds maps it onto the destination field. Tamper plugins are supplied by the separate Tamper module (trim, convert case, explode/implode, find & replace, regex, default value, required, unique, etc.), so Feeds Tamper itself defines no plugin type — it wires Tamper into the Feeds pipeline. Configuration is stored as third-party settings on the feed type config entity, so it exports and deploys with your Feeds configuration. Access is gated by a global "administer feeds_tamper" permission plus a dynamically generated per-feed-type "tamper {id}" permission.

---

- Trim leading/trailing whitespace from every imported title.
- Convert imported names or codes to upper, lower, or title case.
- Explode a comma-separated cell into multiple taxonomy term references.
- Implode multiple source values back into a single string.
- Find and replace substrings in imported text (e.g. fix a domain in URLs).
- Apply a regular-expression replacement across a source field.
- Set a default value when a source field is empty.
- Mark a source as required so items missing it are skipped.
- Strip HTML tags from a scraped description field.
- Convert imported date strings into a format Drupal can parse.
- Cast a string to a number or boolean before mapping.
- Make imported values unique to avoid duplicate rows.
- Sanitize imported HTML to a safe subset before saving.
- Rewrite relative image paths to absolute URLs during import.
- Truncate an overly long field to a maximum length.
- Map source keywords onto known values with a lookup/replace.
- Chain several tampers on one field in a specific order.
- Clean up product SKUs (uppercase + trim) before a Commerce import.
- Split a full-name column into separate values for first and last name.
- Normalize phone numbers to a consistent format on import.
- Prefix or suffix imported values with fixed text.
- Remove currency symbols so a price field imports as a number.
- Deploy the same tamper rules across environments via exported feed-type config.
- Grant a specific editor rights to tamper only one particular feed type.
- Encode or decode entities/URLs in scraped content before storage.
- Filter out unwanted items by requiring a value to match a condition.
