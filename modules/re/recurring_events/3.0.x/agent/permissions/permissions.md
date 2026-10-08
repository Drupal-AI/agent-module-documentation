# Recurring Events — permissions

Source: `recurring_events.permissions.yml`. Enforced by `EventSeriesAccessControlHandler` /
`EventInstanceAccessControlHandler`.

## EventSeries
`add eventseries entity`, `view eventseries entity`, `view unpublished eventseries entity`,
`edit eventseries entity`, `edit own eventseries entity`, `delete eventseries entity`,
`delete own eventseries entity`, `clone eventseries entity`, `view all eventseries revisions`,
`revert all eventseries revisions`, `access eventseries overview`.
- `administer eventseries entity` — **restrict access: true** (change the entity type).
- `administer eventseries` — **restrict access: true** (promote, change ownership, edit revisions).
- `administer eventseries types` — **restrict access: true**.

## EventInstance
`view eventinstance entity`, `view unpublished eventinstance entity`, `edit eventinstance entity`,
`edit own eventinstance entity`, `delete eventinstance entity`, `delete own eventinstance entity`,
`clone eventinstance entity`, `view all eventinstance revisions`, `revert all eventinstance revisions`,
`access eventinstance overview`.
- `administer eventinstance entity` — **restrict access: true**.
- `administer eventinstance types` — **restrict access: true**.

## Cleanup
- `administer orphaned events entities` — **restrict access: true** (delete orphaned instances/registrants
  at *Structure → Events → Orphaned*).

Notes: the granular per-entity view/edit/delete/clone permissions are the normal, grantable ones for
building editor roles; everything marked `restrict access: true` is trusted-admin only. No permission
here crosses a trust boundary beyond ordinary content administration.
