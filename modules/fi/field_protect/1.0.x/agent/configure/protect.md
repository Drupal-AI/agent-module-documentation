<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Field Protect

## Protect a field
1. Go to **Manage form display** for the entity/bundle.
2. Click the gear on the widget you want to guard.
3. Tick **Field Protect: Protect from accidental changes** and enter a warning **message** (shown on unlock; stored as `field_protect.enabled` / `message` third-party settings on the widget).
4. Update and save the form display.

On the entity's **edit** form (creation forms are exempt) the widget renders locked with an "Unlock field" button; the JS behaviour (`field_protect/ui` library) reveals the input after the editor confirms.

## Remembering unlocks
- Editors with the `remember field unlock` permission get a per-user hash sent to JS; a POST to `/field-protect/remember` records it in state (`field_protect.remembered`) so that field stays unlocked for them.
- Admins can clear every remembered unlock at `/admin/config/content/field-protect` via **Forget**.

## Important limitation
Field Protect only alters the widget UI. It does **not** restrict who may view or save the field server-side. For genuine field-level access control use a module that implements `hook_entity_field_access` (e.g. Field Permissions).
