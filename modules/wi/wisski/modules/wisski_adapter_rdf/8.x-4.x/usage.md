<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI RDF Adapter connects to a SPARQL 1.1 store with RDF support, driven by a pathbuilder.

---

A second SPARQL-family adapter alongside `wisski_adapter_sparql11_pb`, oriented toward RDF handling. Where several adapters cover the same protocol family, the practical question when configuring a project is which one the installation actually uses for its primary store and which are present but idle.

Read this as the general RDF path: it speaks SPARQL 1.1 and maps through the pathbuilder like the primary adapter, and it is a reasonable place to look when a project's store arrangement is not the default one.

**Check which adapter a project's data actually lives behind before changing anything.** In a multi-adapter installation, a change made against the wrong adapter either does nothing visible or writes into a store that is not the one being read — and because SALZ presents them uniformly, that is not obvious from the UI.

---

- Connect a project to an RDF store.
- Map RDF data through a pathbuilder.
- Configure a secondary SPARQL adapter.
- Identify which adapter holds a project's data.
- Read from a non-default store arrangement.
- Diagnose a write that goes to the wrong store.
- Plan a multi-adapter installation.
- Migrate between RDF stores.
- Query a store directly for comparison.
- Audit configured adapters on a site.
- Understand SALZ's uniform presentation.
- Test an adapter against a copy.
- Document a project's storage layout.
- Retire an unused adapter.
- Document this module's role for the project.
- Review its status during an audit.
