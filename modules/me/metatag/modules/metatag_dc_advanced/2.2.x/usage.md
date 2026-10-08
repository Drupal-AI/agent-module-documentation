Adds forty additional Dublin Core (`dcterms.*`) qualified/advanced meta tags on top of the basic fifteen.

---

Beyond the fifteen-element DCMES 1.1 set, the Dublin Core Metadata Terms vocabulary defines many refinements (qualified Dublin Core). This submodule registers forty of those additional `dcterms.*` terms as Metatag plugins, covering provenance, versioning, accrual, temporal/spatial coverage, rights, and relationship refinements. It depends on both the main Metatag module and `metatag_dc` (the basic set). Useful for libraries, archives, and repositories needing precise, standards-compliant descriptive metadata. All tags support tokens and can be set as defaults or per entity.

---

- Add an abstract with `dcterms.abstract`.
- Declare access rights with `dcterms.accessRights`.
- State a license with `dcterms.license`.
- Name the rights holder with `dcterms.rightsHolder`.
- Record creation date with `dcterms.created`.
- Record modification date with `dcterms.modified`.
- Record issue date with `dcterms.issued`.
- Provide an alternative title with `dcterms.alternative`.
- Give a bibliographic citation with `dcterms.bibliographicCitation`.
- Declare the target audience with `dcterms.audience`.
- Declare education level with `dcterms.educationLevel`.
- Express "is part of" / "has part" relations (`dcterms.isPartOf`, `dcterms.hasPart`).
- Express format relations (`dcterms.isFormatOf`, `dcterms.hasFormat`).
- Express version relations (`dcterms.isVersionOf`, `dcterms.hasVersion`).
- Express replacement relations (`dcterms.replaces`, `dcterms.isReplacedBy`).
- Express requirement relations (`dcterms.requires`, `dcterms.isRequiredBy`).
- Declare conformance with `dcterms.conformsTo`.
- Record provenance with `dcterms.provenance`.
- Set spatial coverage with `dcterms.spatial`.
- Set temporal coverage with `dcterms.temporal`.
- Declare the medium or extent (`dcterms.medium`, `dcterms.extent`).
- Record accrual method/periodicity/policy for collections.
- Provide table of contents with `dcterms.tableOfContents`.
- Mark a valid date range with `dcterms.valid`.
- Reference or be-referenced-by other works (`dcterms.references`, `dcterms.isReferencedBy`).
