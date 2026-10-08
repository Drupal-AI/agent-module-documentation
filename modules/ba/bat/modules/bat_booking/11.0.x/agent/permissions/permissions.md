# BAT Booking — permissions

Static (`bat_booking.permissions.yml`):

| Permission | Restricted | Gates |
|---|---|---|
| `administer bat_booking_bundle entities` | no | Add/edit booking bundles and their fields. |
| `book units` | no | Access the booking page/flow (make reservations). |

Dynamic (`BookingPermissions::permissions` → `bat_entity_access_permissions('bat_booking')`): the
standard BAT scheme for `bat_booking` — `bypass bat_booking entities access` *(restricted)*,
`create bat_booking entities`, `view own/any`, `update own/any`, `delete own/any` (`any` variants
restricted), plus the per-`bat_booking_bundle`-bundle set. See base `agent/api/framework.md`.
