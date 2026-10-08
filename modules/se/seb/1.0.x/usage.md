<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Scheduled Entity Block (seb) provides a derivative block for every content entity type so an entity can be rendered as a block only during a configured time window.

---

The problem it solves is time-limited content placement: showing a banner node for one week, a promo every Wednesday, or a notice between two dates, without writing custom visibility code. The module derives one block plugin per entity type that has a view builder (`src/Plugin/Derivative/EntityBlock.php`); the block form lets an editor pick the target entity via autocomplete, choose a view mode, and set a schedule of type daily, week days, weekend days, between dates, or a custom per-weekday time table.

At render time `EntityBlock::build()` calls `isValidNow()` to compare the current time against the stored schedule and returns an empty render array when out of window. Access is delegated to the entity: `blockAccess()` returns allowed only when the target entity's own `view` access passes, and cache metadata (contexts, tags, max-age) is merged from the entity. Configuration lives entirely in the block instance placed through the normal Block Layout UI.
---
- Install the module and place a "Scheduled Entity block" from Block Layout.
- Pick the content entity (node, media, etc.) to render inside the block via autocomplete.
- Choose the view mode the selected entity renders in.
- Show a banner node in a region for a single week using the between-dates schedule.
- Display a block every weekday with the "Week days" schedule type.
- Display a block only on weekends with the "Weekend days" schedule type.
- Show content every day within a start/end time using the "Daily" type.
- Build a custom per-weekday timetable with independent start/end times.
- Set the daily start and end time window during which the block is visible.
- Restrict a promo entity to a start and end date/time range.
- Rely on the entity's own view access so unpublished content stays hidden.
- Reuse an existing content entity as a block without cloning content.
- Combine several scheduled blocks in one region for rotating content.
- Let cache tags from the referenced entity invalidate the block automatically.
- Hide the block automatically once its schedule window ends.
- Place the same entity in different regions with different schedules.
