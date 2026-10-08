<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI SPARQL 1.1 Adapter is the main storage adapter: it reads and writes a SPARQL 1.1 endpoint using the pathbuilder's mapping.

---

This is the adapter a typical WissKI installation actually stores its data in, and it is required by the top-level `wisski` module. Where SALZ abstracts adapters in general, this one implements the concrete case — a SPARQL 1.1 endpoint, with the pathbuilder deciding how entity fields become triples and how triples become field values.

Choosing the store behind it is an infrastructure decision with long consequences: Fuseki, GraphDB, Blazegraph and others differ in performance, in their support for SPARQL Update, in transaction behaviour and in operational maturity. A research project expecting to hold data for decades should weigh backup, export and longevity as heavily as query speed.

Two operational notes. **The endpoint is a credential-bearing external service** — a SPARQL endpoint with update rights is as sensitive as a database, and its credentials deserve the same handling as any other secret. And **SPARQL Update is not universally implemented the same way**, so a store that reads correctly may still fail on writes; test the full cycle before committing data to it.

---

- Store WissKI data in a SPARQL 1.1 store.
- Write triples from a Drupal form.
- Read entity data back from a triple store.
- Drive mapping from the pathbuilder.
- Connect to Fuseki, GraphDB or similar.
- Choose a triple store for a long-lived project.
- Weigh backup and export in store selection.
- Test SPARQL Update support before committing.
- Handle store credentials as secrets.
- Query the store directly for debugging.
- Plan for decades-long data retention.
- Migrate data between triple stores.
- Diagnose reads that work and writes that fail.
- Configure the endpoint URL and auth.
- Audit which store a project depends on.
