Tamper is a generic plugin system for transforming ("tampering") data values — trimming, find/replace, casting, encoding, math, and dozens more — most commonly used by the Feeds module to clean imported data.

---

Tamper defines a single plugin type, **Tamper**, whose plugins each take an input value, manipulate it, and return an output value. It ships around 45 ready-made plugins covering text (trim, find/replace, regex, strip tags, truncate, sprintf, case conversion, transliteration), numbers (math, number format, cast to int), encoding (URL encode/decode, HTML entities, hashing, base64), arrays (explode, implode, unique, filter, aggregate), and control-flow helpers (required, skip on empty, default value). Tamper on its own has no UI or configuration — it is a developer toolkit consumed by other modules, most notably Feeds, which lets site builders chain Tamper plugins onto each source field of an import. Each plugin is configurable (implements `PluginFormInterface`/`ConfigurableInterface`) and declares via an `itemUsage` flag whether it needs access to the whole item being processed. Plugins can throw `SkipTamperDataException` or `SkipTamperItemException` to skip a value or an entire item mid-pipeline, and a `multiple()` method signals when a single input has been expanded into a list. Plugins are discovered from `Plugin/Tamper/` using PHP attributes (or legacy annotations) and managed by the `plugin.manager.tamper` service. Developers add their own transformations by extending `TamperBase`, and the plugin list is alterable via `hook_tamper_info_alter()`.

---

- Trim whitespace from an imported field before saving.
- Find and replace text in a value (plain, regex, or multiline).
- Strip HTML tags from scraped content.
- Convert a string to a boolean for a checkbox/flag field.
- Cast a numeric string to an integer.
- Explode a delimited string into multiple values.
- Implode an array of values into a single string.
- Deduplicate a multi-value field with the unique plugin.
- Encode/decode URLs or HTML entities during import.
- Hash a value (e.g. build a stable unique key).
- Apply a math operation to a numeric field.
- Format numbers with thousands separators / decimals.
- Transliterate accented text to ASCII.
- Change case (upper, lower, title, sentence).
- Truncate text to a maximum length with an ellipsis.
- Rewrite a value using tokens from other source fields.
- Render a value through a Twig template.
- Convert a full country name to its ISO code.
- Convert a US state name to its abbreviation.
- Build an absolute URL from a relative path.
- Provide a default value when the source is empty.
- Mark a field required and skip items missing it.
- Skip an item entirely when a value is empty.
- Offset a date/time value by a fixed amount.
- Parse a string into a timestamp with strtotime.
- Filter array items by keyword.
- Aggregate multiple values into one.
- Chain several tampers on one Feeds source field to build a cleaning pipeline.
- Write a custom Tamper plugin for a project-specific transformation.
- Apply Tamper transformations programmatically in custom migration/import code.
