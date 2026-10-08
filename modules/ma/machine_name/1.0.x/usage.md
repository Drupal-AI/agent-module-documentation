Machine Name adds a `machine_name` field type (with matching widget and formatter) that stores a short machine-readable identifier on any fieldable entity, rendered with Form API's `#type = 'machine_name'` element and optionally enforced unique.

---

The module defines a `machine_name` field type storing a `varchar(64)` value (indexed, NOT NULL, default `''`). Its default widget (`machine_name`) renders the value as a core `#type = 'machine_name'` element with a 64-char max length; two widget settings control behaviour: **Editable** (when off, the value becomes disabled/read-only once the entity has been saved) and **Unique** (whether the value must be unique for that field across the entity type). Uniqueness is enforced by a `MachineNameUnique` validation constraint on the field item: its validator (`MachineNameUniqueValidator`) loads the bundle's default `entity_form_display`, checks that the field's widget has `unique` enabled, and runs an `entityQuery` (with `accessCheck(FALSE)`) for other entities sharing the value, adding a violation if found. Note the uniqueness check is keyed off the **default** form display's widget settings, and the widget's own `exists` callback always returns FALSE (the constraint, not the element, does the real uniqueness validation). The formatter (`machine_name`) outputs the value HTML-escaped with `nl2br`. There is no admin settings page, no permission, and no dependency beyond core; a config schema describes the two widget settings.

---

- Add a stable machine-readable key/slug field to a content type.
- Store a unique code or identifier on a custom entity bundle.
- Give editors a machine-name field that auto-transliterates their typed label (core `machine_name` element behaviour).
- Enforce that an entered identifier is unique across all nodes of a type.
- Allow non-unique machine-style values by turning the Unique widget setting off.
- Lock a machine name so it can't be changed after the entity is first saved (Editable off).
- Permit ongoing edits to the machine name by enabling Editable.
- Capture an external system's key (e.g. an API/product code) in a validated 64-char field.
- Provide a predictable token/identifier for use in views, URLs, or integrations.
- Use as a taxonomy-term or user "handle"/slug field.
- Display the stored machine name read-only via the machine_name formatter.
- Add a unique short-name field to a paragraph or media bundle.
- Migrate a Drupal 7 machine-name field to Drupal 10/11.
- Provide a machine-name field for config-like content entities (the module's original drupal.org "project" use case).
- Prevent duplicate identifiers when editors create many similar records.
- Reference entities by a human-chosen machine key rather than the numeric id.
- Store a canonical lowercased/underscored form alongside a human label field.
- Constrain identifiers to the machine-name character set via the core element.
- Add multiple machine-name fields (each with its own unique/editable behaviour) to one bundle.
- Feed a machine-name value into automated naming or export routines.
