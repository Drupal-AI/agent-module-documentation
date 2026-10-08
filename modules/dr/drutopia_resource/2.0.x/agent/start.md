<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Resource (drutopia_resource) — agent index

**Configuration-only feature module installing a 'Resource' content type (file / link / embedded video) with fields, taxonomy, Search API index, facets, views and displays.**

- **Version:** 2.0.x
- **Core:** ^10.2 || ^11 || ^12
- **Package:** Drutopia (Features bundle `drutopia`)
- **Installs:** `node.type.resource`; fields incl. `field_resource_file/link/video/type`, image/media, summary, tags, topics, metatags; view displays (default, card, teaser, full, search_index, simple_card); `resource_type` vocabulary; Search API index `resource`; facets `resource_topics`, `resource_type`; `views.view.resource`; pathauto + rabbit_hole config.
- **Key deps:** node, media, taxonomy, facets, paragraphs, search_api, pathauto, video_embed_field, drutopia_core, drutopia_seo, ds, field_group, focal_point.
- **PHP/routes/permissions/services:** none.

**Security:** Pure site-building config, no runtime code path; Resource node access is governed by core node access and site-granted permissions. No attack surface introduced by this module. See [configure/content-type.md](configure/content-type.md).
