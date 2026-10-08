<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Statistics reports on the state of a WissKI system — what is in it and how it is growing.

---

Research projects report. A funder wants to know how many records exist, a project lead wants to know whether cataloguing is on schedule, and a data manager wants to know how much of the collection is actually complete rather than merely created.

This submodule provides those numbers from the system itself, rather than from someone running SPARQL queries by hand and pasting results into a spreadsheet.

The numbers worth watching in this kind of project are usually not the headline count. Records created is easy and flattering; records with an authority-controlled maker, records with a resolvable place, records with an image — those measure whether the data is doing what the model promised. A statistics module is most useful when it is pointed at the completeness measures a project actually committed to.

Worth checking what it counts and at what cost: statistics over a triple store can be expensive queries, so a dashboard that recalculates on every page load is a dashboard that slows the system it reports on.

---

- Report how many records a collection holds.
- Track cataloguing progress against a schedule.
- Measure data completeness.
- Count records with authority-controlled makers.
- Count records with resolvable places.
- Count records with images.
- Report to a funder.
- Avoid hand-run SPARQL for reporting.
- Watch completeness rather than raw counts.
- Check the cost of statistics queries.
- Cache expensive statistics.
- Show progress to a project team.
- Identify under-catalogued areas.
- Audit a collection before publication.
- Plan reporting for a research project.
