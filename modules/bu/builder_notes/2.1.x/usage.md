<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a collapsible "Builder Notes" textarea to a set of configuration-entity edit forms so site builders can record why a field, display, content type or role was set up the way it is.

---
Via `hook_form_alter()` the module targets specific config forms — entity form/view display, field config and storage, node type, user role, image style and responsive image style — and injects a notes textarea into the form's "additional settings" group. The value is stored as a third-party setting on the config entity itself (`getThirdPartySetting('builder_notes', 'notes')`), so the note travels with the configuration in exports and deployments.

The notes are only visible to users who can already reach those admin configuration forms (Field UI and the respective admin permissions); the module adds no routes, permissions, services or public output. It is a lightweight, in-config documentation aid, not an access-controlled annotation system.
---
- Document why a field was created on its config form.
- Leave a note on an entity form display for other builders.
- Annotate a view display's configuration.
- Record rationale on a content type edit form.
- Explain a user role's purpose inline.
- Note the intent behind an image style.
- Annotate a responsive image style mapping.
- Keep build notes with the config so they export together.
- Hand off a site with in-place configuration documentation.
- Capture TODOs on a specific config entity.
- Remind future builders of gotchas on a field storage.
- Store deployment notes alongside configuration.
- Avoid a separate wiki for config-level documentation.
- Review builder intent during a config audit.
- Onboard new team members with contextual notes.
- Track why a non-obvious setting was chosen.