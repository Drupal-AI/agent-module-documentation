UUID Extra makes an entity's normally-hidden `uuid` base field display-configurable, and ships a read-only UUID field widget and a UUID field formatter so the UUID can be shown on entity edit forms and rendered output.

---

Core gives every content entity a `uuid` base field but keeps it out of the Manage form display / Manage display UIs, so you can never surface it without code. UUID Extra fixes that with two small hooks and two plugins. `hook_entity_base_field_info_alter()` finds each entity type's UUID key field and calls `setDisplayConfigurable('view', TRUE)` and `setDisplayConfigurable('form', TRUE)` on it, which makes the field appear as a configurable row on both the *Manage form display* and *Manage display* pages. `hook_form_alter()` sets `$form['uuid']['#access'] = TRUE` whenever the active form display has a `uuid` component, so the widget actually renders on the edit form. The module provides a `uuid` **field widget** (a disabled/read-only textfield showing the current UUID — you cannot edit it) and a `uuid` **field formatter** (prints the raw UUID string as markup), both registered for the `uuid` field type. There is no settings form, permission, config, or Drush command; you use it entirely through the standard display configuration UIs (or by setting a `uuid` component on an `entity_form_display` / `entity_view_display` config entity).

---

- Show a node's UUID on its edit form as a read-only field so editors can copy it.
- Render an entity's UUID on its full/teaser display for reference or debugging.
- Expose the UUID on a content type's Manage form display without writing a custom module.
- Display the UUID of users, taxonomy terms, media, or any content entity that has a `uuid` key.
- Give integrators a visible, copyable UUID when wiring up decoupled/front-end consumers.
- Surface the UUID for support staff who need to reference a specific entity across environments.
- Add the UUID column to an entity's rendered output for migration/QA verification.
- Let editors confirm the stable UUID that survives across content deployments (default_content, etc.).
- Provide a read-only UUID widget so the value is shown but can never be accidentally changed.
- Format the UUID as plain text via the `uuid` field formatter in a view mode.
- Include the UUID in a custom view mode used by an API-style rendering.
- Help developers debug entity references by seeing the UUID directly on the page.
- Expose the UUID on the user profile edit form for account-linking scenarios.
- Turn the hidden `uuid` base field into a manageable display row via `setDisplayConfigurable`.
- Configure UUID visibility per bundle and per view mode using the normal display UI.
- Show UUIDs on entities being prepared for content staging or synchronization.
- Give content authors visibility into the identifier used by external systems.
- Add UUID display through exported config (`core.entity_view_display.*` / `core.entity_form_display.*`).
- Provide a consistent way to reveal UUIDs across many entity types from one module.
- Reference the UUID when writing content that must be linked by a stable, non-numeric ID.
