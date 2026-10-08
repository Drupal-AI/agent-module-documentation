<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Formats — permissions

Declared in `better_formats.permissions.yml` (two static) plus a dynamic callback
`BetterFormatsPermissions::permissions()`.

| Permission | Gates |
|---|---|
| `hide format tips` | Hides the text-format **guidelines** (the "About text formats" tips block) on the field for users with this permission. |
| `hide more format tips link` | Hides the "More information about text formats" **link** under the field. |
| `hide format selection for <entity_type>` | Hides the whole **format selector** for that entity type's fields. One permission is generated per fieldable entity type (any entity type with a `field_ui_base_route`), e.g. `hide format selection for node`, `hide format selection for comment`, `hide format selection for user`. |

Notes:

- These are applied in `better_formats_filter_process_format()` at form-render time. They
  are **skipped for users with `administer filters`** — admins always keep the full selector,
  tips, and link.
- "Hide format selection for X" only hides the UI; the field is still saved with its current
  format. If used together with per-field allowed-formats that leave a single format, the
  effect is a clean single-format editing experience with no selector.
- The dynamic list is produced by iterating `entityTypeManager()->getDefinitions()` and
  emitting one permission for each type that has a `field_ui_base_route`.
