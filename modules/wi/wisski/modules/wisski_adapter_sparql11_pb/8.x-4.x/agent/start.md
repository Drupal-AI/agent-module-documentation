<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI SPARQL 1.1 Adapter (wisski_adapter_sparql11_pb) — agent index

Submodule of **wisski**, **required by the top-level module**. Reads/writes a **SPARQL 1.1
endpoint**, mapped by the pathbuilder. Version **8.x-4.3**. Core `>=10.4 <12`.

Where SALZ abstracts adapters, this implements the concrete one most installations store data in.

**Store choice is a long-consequence infrastructure decision** — Fuseki, GraphDB, Blazegraph differ
in performance, SPARQL Update support, transaction behaviour and operational maturity. For a
decades-long research project, weigh backup, export and longevity as heavily as query speed.

**Two operational notes:** the endpoint is a **credential-bearing external service** — an update-
capable SPARQL endpoint is as sensitive as a database; and **SPARQL Update is not uniformly
implemented**, so a store that reads correctly may still fail on writes. Test the full cycle before
committing data.