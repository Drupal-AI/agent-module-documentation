<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Alias Display Field Override adds a per-media boolean field so an individual media entity can opt out of the parent Media Alias Display file-streaming behavior and be shown as a normal media page instead.

---

On install (`hook_install`) the submodule creates a single boolean field storage `field_override_mad_module` on the `media` entity type and attaches a `field_override_mad_module` field instance — labelled "Override Media Alias Display" — to **every existing media type**, adding a `boolean_checkbox` widget to each media bundle's form display. When the parent `media_alias_display` module handles a media view, its `DisplayController` checks whether this submodule is installed and whether the media has `field_override_mad_module` set to a truthy value; if so it renders the media normally (the standard media page) rather than streaming the file. This gives editors a checkbox on the media edit form to exclude specific items — for example a document you want to show with its metadata page instead of opening the raw file — while all other media of that bundle keep the alias-display behavior. The submodule has no configuration form, routes, permissions, services or Drush commands; its entire footprint is the one field it installs and the check the parent controller performs. Media types created **after** the submodule is enabled do not automatically get the field.

---

- Exclude a single media entity from the file-streaming behavior while keeping it for the rest.
- Show a specific document's media page (with its fields) instead of opening the file inline.
- Let an editor toggle "Override Media Alias Display" on the media edit form per item.
- Keep a "featured" media item rendering as a normal page for embedding context.
- Opt a media item out without changing the global bundle allow-list.
- Provide a per-entity escape hatch alongside the module's global kill switch.
- Temporarily surface a media entity's metadata page for review, then re-enable streaming.
- Exclude media that should show a custom view mode rather than the raw file.
- Apply the override across all media bundles from a single installed field.
- Give content teams granular control without developer involvement.
- Combine with the bundle allow-list: allow a bundle globally but exempt a few items.
- Mark a legal document to always show its landing page (disclaimers) instead of the PDF.
- Keep an audio/video media item on its player page rather than streaming the file.
- Audit which media are excluded by querying `field_override_mad_module = 1`.
- Roll out the override capability to existing media types on enable.
- Let a media item behave normally while its file is being replaced/reviewed.
- Prevent direct download of a sensitive item by forcing its media page.
- Use the checkbox as a quick per-item toggle during content migration.
- Show a gallery media item's caption/credit page instead of the image file.
- Provide predictable behavior for editors who don't manage the global settings.
