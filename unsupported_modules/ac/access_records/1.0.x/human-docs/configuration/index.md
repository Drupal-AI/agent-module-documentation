# Configuration

Setting up Access Records is a sequence: create a record **type** bound to the
content you want to govern, add the **fields** that drive matching, grant the
**permissions**, then create the individual **records**.

## 1. Create an access record type

1. Make sure the contrib **Entity API** module is installed (it powers the
   query-access enforcement) and **Field UI** is on.
2. Go to **Structure → Access record types** (`/admin/structure/access-record`)
   and add a type.
3. Choose the **target entity type** the records will govern.

Two fields are created automatically: a **subject ID** field (usually the user
ID) and a **target ID** field (the target entity's ID). Both are optional and can
be removed if your matching is based on other fields.

## 2. Add matching fields (Field UI)

Add fields to the record type via Field UI. The **field machine name** decides how
a field participates in matching:

- **Unprefixed** (e.g. `uid`, `field_uid`) — matched on *both* the subject and
  target sides.
- **`subject_` / `field_subject_`** — matched on the subject side only.
- **`target_` / `field_target_`** — matched on the target side only.
- **`ar_` / `field_ar_`** — descriptive only; never used for matching.

A subject may act on a target when they share **at least one** of the matched
values.

## 3. Grant permissions

At **People → Permissions** (`/admin/people/permissions`), grant the permissions
your roles need. All are marked as restricted, so grant carefully:

- Per-type and generic **view / create / update / delete [own] access_record** —
  who may work with the records themselves.
- **Access access_record overview** — access to the subject/target overview pages
  under `/admin/content/access-record/*`.
- **Administer access_record** and **Administer access_record type** — full
  administrative control.

## 4. Create records

Create records that link subjects to targets. A record *is* the reason a subject
may act on a target — access follows from a matching record existing.

- Records support **revisions**, so you can track changes and revert.
- Records are **translatable** where languages are enabled.
- Views integration is bundled (relationships, field handlers and an access
  plugin), and **Grant / Revoke** bulk actions let you create or delete records
  for selected entities from a Views listing.

## Route-level gating (for developers)

To require that a user hold a matching record before a route is served, add a
requirement to the route:

- `_access_record: '<type_id>'` — require a matching record of that type.
- Combine several types with **`,`** for AND, or **`+`** for OR.
- `_access_operation: 'update'` (default `view`) — check a non-view operation.

Users with an admin role always pass this check.

## Fail-closed behaviour

Enforcement is deny-by-default. When a user has no matching record, the
query-access layer adds an always-false condition so no target rows are returned.
If a record type's configuration is incomplete or invalid, the module blocks
access on that target entity type and logs an alert — the failure stays closed
until you fix it.
