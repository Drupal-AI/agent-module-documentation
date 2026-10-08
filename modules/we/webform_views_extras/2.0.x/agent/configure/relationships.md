<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure webform submission relationships

## Create a relationship (UI)

1. Go to **Structure › Webform submission relationships**
   (`/admin/structure/webform_submission_relationships`) — permission `administer site configuration`.
2. Click **Add**, choose the **content entity type** the submissions were submitted from
   (node, user, taxonomy_term, a custom entity, …). Only types that have a webform-reference field
   and aren't already configured are offered.
3. Save. This creates a `webform_submission_relationships` config entity storing
   `content_entity_type_id`.

## What it wires up

- **Base field:** `hook_entity_base_field_info()` adds `entity_id_<entity_type>` (string) to the
  `webform_submission` entity for each content entity type. On module install and on every submission
  save (`hook_entity_presave()`), the field is populated from the submission's core `entity_type` /
  `entity_id` "submitted from" reference.
- **Views data:** `webform_views_extras_views_data_alter()` (in `.views.inc`), for each configured
  relationship, adds to `webform_submission`:
  - a `field`, `filter` (`string`), `argument` (`string`), `sort` (`standard`) on
    `entity_id_<type>`;
  - a **relationship** *"Submitted to: &lt;entity_type&gt; (Webform Views Extras)"* joining
    `entity_id_<type>` → the target entity's data table / id key (with an `extra` condition
    `entity_type = <type>`).

## Build a view

Create a view of **Webform submissions** (via Webform Views), then:
- add the *"Submitted to: &lt;type&gt;"* relationship, and
- add fields from the joined entity, or use the `entity_id_<type>` field/filter/argument directly
  (e.g. a contextual filter on a user page to list that user's submissions).

## Config schema

`config/schema/webform_submission_relationships.schema.yml` provides the schema for the config
entity. The entity form disables changing the entity type on edit (only add/delete choose it).

No Drush commands, no module-specific permissions, no plugin types.
