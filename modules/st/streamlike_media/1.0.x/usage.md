<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Streamlike Media provides a "Streamlike Media" field type that stores a Streamlike media ID and renders the corresponding Streamlike video player, with a matching field widget and formatter.
---
The field type (`streamlike_media_field`) stores a single string value (the media ID) and carries a per-field `cdn_default` setting (default `cdn.streamlike.com`). The widget (`streamlike_media_field_widget`) provides the input for entering a media ID, and the formatter (`streamlike_media_field_formatter`) outputs the embed markup / player pointing at the configured Streamlike CDN. It depends only on core `field`, has no routes, permissions, services, or admin form — configuration is done through the standard Field UI (Manage fields / form display / display) on any fieldable entity.

Because everything is field-level and rendered from an admin/editor-entered media ID, there is no anonymous mutation surface and no external server-side fetch by the module itself; the browser loads the Streamlike player from the CDN. Setup: add a Streamlike Media field to a content type, set the CDN if it differs from the default, then editors paste a Streamlike media ID per entity.
---
- Add a Streamlike Media field to a content type via Field UI.
- Set the field's `cdn_default` (default `cdn.streamlike.com`).
- Enter a Streamlike media ID on an entity edit form.
- Render a Streamlike video player from a stored media ID.
- Configure the widget on the entity's form display.
- Configure the formatter on the entity's display.
- Attach Streamlike videos to nodes, terms, or users.
- Point a field at an alternate Streamlike CDN host.
- Store one media ID per field item.
- Reuse the same field across multiple bundles.
- Combine with other media fields on a content type.
- Display the player in a teaser vs full view mode.
- Migrate legacy video IDs into the field.
- Validate that a media ID is populated before publish.
- Theme the formatter output in a custom template.
- Use the field in Views as a rendered field.
- Bulk-populate media IDs via content import.
- Keep video hosting on Streamlike while embedding in Drupal.
