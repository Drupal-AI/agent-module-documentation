<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Assembles core Book outlines into multi-chapter ePub ebooks with configurable metadata field mapping.

---

ePub Generator: Book Integration turns a core Book outline into a single multi-chapter ebook. When enabled, the base module's **Download ePub** tab on any node that belongs to a book generates the whole assembled book instead of a single page: the submodule walks the outline through the Book manager, renders each published child node through the ePub (or Full) view mode, and produces one ePub with a hierarchical table of contents that mirrors the outline. Book-level publishing metadata — author, ISBN, publisher, cover image, subtitle, edition, rights, description, and fixed-layout settings — is read from fields on the book's **root node** via a configurable field mapping. The mapping is resolved per content type (a default mapping plus per-bundle overrides), so different root types can read metadata from different fields. A one-click action on the **Book field mapping** form (`/admin/config/content/epub-generator/book-field-mapping`) creates the full canonical field set on a content type of your choice and maps it, leaving any existing fields untouched. Requires the base module and the Book module.

---

- Download an entire Book outline as one multi-chapter ebook from any node's **Download ePub** tab.
- Generate a hierarchical ePub table of contents that mirrors the book outline structure.
- Read the book author from a mapped field, or fall back to the root node's owner.
- Embed an ISBN as the ePub identifier from a mapped field.
- Pull publisher, subtitle, edition and rights/copyright from mapped root-node fields.
- Use a mapped image or media field as the ebook cover.
- Read a rich-text or summary description field for the ePub description and title page.
- Apply per-book fixed-layout settings (layout, viewport width/height, spread, orientation) from fields.
- Add per-book CSS "strip selectors" (on top of the site-wide list) from a mapped field.
- Support more than one content type as a book root with per-content-type mapping overrides.
- Opt a content type out of an inherited default field by mapping it to an empty string.
- One-click create and map the entire canonical metadata field set on a chosen content type.
- Re-run the one-click setup safely: existing fields are detected and reported, not overwritten.
- Skip unpublished child nodes and nodes whose bundle is not enabled for ePub generation.
- Drop a theme-rendered duplicate title heading so each chapter gets one clean title.
- Generate a book ePub from the CLI with `drush epub:generate-book <nid>`.
- Configure whether a publishing-metadata title page is generated.
- Keep working in the normal Book UI while publishing-ready ebooks are produced on demand.
