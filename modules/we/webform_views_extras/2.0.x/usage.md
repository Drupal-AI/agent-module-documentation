<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Views Extras extends the Webform Views integration so that a Views relationship can join webform submissions to **any** content entity type they were submitted from — not just nodes — including users, taxonomy terms, and custom entities.

---

The module defines a `webform_submission_relationships` config entity (managed at
*Structure › Webform submission relationships*, gated by `administer site configuration`) where you
register which content entity type a webform-submission relationship should target. For every content
entity type it adds a `entity_id_<entity_type>` base field to the `webform_submission` entity via
`hook_entity_base_field_info()`, and on install / `hook_entity_presave()` it back-fills those fields
from the submission's core `entity_type` / `entity_id` "submitted from" source values. `hook_views_data_alter()`
then exposes, for each configured relationship, a Views field/filter/argument/sort plus a **relationship**
("Submitted to: &lt;entity_type&gt;") that joins `webform_submission.entity_id_<type>` to the target
entity's data table — letting you build views of submissions joined to the entity page they came from
and pull that entity's fields into the results. The add form hides entity types that already have a
relationship (and those with no webform-reference field), so each content entity type is configured at
most once. It requires the `webform`, `webform_views` and `views` modules.

---

- Show webform submissions joined to the **user** they were submitted from.
- Show submissions joined to the **taxonomy term** page they came from.
- Join submissions to a **custom content entity** (beyond node) in Views.
- Build a view of "submissions submitted to this profile" on a user page.
- Pull fields from the source entity into a submissions view via the relationship.
- Filter submissions by the source entity id for a given content entity type.
- Add the source entity id as an exposed argument (contextual filter) to a submissions view.
- Sort submissions by their originating entity.
- Report all submissions grouped by the entity they were attached to.
- Register a webform-submission relationship for each relevant content entity type.
- Prevent duplicate relationships — the add form removes already-configured entity types.
- Only offer entity types that actually have a webform reference field.
- Back-fill relationship values for existing submissions on install.
- Keep relationship values current automatically via entity presave.
- Create embedded views of submissions on non-node entity canonical pages.
- Cross-reference submissions with term-based categorization.
- Combine with Webform Views to add submission fields plus source-entity fields in one view.
- Manage relationships from a dedicated admin list under the Webform structure area.
- Delete a relationship when a content entity type no longer needs it.
- Extend submission reporting to multi-entity sites without custom code.
