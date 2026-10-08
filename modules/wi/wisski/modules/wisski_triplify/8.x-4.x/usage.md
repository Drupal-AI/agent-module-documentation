<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Triplify converts entity content into RDF triples, with a standard triplifier for HTML.

---

Triplification is the step that turns content into statements: this text mentions this person, who was born in this year, in this place. A WissKI record's structured fields are already triples by construction via the pathbuilder; triplification is for the parts that are not — narrative description, imported HTML, unstructured notes.

The HTML triplifier that ships with it handles the common case of content that arrived as markup from an older system or a digitisation workflow.

The judgement to make with any automated triplification is confidence. A statement extracted from prose is an inference, not a record, and mixing inferred statements with catalogued ones without distinguishing them is how a research database loses its authority. Whether extracted triples are marked as such — provenance, confidence, or simply a separate named graph — is the question to settle before running it over a collection, because separating them afterwards is much harder than keeping them apart from the start.

---

- Convert entity content into RDF triples.
- Triplify imported HTML content.
- Extract statements from narrative description.
- Process unstructured notes into data.
- Handle content from a legacy system.
- Build a custom triplifier.
- Mark extracted statements as inferred.
- Record provenance for extracted triples.
- Keep inferences in a separate named graph.
- Preserve a database's authority.
- Plan triplification before running it.
- Combine triplification with annotation.
- Audit which statements were inferred.
- Review extraction accuracy on a sample.
- Understand the pathbuilder's role by contrast.
