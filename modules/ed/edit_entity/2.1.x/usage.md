<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Adds a quick "Edit {entity}" button to the admin toolbar when viewing an entity's canonical page.
- Also adds a "Translate {entity}" button when translation is available for that entity.
- Saves a click by jumping straight from viewing to editing the current entity.

---

## Install & configure

- Enable the module; it works via `hook_toolbar()` with no configuration.
- Ensure the admin toolbar is enabled and the user has permission to see it.
- The button appears automatically on `entity.*.canonical` routes.

---

## Usage & behaviour

- `hook_toolbar()` inspects local tasks on the current route; on an `entity.{type}.canonical` route it derives the entity type and id.
- Before showing the Edit button it loads the entity and checks `$entity->access('update', $user)`, so the link only appears when the user actually has update access — no access bypass.
- It builds the link to `entity.{type}.edit_form`; clicking still passes through core's own route access, so the button is a shortcut, not a new access path.
- The Translate button is shown only when `content_translation_translate_access()` passes and the translation overview route exists.
- Translation-aware: it loads the current-language translation of the entity when one exists.
- Cache contexts include `url` so the toolbar item varies per page.
- No routes, permissions, services, or config are defined by the module — it is toolbar-only.
- Works for any content entity type exposing a canonical + edit_form route (nodes, taxonomy terms, users, media, custom entities).
- Because access is checked with the entity's own `access()` method, per-entity and per-field access modules are respected.
- Note a latent robustness bug: if `$entity_storage->load($entity_id)` returns null the subsequent `->access()` call would error — a stability, not a security, concern.
- Useful for editorial teams that browse the front end and frequently jump to editing.
- The button label includes the entity type label and id for clarity.
- Disabling the module removes the toolbar buttons cleanly.
- No external services or data storage are involved.
- Safe on multilingual sites due to the translation handling.
- Pair with Admin Toolbar for a fuller editorial navigation experience.
