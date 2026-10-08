<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI RDF Adapter (wisski_adapter_rdf) — agent index

Submodule of **wisski**. RDF-oriented **SPARQL 1.1** adapter, pathbuilder-driven.
Version **8.x-4.3**. Core `>=10.4 <12`.

Sits alongside `wisski_adapter_sparql11_pb`. **In a multi-adapter installation, establish which
adapter a project's data actually lives behind before changing anything** — SALZ presents them
uniformly, so a change against the wrong adapter either does nothing visible or writes into a store
nobody is reading.