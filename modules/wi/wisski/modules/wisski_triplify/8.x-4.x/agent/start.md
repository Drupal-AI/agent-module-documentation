<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Triplify (wisski_triplify) — agent index

Submodule of **wisski**, nested under `wisski_apus`. **Triplification API** plus a standard HTML
triplifier. Version **8.x-4.3**. Core `>=10.4 <12`.

Structured fields are already triples via the pathbuilder; triplification is for what is not —
narrative description, imported HTML, unstructured notes.

**The judgement to settle before running it over a collection:** an extracted statement is an
**inference**, not a record. Mixing inferred and catalogued statements without distinguishing them
costs a research database its authority. Decide how they are marked — provenance, confidence, or a
separate named graph — because separating them afterwards is far harder.