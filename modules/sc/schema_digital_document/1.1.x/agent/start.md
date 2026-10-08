<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Schema.org/DigitalDocument (schema_digital_document) — agent index

**Adds Schema.org DigitalDocument (+ Note/Presentation/Spreadsheet/Text subtypes) JSON-LD via the Schema.org Metatag framework.**

- **Version:** 1.1.x (1.1.0-alpha1)
- **Core:** ^10 || ^11
- **Dependencies:** schema_metatag:schema_metatag (Metatag)

## Surface
- No routes, permissions, or services.
- Metatag Group plugin `SchemaDigitalDocument` + Tag plugins: type, name, headline, description, about, author, publisher, datePublished, dateModified, encodingFormat, license, isAccessibleForFree, mainEntityOfPage, associatedMedia.
- `PropertyType\MediaObject` and a `config/schema` for the tags.

**Security:** no request-facing surface; configured through the core/Metatag UI (`administer meta tags`) and rendered as JSON-LD by schema_metatag. No security findings.
