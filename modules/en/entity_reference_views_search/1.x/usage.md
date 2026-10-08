<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Views Search provides an alternative entity-reference widget that surfaces a Views listing as the picker, so editors can search/browse candidate entities in a full View and click one to select it.
---
The widget (`EntityReferenceViewsFormSearch`) embeds a configured View next to the reference input; a Views field plugin (`EntityFormViewsSearchSelectField`) renders a "select" control per row, and an AJAX controller (`/entity-reference-views-search/ajax`) loads the chosen entity, renders it in the `default` view mode as a preview, and writes the entity ID back into the field input via a JS command. Global settings at `/admin/config/entity-reference-views-search` define which field types the widget may attach to (default: string, email, entity_reference).

Security note to be aware of when deploying: the AJAX route is gated only by the `access content` permission and its controller loads any `entity_type` + `entity_id` taken from the query string and renders that entity's default view mode without an explicit entity-access (`->access('view')`) check, so a user could preview entities they might not otherwise be able to view. Scope which Views/fields use the widget accordingly, and keep sensitive entity types off the enabled field types.
---
- Let editors pick a referenced entity from a browsable View
- Search candidate entities with Views exposed filters, then select
- Show an AJAX preview of the chosen entity inline
- Replace a plain autocomplete with a richer listing UI
- Attach the widget to string, email, or entity_reference fields
- Configure allowed field types at the settings page
- Present curated candidate lists via a custom View
- Add a "select" button column to a View for reference picking
- Populate the reference field ID from a row click
- Preview the selected entity's default view mode
- Build a filterable reference picker for large content sets
- Use Views sorting/pagination to find the right entity
- Limit selectable entities via the View's own filters
- Give editors context (fields/thumbnails) before selecting
- Swap between multiple picker Views per field
- Improve reference UX on data-entry-heavy forms
