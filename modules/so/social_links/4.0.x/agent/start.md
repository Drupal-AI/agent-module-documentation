<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Links (social_links) — agent index

Renders social **share** links as an entity pseudo-field. Version **4.0.0**, core `^9.3 || ^10`. No dependencies.

**Shape:** `hook_entity_extra_field_info` adds a `social_links` display component to every bundle; `hook_entity_view` renders it via the `social_links.factory` service (`SocialLinkFactory`). Providers keyed by name → link classes `SocialLink` / `SocialLinkPopUp`; path templates `sprintf`'d with url-encoded current URI + page title. Output themed as `item_list`.

**Defaults:** twitter, facebook, email. Extend/replace via `hook_social_links_alter()` (`social_links.api.php`); per-provider `svg` key renders an SVG sprite `<use>`.

**No** routes, permissions, config entities or admin UI — configuration is code/hook only. Share target is always the current page; no untrusted user input flows into the markup beyond the (url-encoded) request URI and title.
