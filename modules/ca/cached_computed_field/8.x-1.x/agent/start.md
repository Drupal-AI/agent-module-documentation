<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cached Computed Field (cached_computed_field) — agent index

**Field types that persist an expensive computed value (plus an `expires` timestamp) in field storage and refresh it in the background via cron, a queue, and a refresh event.**

- **Version:** 8.x-1.x (8.x-1.0-beta9) · **Core:** ^8.9 || ^9.1 || ^10 || ^11
- **Route:** `cached_computed_field.settings` → `/admin/config/cached_computed_field/settings` (perm: *access administration pages*, admin route).
- **Service:** `cached_computed_field.manager` (`CachedComputedFieldManager`) — `populateQueue()`, `processQueue()`, `getExpiredItems()`, `getQueue()`.
- **Field types:** `cached_computed_{string,string_long,text,text_long,integer,decimal,float,boolean}` (`Plugin/Field/FieldType/*`, shared `CachedComputedItemTrait`).
- **Refresh flow:** `hook_cron` → manager processes/repopulates queue → dispatches `RefreshExpiredFieldsEvent` per `ExpiredItem` → your subscriber recomputes and calls `updateFieldValue()`.
- **Extend:** subscribe by extending `RefreshExpiredFieldsSubscriberBase` (helpers: `getEntity`, `getFieldDefinition`, `fieldNeedsRefresh`, `updateFieldValue`).
- **Security:** single admin settings route, permission-gated; no anonymous or mutating endpoints; no external HTTP in the module itself.

See [extend/subscriber.md](extend/subscriber.md)
