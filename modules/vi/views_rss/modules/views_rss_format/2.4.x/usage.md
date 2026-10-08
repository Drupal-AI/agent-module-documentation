<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views RSS: Format supplies the `template_preprocess_views_view_row_rss()` implementation that turns each RSS item's raw element/attribute arrays into the title, link, description, and `item_elements` (with real `Attribute` objects) variables the row Twig template expects.

---

This is a small, purely mechanical submodule: one function, `views_rss_format_preprocess_views_view_row_rss()`, implementing `hook_preprocess_HOOK()` for the `views_view_row_rss` theme hook that the parent module's row plugin (`views_rss_fields`) renders through. It takes the `\stdClass` `$item` object the row plugin built (`title`, `link`, `description`, and an `elements` array of every other configured RSS element), strips dangerous protocols from the `link`, and — critically — converts each element's raw `attributes` array (e.g. an `<enclosure>`'s `url`/`length`/`type`, or a `<media:content>`'s `bitrate`/`width`/`height`) into a `Drupal\Core\Template\Attribute` object so `views-view-row-rss.html.twig` can print them as real XML attributes instead of a PHP array being cast to a string. It has no config, no UI, and no elements of its own to register — every other submodule's elements that carry `attributes` (enclosure, media:content, media:thumbnail, media:category, cloud, guid's isPermaLink) depend on this preprocessing step to render correctly.

---

- Enable correct `<enclosure url="..." length="..." type="...">` attribute output from `views_rss_core`.
- Enable correct `<media:content url="..." type="..." fileSize="...">` attribute output from `views_rss_media`.
- Enable correct `<media:thumbnail url="..." width="..." height="...">` attribute output.
- Enable correct `<media:category scheme="..." label="...">` attribute output.
- Enable correct `<guid isPermaLink="true">` attribute output from `views_rss_core`.
- Enable correct `<cloud domain="..." port="..." protocol="...">` attribute output.
- Enable framerate/bitrate/resolution/duration attributes added by `views_rss_media_getid3`.
- Strip dangerous protocols (e.g. `javascript:`) from an item's `<link>` value before output.
- Ensure an item's `<description>` is passed through as a proper renderable value, not double-rendered.
- Keep the row Twig template (`views-view-row-rss.html.twig`) decoupled from raw PHP attribute arrays.
- Diagnose "attributes not appearing on my RSS element" issues by checking this module is enabled.
- Provide a stable `item_elements` variable structure any custom row template override can rely on.
- Support any future/custom `views_rss_*` extension module whose elements carry `attributes`.
- Prevent a raw PHP array from leaking into feed output as an unformatted string.
- Underpin every attribute-bearing element across the core, media, and getID3 submodules at once.
