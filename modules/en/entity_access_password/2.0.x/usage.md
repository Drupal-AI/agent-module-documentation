Entity Access Password protects fieldable entities (nodes, terms, etc.) behind a password by adding a `entity_access_password_password` field type; when an entity is marked protected, configured view modes render a password form instead of the entity's content until the correct password is entered.

---

You add a "Password protection" field to a bundle, then per-field enable one or more check scopes: per-entity password (stored on the entity), a bundle-wide password (stored in field settings), and/or a site-wide global password (stored hashed in `entity_access_password.settings`). On the field you choose which **view modes** the protection applies to. Protection is enforced at the **display layer**: `hook_entity_view_mode_alter` swaps a protected entity's view mode to the module's `password_protected` view mode (which renders the password form via the `entity_access_password_form` field formatter), and a title-masking preprocess/token replaces the entity label with "Protected entity" when `show_title` is off. Passwords are hashed and verified with Drupal core's `PasswordInterface` (phpass, timing-safe), and the password form reuses core's user-login flood control (`user.flood` limits). Once a correct password is submitted, "access granted" is recorded through a pluggable **access storage** backend — enable the `entity_access_password_session_backend` submodule (per-session, works for anonymous users) or `entity_access_password_user_data_backend` (persisted per user, authenticated only). A `hook_file_download` implementation extends the gate to **private-scheme files** attached to protected entities. Users with the `bypass_password_protection` permission always see content. The module is extensible via three tagged-service collections (password validators, access storages, access checkers). Note the gate is display-only: it does not implement entity-access/node grants, so the underlying entity data remains reachable via JSON:API/REST, Views raw fields, search indexing, and any non-protected view mode.

---

- Password-protect individual nodes so only visitors who know the password can read them.
- Set one bundle-wide password so every entity of a content type shares the same password.
- Set a single global site password that unlocks any globally-protected entity.
- Let an editor mark a specific article as protected via the field widget while leaving others open.
- Protect only the `full` view mode while leaving the `teaser` visible (or vice versa) per field settings.
- Hide the protected entity's title (show "Protected entity") until the password is entered.
- Show an optional hint above the password form to help authorized users remember the password.
- Gate downloads of private-scheme files attached to a protected node behind the same password.
- Store unlocked access in the visitor's session so anonymous users can browse protected pages after unlocking.
- Persist unlocked access per authenticated user (via the user-data backend) across sessions/devices.
- Grant trusted roles the `bypass_password_protection` permission so they never see the password form.
- Auto-generate a random password of a configurable length for editors via the widget.
- Add a "Password protected" boolean formatter to display whether an entity is protected.
- Rate-limit password guessing using core's existing flood limits (per IP and per user).
- Use the `[entity:protected-label]` token (with Token/Metatag) to output a masked label in metatags.
- Migrate password-protected nodes from Drupal 7 using the bundled migration example plugins.
- Provide per-user manual access grants from an admin form (user-data backend) without the user entering a password.
- Apply per-bundle protection to taxonomy terms, media, or any fieldable entity type, not just nodes.
- Combine per-entity, per-bundle, and global checks on one field so any of the three passwords unlocks it.
- Build a custom access-storage backend (e.g. cookie- or JWT-based) by adding a tagged `entity_access_password_access_storage` service.
- Add a custom password validator (e.g. per-role passwords) via a tagged `entity_access_password_password_validator` service.
- Add a custom access checker (e.g. IP allowlist bypass) via a tagged `entity_access_password_access_checker` service.
- React to the file-usage entity list event to change which entities gate a shared private file.
- Cache protected renders correctly per-user using the `entity_access_password_entity_is_protected` cache context.
