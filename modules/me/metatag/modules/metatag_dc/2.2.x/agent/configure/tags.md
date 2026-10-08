# Dublin Core tags (DCMES 1.1)

Adds the "Dublin Core" MetatagTag group with the fifteen core elements, each emitted as
`<meta name="dcterms.NAME" content="…">`:

`dcterms.title`, `dcterms.creator`, `dcterms.subject`, `dcterms.description`,
`dcterms.publisher`, `dcterms.contributor`, `dcterms.date`, `dcterms.type`,
`dcterms.format`, `dcterms.identifier`, `dcterms.source`, `dcterms.language`,
`dcterms.relation`, `dcterms.coverage`, `dcterms.rights`.

Set them in any Metatag defaults entity or the per-entity field; all support tokens.
Schema: `config/schema/metatag_dc.metatag_tag.schema.yml`.
