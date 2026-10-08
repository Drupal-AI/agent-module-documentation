<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generic HTTP Tags Header — agent index

Trivial submodule of **Generic HTTP Purger**. Registers one Purge TagsHeader plugin,
`purge_tagsheader` (`PurgeCacheTagsHeader`), that makes Drupal emit a `Purge-Cache-Tags`
response header listing each response's cache tags, so a tag-aware proxy/CDN can invalidate by
tag. Depends only on `purge`. **No** config, form, route, permission, or Drush — enabling the
module is the entire setup.

Key facts:
- Plugin: `@PurgeTagsHeader(id = "purge_tagsheader", header_name = "Purge-Cache-Tags")`, class
  `Drupal\purge_purger_http_tagsheader\Plugin\Purge\TagsHeader\PurgeCacheTagsHeader` (extends
  `TagsHeaderBase`, empty body).
- Purge core's `purge.tagsheaders` registry + cacheable-response subscriber attach the header
  to responses; the plugin manager is `plugin.manager.purge.tagsheader`.
- There is nothing to configure — the parent module (Generic HTTP Purger) sends the actual
  purge requests; this submodule only advertises the tags on responses.
