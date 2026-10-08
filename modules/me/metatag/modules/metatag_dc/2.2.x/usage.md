Adds the fifteen Dublin Core Metadata Element Set 1.1 (`dcterms.*`) meta tags to Metatag for rich, standardized document metadata.

---

Dublin Core is a widely used metadata standard for describing documents and resources, especially in libraries, archives, and academia. This submodule registers the fifteen core `DCMES 1.1` elements as Metatag plugins in a "Dublin Core" group, so they can be set as site/bundle defaults or per entity, with full token support. Each emits a `<meta name="dcterms.…">` tag. Depends on the main Metatag module; the companion `metatag_dc_advanced` submodule adds forty more DC terms. Good for content that needs formal bibliographic metadata for harvesting, discovery, or catalog integration.

---

- Describe a page's title with `dcterms.title` (e.g. `[node:title]`).
- Name the author/creator with `dcterms.creator`.
- Add a summary with `dcterms.description`.
- Declare the publisher with `dcterms.publisher`.
- List contributors with `dcterms.contributor`.
- Set the publication date with `dcterms.date`.
- Declare the resource type with `dcterms.type` (Text, Image, …).
- Declare the file format with `dcterms.format`.
- Add a unique identifier with `dcterms.identifier`.
- Declare the source with `dcterms.source`.
- Set the content language with `dcterms.language`.
- Relate to other resources with `dcterms.relation`.
- Declare spatial/temporal scope with `dcterms.coverage`.
- Set rights information with `dcterms.rights`.
- Add subject keywords with `dcterms.subject`.
- Provide bibliographic metadata for library catalog harvesting.
- Standardize academic/journal article metadata across a site.
- Set Dublin Core defaults per content type.
- Populate DC tags from tokens so they stay in sync with content.
- Support metadata harvesting protocols (OAI-PMH-style) via embedded DC.
- Improve discoverability in repositories that read Dublin Core.
