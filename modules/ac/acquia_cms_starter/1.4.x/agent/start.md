<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_starter — agent index

Part of the **Acquia CMS** distribution (Acquia's Drupal distro). Contains the example content for demonstration. Version — see
`acquia_cms_starter`'s release. Core `^10.3 || ^11`. Depends on: `acquia_cms_article:acquia_cms_article`, `acquia_cms_document:acquia_cms_document`, `acquia_cms_event:acquia_cms_event`, `acquia_cms_page:acquia_cms_page`, `acquia_cms_search:acquia_cms_search`, `acquia_cms_video:acquia_cms_video`, `default_content:default_content`. Submodules: acquia_cms_site_studio_content.

**Distribution configuration/glue, not a standalone feature.** Right on an Acquia CMS site; a strong
set of assumptions elsewhere. Designed to work with `acquia_cms_common` and the rest of the family.
**Needs a configured Search API index (Solr in the full distribution) — will not enable without it.**