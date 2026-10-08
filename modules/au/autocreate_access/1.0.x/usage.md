Autocreate Access makes entity-reference autocomplete widgets check the current user's entity-create access before offering the inline "create new" (autocreate) option.

---

Drupal's entity-reference autocomplete widget can create referenced entities on the fly ("Create referenced entities if they don't already exist"), most commonly to add taxonomy terms via a tags-style widget. In core this autocreate ability is offered whenever the field allows it, without checking whether the acting user actually holds the create permission for the target entity type/bundle (core issue #3372919). Autocreate Access adds a per-field, opt-in "Respect access" checkbox: when enabled, the module checks the current user's `createAccess()` on the target entity type during widget build and, if the user lacks create access, strips the `#autocreate` property so no new entity can be created through that widget. It ships no permissions, routes, services, or plugins — only three form/field hooks in `autocreate_access.module` plus a third-party-settings config-schema entry. The behavior is a strict tightening of access (fail-closed): fields are unaffected until an editor explicitly ticks the box on the field's edit form.

---

- Let editors with a "create term" permission add taxonomy terms inline via a tags widget, while blocking authors who lack that permission.
- Restrict which roles can coin new referenced entities on the fly through an entity-reference autocomplete field.
- Close the gap where core offers inline term/entity creation to users without the corresponding create permission.
- Enable "Respect access" per field on the field-config edit form, below the "Create referenced entities if they don't already exist" checkbox.
- Keep a public-facing content form's tags field usable for browsing/selecting existing terms while denying creation of new ones.
- Apply create-access checks to any entity_reference field whose autocomplete widget has autocreate turned on (terms, nodes, users, custom entities, etc.).
- Differentiate editorial roles: reviewers may create vocabulary terms, contributors may only reference existing ones.
- Prevent taxonomy sprawl from low-privilege users typing arbitrary new tags.
- Enforce bundle-specific create access, since the check passes the autocreate target bundle to `createAccess()`.
- Ensure the create-access check is evaluated against the current user rather than the node owner (which core's autocreate uid usually points at).
- Add controlled inline entity creation to moderation/editorial workflows without granting broad admin rights.
- Use with the "default" (core) entity-reference selection handler, which is required for the autocreate option to appear.
- Leave fields untouched by default; opt in only the specific fields where inline creation should be gated.
- Combine with role-based create permissions to build tiered content-authoring experiences.
- Rely on the setting being stored as a field third-party setting (`autocreate_access.enabled`), exported cleanly in configuration.
- Have the module auto-remove its own field dependency and the stored value when "Respect access" is unticked, keeping config tidy.
- Preserve config-sync behavior: the presave cleanup is skipped while configuration is syncing/importing.
- Provide correct render cacheability by attaching the access result's cache metadata to the widget element.
- Gate inline creation on complex entity-reference fields (e.g. paragraphs-style references) that use the autocomplete widget with autocreate.
- Solve the common "tags field lets anyone make new terms" complaint on multi-author sites.
