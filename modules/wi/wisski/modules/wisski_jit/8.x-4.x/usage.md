<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI JIT integrates the JavaScript InfoVis Toolkit for visualising graph data.

---

The JavaScript InfoVis Toolkit was a library for rendering graphs and trees in the browser, and in a semantic collection graph visualisation is a natural fit: the data *is* a graph, and seeing how records connect is often more revealing than querying them.

This module is that integration.

**It ships under the project's `legacy/` directory and the toolkit it wraps is itself long unmaintained** — JIT's development stopped over a decade ago, and modern equivalents (D3, Cytoscape, Vis.js and others) have replaced it comprehensively. The honest position is that this is of historical interest: worth recognising if you find it enabled on an inherited installation, and not something to build on.

If a current project needs graph visualisation, the question to ask is what it should visualise rather than which library to use — a graph view of an entire collection is unreadable, and the useful visualisations are usually narrow: one record's immediate connections, one relationship type across a subset, a comparison between two records.

---

- Recognise the module on an inherited site.
- Understand its legacy status.
- Visualise a record's connections.
- See how records relate as a graph.
- Decide what a visualisation should show.
- Avoid visualising an entire collection.
- Choose a modern graph library instead.
- Plan a narrow, readable visualisation.
- Compare two records' relationships.
- Show one relationship type across a subset.
- Audit legacy modules on an installation.
- Remove an unused legacy module.
- Assess a replacement visualisation approach.
- Document why the module is retained.
- Plan a visualisation replacement.
- Check whether anything still uses it.
