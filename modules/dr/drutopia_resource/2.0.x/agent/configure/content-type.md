<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Resource content type

Enabling `drutopia_resource` installs the **Resource** node type and everything around it. It is a Features bundle — all behavior is configuration.

## Fields
- `field_resource_file` — file (e.g. PDF) download
- `field_resource_link` — external URL
- `field_resource_video` — embedded video (video_embed_field)
- `field_resource_type` — reference to the `resource_type` vocabulary
- `field_body_paragraph` / `body` / `field_summary` — content
- `field_image` / `field_media_image` — imagery (focal_point)
- `field_tags`, `field_topics` — categorization
- `field_meta_tags` — SEO metatags

## Display & search
- View displays: `default`, `full`, `teaser`, `card`, `simple_card`, `search_index`.
- Search API index `resource` + facets `resource_topics` and `resource_type`.
- `views.view.resource` provides the listing; `block_visibility_groups` scopes a resource-listing block.
- `pathauto.pattern.node_resource` and `rabbit_hole.behavior_settings.node_type_resource` handle URLs/behavior.

## Notes
The module supplies configuration only (no PHP/routes/permissions). Grant the usual node permissions for the `resource` bundle to control who can create/edit resources; access is standard core node access.
