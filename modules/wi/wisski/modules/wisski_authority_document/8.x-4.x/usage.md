<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Authority Document integrates authority document services — currently lobid.org's GND interface.

---

Where the GND adapters query the authority file as a data source, this handles authority *documents* — the records themselves, retrieved from lobid.org and available for reconciliation and enrichment.

The distinction matters in practice. Querying gives you a label for an identifier; working with the document gives you everything the authority knows: variant names, dates, relationships to other entities, identifiers in other systems. That is what makes reconciliation possible — matching a name in your data against the right authority record by comparing more than the string.

Its own description says "currently only from lobid.org/gnd", which is honest and worth passing on: it is a framework with one implementation, so a project needing a different authority service is looking at development rather than configuration.

Reconciliation is where most of the effort in a linked-data project actually goes, and it is worth budgeting for. Matching a few thousand names against an authority file is not a job that finishes in an afternoon, and the residue that cannot be matched automatically needs a person.

---

- Retrieve an authority record from lobid.org.
- Reconcile names against the GND.
- Match by more than a name string.
- Use variant names in matching.
- Compare dates during reconciliation.
- Enrich a record with authority data.
- Find identifiers in other systems.
- Plan a reconciliation project.
- Budget for manual reconciliation residue.
- Understand the framework's single implementation.
- Assess adding another authority service.
- Audit unreconciled names.
- Improve match rates over time.
- Document a reconciliation workflow.
- Combine with the GND adapters.
