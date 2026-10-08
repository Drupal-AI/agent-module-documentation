Force an entity type's base fields (created, changed, uid, langcode, revision fields, etc.) to become configurable in the Field UI "Manage display" screens so you can assign formatters and render them.

---

Content entity types declare which of their base fields are display-configurable via `setDisplayConfigurable('view', ...)` in `baseFieldDefinitions()`. Many useful base fields (authoring date, changed date, author/uid, language) ship as non-configurable, so they never appear in the "Manage display" UI and cannot be given a formatter. Base Field Display Configurability Override provides one admin form (`/admin/structure/base-field-display-override/manage`) listing every overridable content entity type and its base fields with three radio choices — Visible, No override, Hidden — and stores the choices in the `base_field_display_override.overrides` config object. A `hook_entity_base_field_info_alter()` implementation reads that config on every field-definition rebuild and calls `setDisplayConfigurable('view', TRUE|FALSE)` accordingly, then the form clears the field-definition cache so the change takes effect immediately. It only flips the configurability flag; it does not bypass field access, so protected fields still obey their access handlers when rendered.

---

- Expose a node's `created` (authored on) base field in Manage display and render it with a Date formatter.
- Surface the `changed` (updated) timestamp so themers can show "last updated" without a custom field.
- Make the `uid` (author) base field configurable to render the author with an entity-reference formatter.
- Reveal the `langcode` base field in the display so it can be shown or hidden per view mode.
- Turn on display configurability for a media entity's base fields (e.g. `created`, `uid`).
- Configure display for a taxonomy term's base fields such as `changed` or `revision_log_message`.
- Expose a comment entity's `created` field for rendering in the comment display.
- Force a custom/contrib content entity type's base fields into Field UI without editing its PHP class.
- Standardise which base fields are display-configurable across a multisite via exported config.
- Hide a base field from Field UI that a module made configurable, by setting it to Hidden.
- Give a base field a formatter per view mode (Default, Teaser, RSS) once it is marked Visible.
- Show the `sticky` or `promote` base flags in a node display for debugging content state.
- Render a user entity's non-sensitive base fields (e.g. `created`) on the user profile display.
- Let site builders assign formatters to base fields without writing a custom `hook_entity_base_field_info_alter()`.
- Roll out consistent base-field display settings by committing `base_field_display_override.overrides.yml`.
- Reset all overrides for an entity type by setting every field back to "No override" and saving.
- Combine with core Field UI to build teaser/full view modes that include base timestamps.
- Quickly audit which base fields an entity type declares, since the form lists them all with machine names.
- Prepare base fields for use with Views or display-driven templates that read the "Manage display" config.
- Enable base-field display in a distribution/install profile shipping the module's config.
- Undo a previous override cleanly, because saving the form rewrites the whole config from the submitted values.
