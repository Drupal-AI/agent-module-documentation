<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Schema.org/DigitalDocument adds the Schema.org `DigitalDocument` type (and its Note/Presentation/Spreadsheet/Text subtypes) to a page's JSON-LD output through the Schema.org Metatag framework.

---

It is a plugin bundle for `schema_metatag`: it provides a metatag group and a set of metatag Tag plugins — `@type`, name, headline, description, about, author, publisher, datePublished, dateModified, encodingFormat, license, isAccessibleForFree, mainEntityOfPage and associatedMedia — plus a `MediaObject` property type. Each tag maps to a token-aware metatag field whose value is composed into the `DigitalDocument` JSON-LD node that Schema.org Metatag renders in the page head. Configuration is done on Metatag defaults or per-entity metatag fields, exactly like any other Schema.org Metatag type.

The module ships only plugin classes and a config schema; it defines no routes, permissions or services, so it has no request-facing attack surface — output is governed by the existing Metatag configuration UI (`administer meta tags`). Set-up: enable it alongside Metatag and Schema.org Metatag, then configure the DigitalDocument group on the relevant Metatag default or field.

---

- Emit Schema.org DigitalDocument JSON-LD for document-style content.
- Choose the specific @type (DigitalDocument, Note/Presentation/Spreadsheet/Text) per page.
- Add a headline and name to the structured document metadata.
- Add a description of the document to the JSON-LD.
- Set the author and publisher of the document.
- Provide datePublished and dateModified values.
- Declare the encodingFormat (MIME type) of the document.
- Add a license URL for the document.
- Mark whether the document isAccessibleForFree.
- Set the mainEntityOfPage reference.
- Attach associatedMedia as a MediaObject.
- Describe what the document is about.
- Configure the tags on a Metatag default (e.g. per content type).
- Configure the tags on a per-entity metatag field.
- Use tokens to populate values from entity fields.
- Improve rich-result eligibility for document pages in search engines.