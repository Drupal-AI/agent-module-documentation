Entity Repeat generates recurring copies of an entity from one base entity plus a recurrence pattern on a Date Recur field, cloning the entity once per occurrence.

---

Entity Repeat turns a single entity carrying a recurring-date (`date_recur`) field into many real entities — one per generated occurrence. It ships an alternate field widget ("Entity Repeat widget") for `date_recur` fields, extending Date Recur Modular's alpha widget and adding a "Replicate this entity for each of the generated dates" checkbox. When a permitted user ticks that box and saves, an event subscriber reads the recurrence occurrences from the Date Recur helper, drops the first (the original), and uses the Replicate module to clone the entity for each remaining occurrence, injecting each occurrence's start/end date into the clone and clearing its recurrence rule so clones do not themselves repeat. Cloning runs through Drupal's Batch API and each new entity's UUID is tracked in a per-entity key/value store. Access is governed by dynamic per-bundle permissions ("repeat own …" / "repeat any …") generated for every bundle that has a `date_recur` field. An optional `entity_repeat_group` submodule adds the generated clones to the same Group (contrib Group module) as the original. It depends on Date Recur, Date Recur Modular and Replicate, provides no settings form, no routes and no config schema.

---

- Generate recurring event nodes (e.g. a weekly meetup) from a single base event.
- Turn one class/session entity into a term-long series of sessions.
- Create repeated appointment or booking entities on a fixed schedule.
- Produce "every second Tuesday" style recurring content instances.
- Spin up a fixed number of occurrences using an occurrence-count limit.
- Spin up occurrences up to a specific end date.
- Clone all fields of a base entity into each occurrence via Replicate.
- Keep each generated instance editable independently after creation.
- Restrict who can generate repeats per content type with the "repeat own" permission.
- Allow trusted editors to repeat any author's content with the "repeat any" permission.
- Add a recurrence UI to any entity type that supports a Date Recur field (nodes, custom entities, etc.).
- Generate large series in the background using the Batch API progress screen.
- Automatically assign generated instances to the original entity's Group (with `entity_repeat_group`).
- Alter generated clones before save via `hook_entity_repeat_create_entity_alter()` (e.g. adjust titles per date).
- Alter or inspect the whole occurrence set before generation via `hook_entity_repeat_generate_alter()`.
- Build recurring publication schedules where each date becomes its own node.
- Model recurring shifts or rosters as individual entities.
- Create seasonal or campaign content that repeats on a defined cadence.
- Replace manual copy-paste duplication of dated content.
- Track which entities were generated from a given original via the key/value replication log.
- Migrate an "Entity Recur"-style recurring workflow onto Date Recur + Replicate.
- Avoid runaway series by design — the widget removes the "infinite" recurrence option.
