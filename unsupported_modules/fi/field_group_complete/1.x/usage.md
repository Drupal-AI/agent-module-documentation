<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Group Complete gives editors a real-time completion indicator on Field Group leaf groups (tabs, fieldsets, details) in entity forms: a badge that flips to "Complete" once every required field inside the group is filled.
---
It layers JavaScript over the field_group module: as the editor types, the scripts evaluate the required fields within each leaf group and toggle a badge and CSS classes accordingly. A settings form (`/admin/config/content/field-group-complete`, permission `administer site configuration`) controls the complete/incomplete badge text, badge visibility, and lets you add custom CSS classes applied to complete and to required groups — useful for theming or for hooking your own styles. It also handles required radio groups specially so a group with a required radio is judged correctly.

The value is editorial UX on long, multi-tab forms — editors can see at a glance which sections still need attention before saving. It is presentation/JS only: no data is changed, no routes beyond the admin settings form, and completion is computed client-side.
---
- Show a "Complete" badge on a finished form tab
- Flag incomplete field-group tabs at a glance
- Guide editors through long multi-section forms
- Mark a fieldset complete when its required fields are filled
- Customise the "Complete"/"Incomplete" badge text
- Hide or show the completion badge via settings
- Add custom CSS classes to completed groups for theming
- Add custom classes to groups containing required fields
- Correctly evaluate required radio-button groups
- Improve editor UX on content types with many tabs
- Reduce save-time validation errors by surfacing gaps early
- Theme completion states with your own styles
- Provide visual progress cues on entity edit forms
- Highlight remaining required sections before submit
- Apply to any field_group leaf (tab/fieldset/details)
- Toggle badges live as fields are completed
