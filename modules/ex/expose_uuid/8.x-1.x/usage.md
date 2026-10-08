<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an editable "UUID" field to entity edit forms so admins holding the 'edit uuid' permission can view and set an entity's UUID.

---

Expose UUID is a tiny, single-hook module (package Admin) with no routes, no services, no config and no dependencies beyond Drupal core. It implements `hook_form_alter` (`expose_uuid_form_alter` in `expose_uuid.module`): on any form whose form object is an `EntityFormInterface`, and only when the current user has the `edit uuid` permission, it appends a required 36-character text field pre-filled with the entity's current `uuid()`. A validate handler (`expose_uuid_form_validate`) rejects anything that fails `Drupal\Component\Uuid\Uuid::isValid()`. Its main purpose is configuration-sync hygiene: after re-creating content such as custom blocks by hand across environments, you can realign their UUIDs so exported/imported configuration that references them by UUID resolves instead of showing "missing" references. The permission also permits changing a UUID, which can break existing references, so it is meant for trusted administrators only.

---

- View the UUID of any content or config entity while editing it, without going to the database.
- Copy an entity's UUID for use in configuration, migrations, or API calls.
- Align a custom block's UUID across dev/stage/prod so imported configuration references resolve.
- Fix "missing block" / missing-reference errors after a manual re-create of a placed block.
- Give a trusted admin the ability to set a specific UUID on an entity created by hand.
- Keep UUIDs consistent for entities referenced by UUID in exported config.
- Support configuration deployment workflows where UUIDs must match between sites.
- Look up an entity's UUID for a REST/JSON:API or web-service integration that addresses entities by UUID.
- Grant a content architect the `edit uuid` permission to manage UUIDs during a site build.
- Confirm two entities on different environments share the same UUID.
- Restore a lost or mismatched UUID after a botched migration or content rebuild.
- Debug UUID-based entity references during development.
- Provide the UUID field on nodes, taxonomy terms, users, blocks, menus, and other entity forms.
- Ensure a pasted UUID is well-formed before saving, thanks to the built-in `Uuid::isValid()` check.
- Add UUID visibility to edit forms site-wide with a single module enable and one permission grant.
- Limit UUID editing to specific roles by controlling who receives the `edit uuid` permission.
- Reproduce a production entity's UUID in a local environment for realistic testing.
- Standardise UUIDs for shared content blocks distributed with an install profile or feature.
