<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Paragraphs supplies the shared paragraph components LocalGov Drupal sites build pages from — Text, Image, Link, Numbered text and a rich Contact block — shipped as installed configuration, plus submodules for layout sections, views embedding, homepage components and subsite page building.

---

Rather than each LocalGov site inventing its own component set, this module ships the canonical one as `paragraphs_type` config: `localgov_text` (WYSIWYG), `localgov_image` (media image + caption), `localgov_link` (button-style link with a title/URL and a "Button" style option), `localgov_numbered_text` (numbered WYSIWYG step) and `localgov_contact`. The Contact type is the substantial one — sixteen fields (phone/mobile/minicom/out-of-hours, email, several link fields, an `office_hours` schedule, an `address`, a `geolocation` map point) laid out in vertical field-group tabs, and marked convertible to reusable Paragraphs library items. Because these are ordinary paragraph bundles, editors compose pages with the standard Paragraphs UI and site builders can add fields like any bundle. The module itself carries almost no PHP: `hook_localgov_roles_default()` grants the paragraph-library and view-unpublished permissions to the Author, Contributor and Editor roles when `localgov_roles` is present, and a few update hooks fix up the Contact form tabs and (re)install the Numbered text type. Its dependencies are not lightweight — it requires the full paragraphs/paragraphs_library, office_hours, geolocation, address, field_group, entity_browser/entity_usage and localgov_core/localgov_media/localgov_topics stack — so it is meant to run inside a LocalGov Drupal distribution. Four submodules extend the set: `localgov_paragraphs_layout` adds Layout Paragraphs one-to-four-column sections; `localgov_paragraphs_views` embeds a view as a component; `localgov_homepage_paragraphs` supplies council-homepage components; and `localgov_subsites_paragraphs` provides the richer subsite page-builder set (accordion, tabs, quote, key facts, box links, media-with-text, table) along with the accordion/tabs JavaScript behaviours.

---

- Give editors a consistent component library across LocalGov sites.
- Build a page from Text, Image and Link components.
- Add a rich Contact block with phone, email, address and opening hours to a service page.
- Show office opening hours on a contact component via the office_hours field.
- Pin a contact to a map location with the geolocation field.
- Present steps or criteria as Numbered text components.
- Offer a button-style promoted link on a landing page.
- Attach a captioned image chosen from the media library.
- Save a reusable Contact block to the Paragraphs library and reuse it across pages.
- Standardise how contact details and social links are presented.
- Arrange components into one/two/three/four-column layout sections.
- Embed a view as a page component.
- Compose a council homepage from shared components.
- Build subsite pages with accordions, tabs, quotes and key facts.
- Grant editorial roles the paragraph-library permissions automatically.
- Extend a shipped paragraph type with extra fields via Field UI.
- Keep component definitions in exportable configuration.
- Avoid bespoke paragraph types per site.
- Give designers a predictable set of markup patterns.
- Support editorial teams moving between LocalGov sites.
- Underpin the subsites and directories page-building experience.
- Migrate legacy body HTML into structured components.
