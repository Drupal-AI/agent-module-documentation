<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Log provides a **`log` content entity type** for recording real-world events — an inspection carried out, a delivery received, a treatment administered — as first-class, fieldable content with types (bundles), revisions, an owner, and a workflow status driven by `state_machine`.

---

The name is misleading if you expect watchdog: this is not about PHP errors, it is about the kind of record an organisation keeps. Anything with a date, a subject, a status and some fields — maintenance records, observations, activity logs — fits the shape, and building it as a bespoke entity type each time is a lot of boilerplate. Log supplies it generically: bundles ("log types", the `log_type` config entity) define fields and pick a workflow; each log carries base fields `name`, `timestamp`, `status`, `uid`, `created`, `changed`, is revisionable and translatable, and can move through workflow states (the shipped `log_default` workflow goes pending → done). Blank names are auto-generated from a per-type token pattern by `LogStorage`. It ships bulk actions (clone, reschedule, mark done, mark pending), a name-autocomplete endpoint, per-bundle entity permissions from the Entity API, and custom Views sort/field handlers that tie-break the timestamp by id. It originates in farmOS, where it models farm activities, but has no agriculture-specific dependencies. Note the narrow **`core_version_requirement: ^11.3`**: this release targets a recent Drupal 11 minor only, with no Drupal 10 support.

---

- Record inspections with dates and outcomes.
- Track maintenance activities as entities.
- Log observations against a location or asset.
- Move a record from planned to completed via the workflow.
- Define record types with their own fields and workflow.
- Auto-name records from a token pattern.
- Keep a revision history of records.
- Report on activity through Views.
- Clone a repeated record to a new date.
- Bulk-reschedule records by an absolute or relative date.
- Bulk mark records as done or pending.
- Model farm activities (farmOS).
- Record deliveries received.
- Track treatments or interventions.
- Give records a workflow state.
- Restrict who may administer record types (per-type permissions).
- Attach files or other fields to a record.
- Query records by state and date.
- Provide an auditable operational history with revisions.
- Suggest frequently used record names as you type.
- Build a custom activity register on a generic entity.
- Sort records deterministically by time then id.
