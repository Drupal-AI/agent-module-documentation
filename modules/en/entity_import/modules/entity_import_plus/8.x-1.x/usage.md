Entity Import Plus is a submodule of Entity Import that adds three migrate_plus-based process plugins (Entity Lookup, Entity Generate, String Replace) to the parent module's field-mapping UI.

---

Entity Import ships a set of core process plugins; Entity Import Plus extends that set by wrapping three migrate_plus process plugins so they are selectable and configurable directly on an Entity Import field mapping. Entity Lookup resolves an inbound value (e.g. a term name or username) to an existing entity's ID for a reference field, with a configurable match operator and case sensitivity. Entity Generate builds on Entity Lookup and auto-creates the referenced entity when no match exists. String Replace performs literal or regex search/replace on inbound values, supporting multiple search/replace pairs and `CHR:<code>` escape sequences for control characters. A small event subscriber seeds valid stub configuration (a node destination for the lookup/generate plugins, empty search/replace for str_replace) so these migrate_plus-derived plugins instantiate cleanly inside Entity Import's dynamically generated migrations. The submodule requires migrate_plus and the parent entity_import module; it defines no routes, permissions, or config schema of its own.

---

- Map a CSV column of category names to an entity-reference field by looking up existing taxonomy terms.
- Resolve author names/emails in a CSV to existing user IDs during a node import.
- Match reference targets with operators other than exact equality: starts-with, ends-with, or contains.
- Perform case-insensitive entity lookups when source data casing is inconsistent.
- Auto-create a referenced taxonomy term that does not yet exist while importing content.
- Auto-create any referenced fieldable entity on the fly with Entity Generate instead of pre-seeding it.
- Populate a multi-value reference field from multiple matched entities (IN operator).
- Clean inbound strings with a literal search/replace before storing them.
- Apply regular-expression replacements to normalize messy source values.
- Run several ordered search/replace pairs on one value in a single process step.
- Inject control characters (e.g. tabs, newlines) into replacements using `CHR:<code>` codes.
- Combine String Replace with the parent module's explode/extract processes to split then clean values.
- Chain Entity Lookup after a String Replace so values are normalized before matching.
- Deduplicate imports by resolving human-readable keys to stable entity IDs.
- Keep non-technical editors in the point-and-click importer while still doing reference resolution.
- Avoid hand-writing migrate_plus EntityLookup/EntityGenerate/StrReplace YAML for spreadsheet imports.
