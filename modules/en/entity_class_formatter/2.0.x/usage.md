<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Class Formatter provides an "Entity Class" field formatter that renders nothing itself but instead copies the field's value onto the **rendered entity's** wrapper as a CSS class (or any HTML attribute you name).

---

The module ships exactly one plugin — the `entity_class_formatter` field formatter — plus a single `hook_entity_view_alter()` implementation. Assigning the formatter to a field on *Manage display* makes that field invisible in the output (`viewElements()` returns an empty array); instead, on every entity render the hook walks the view display's components, finds every component whose formatter type is `entity_class_formatter`, reads that field's values off the entity and appends them to `$build['#attributes'][<attr>]`, which themes render on the entity wrapper element. Four optional formatter settings shape the result: `prefix` and `suffix` are concatenated around each value, `attr` replaces the default `class` attribute with any attribute name (e.g. `data-variant`), and `field` (entity-reference fields only) reads a named field off the *referenced* entity instead of using its label. Value extraction is type-aware: entity-reference fields contribute the referenced entity's label (or the `field` sub-field), boolean fields contribute their `on_label`/`off_label` setting, and plain fields contribute `value` — split on spaces into multiple classes when the attribute is `class`. Values are sanitised with `Html::getClass()` for classes and `Html::escape()` for any other attribute. The formatter is available on `boolean`, `decimal`, `entity_reference`, `float`, `integer`, `list_string` and `string` fields, and the `attr` setting is *required* for the numeric types (decimal/float/integer) because raw numbers make poor class names. Layout Builder is supported explicitly: when the display is a Layout Builder display the hook scans the layout sections' components for field blocks using the formatter, including per-entity overridden layouts.

---

- Add a CSS class to an article's wrapper from a "Theme colour" list field so the theme can style it.
- Turn a taxonomy term reference (e.g. Category) into a class on every node that references it.
- Expose a boolean "Featured" flag as a `featured` / `not-featured` class using the field's on/off labels.
- Emit a `data-variant` attribute instead of a class by setting the formatter's `attr` setting.
- Add a numeric field (e.g. column count) as `data-columns` — `attr` is required for numeric field types.
- Prefix all generated classes with a namespace such as `bs-` or `u-` to avoid collisions.
- Suffix generated classes with a variant marker such as `--dark`.
- Read a machine-name field off a referenced taxonomy term instead of its human label via the `field` setting.
- Drive a Layout Builder component's styling from a field value without printing the value.
- Give paragraphs a background-colour class chosen by the editor in a select list.
- Let editors pick a per-node layout modifier class from a `list_string` field.
- Keep the class-driving field out of the visible output while still using its value in markup.
- Split a space-separated string field into several independent CSS classes at once.
- Tag media entities with a class derived from a "usage" reference field.
- Add per-user classes to a user display from a profile select field.
- Mark commerce products with a "badge" class taken from a reference field.
- Apply different classes for the same field in different view modes by configuring each display separately.
- Emit an accessibility attribute such as `data-analytics-id` from a string field.
- Use the same field twice in one display (e.g. as a class and as a data attribute) via Layout Builder blocks.
- Replace bespoke `hook_preprocess_node()` code that only existed to copy a field value into `attributes.class`.
- Give taxonomy term pages a class based on a parent-category reference.
- Style teasers differently based on an editor-selected "importance" list field.
- Add a `data-state` attribute from a workflow-ish boolean without exposing labels on screen.
- Namespace classes per bundle by using a different prefix in each bundle's display.
- Let a client-managed field control JS behaviour by writing a class the theme's JavaScript keys off.
