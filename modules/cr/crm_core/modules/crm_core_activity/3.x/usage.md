CRM Core Activity records interactions — meetings, calls, emails and custom types — against one or more CRM Core contacts.

---

This submodule defines the `crm_core_activity` content entity and its config bundle
`crm_core_activity_type`. Each activity has a title, date, notes and a multi-valued
**Participants** field implemented with `dynamic_entity_reference`, so a single activity can point
at both Individuals and Organizations. Activity types are configurable bundles whose behaviour is
driven by an **activity-type plugin** (a `plugin_type` framework with a `generic` plugin shipped);
a type's plugin controls the activity's computed label. Permissions are generated per entity and
per bundle. Activities are listed at `/crm-core/activity`; types are managed at
`/admin/structure/crm-core/activity-types`. When a contact is deleted, `hook_entity_predelete`
removes it from every activity's participant list and deletes any activity left with no
participants.

---

- Log **meetings, phone calls, emails** and other interactions as activity records.
- Attach an activity to **multiple contacts** at once (Individuals and/or Organizations).
- Define custom **activity types** as bundles, each backed by an activity-type plugin.
- Add fields to activity types with **Field UI** (extending the base title/date/notes fields).
- Record an activity **date** (defaults to now) and free-text **notes**.
- Give each activity a computed **label** via its type plugin (`Generic` returns the title).
- Apply per-bundle **create / edit / view** permissions to activities.
- Restrict activity creation to **active** activity types only (create-access check).
- List and filter activities in Views (`ActivityViewsData`) and at `/crm-core/activity`.
- Preview an activity inside Views with the `ActivityPreview` views field plugin.
- Automatically **clean up** activities when their last participating contact is deleted.
- Cascade-delete all activities of a type when that **activity type is deleted**.
- Own activities (owner `uid` base field) for "own vs any" access decisions.
- Grant a `view crm dashboard` permission for dashboard-style integrations.
- Extend behaviour by writing custom `@ActivityTypePlugin` plugins.
- Integrate activity data into custom reports and contact timelines.
