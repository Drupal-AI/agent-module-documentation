<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Pathbuilder is where a Drupal field is bound to a path through an ontology — the mechanism that turns form input into standards-conformant triples.

---

This is the intellectual centre of WissKI. A form field called "Date of production" means nothing to a triple store; a path — this object, was produced by, a production event, which has a time-span, which has a beginning — means something a machine can reason about and another institution can consume. The pathbuilder is where that mapping is defined.

Practically it is what makes WissKI different from a content type with a SPARQL exporter. The ontology model comes first, the fields are projections of it, and the data is conformant by construction rather than by a translation step that has to be maintained.

It also means the pathbuilder is the artefact that most needs care. A path is a modelling decision with consequences for every record created under it; changing one after data exists is a migration, not an edit. Institutions treat pathbuilders as versioned, reviewed documents for good reason, and a WissKI project's difficulty is usually proportional to how well its pathbuilder was thought through.

Required by both `wisski_core` and the SPARQL adapter, so it is present on every WissKI install.

---

- Map a Drupal field onto an ontology path.
- Model data against CIDOC-CRM.
- Produce standards-conformant triples from a form.
- Define how a record is expressed in RDF.
- Reuse an existing pathbuilder from another project.
- Version a pathbuilder as a reviewed document.
- Plan a modelling change as a migration.
- Understand why WissKI differs from a SPARQL exporter.
- Express a production event with a time-span.
- Share a data model between institutions.
- Review a pathbuilder before creating records.
- Extend a model with a new path.
- Diagnose data that does not appear in queries.
- Audit an inherited project's data model.
- Train a project team on the pathbuilder.
