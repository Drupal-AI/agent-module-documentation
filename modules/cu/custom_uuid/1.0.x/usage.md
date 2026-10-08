<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom UUID

Lets editors set an explicit UUID on newly created custom blocks and media, which is handy when those entities are referenced by UUID from configuration (so the UUID stays stable across environments).

- Adds a `custom_uuid` textfield to block_content and media add forms.
- Leave it blank to keep Drupal's auto-generated UUID.
- Validates format and enforces uniqueness before saving.

---

## Installation & configuration

- Depends on core **media** and **block_content**; enable it.
- No settings form and no permissions of its own — it rides on existing create permissions.
- Only users who can already create blocks/media see the field.
- The field appears with weight -10 near the top of the add form.
- Applies to all block_content and media bundles.
- Works on the *add* forms (`block_content_<type>_form`, `media_<type>_add_form`).

---

## Usage & behaviour / security

- On submit, a provided value is checked for uniqueness with a parameterised `select()` query against `block_content`/`media`.
- If the UUID already exists, validation fails with "Provided UUID is already present".
- Format is validated with `\Drupal\Component\Uuid\Uuid::isValid()`; invalid strings are rejected.
- A valid, unique value is written to the form's `uuid` value so the entity is created with it.
- The uniqueness query uses `->condition('b.uuid', $uuid)` with a placeholder — **no SQL injection**.
- Setting a UUID is not an access-control mechanism here; the module never uses UUIDs to gate access.
- Only editors with create permission can set a UUID, so the attack surface is limited to trusted content creators.
- Useful for keeping block/media references in exported config pointing at the same entity across sites.
- Combine with config that references entities by UUID (e.g. Layout Builder, block placement).
- No routes, services, or external calls.
- The two validators are `custom_uuid_validate_uuid_exits_block_content` and `..._media`.
- Media form detection matches `media` in the form id then the exact `media_<type>_add_form`.
- Block form detection matches `block_content` in the form id then `block_content_<type>_form`.
- Uninstall simply removes the extra field from the forms.
- Read: `custom_uuid.module`.
