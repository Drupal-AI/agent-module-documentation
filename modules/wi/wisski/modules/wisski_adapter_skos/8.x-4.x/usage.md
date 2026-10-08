<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI SKOS Adapter reads a SKOS vocabulary from a SPARQL 1.1 store.

---

SKOS is the W3C model for thesauri and classification schemes — concepts, broader and narrower relations, preferred and alternative labels — and it is how most institutional vocabularies are published when they are published as linked data. An adapter for it lets a project reference its own or a partner's vocabulary rather than duplicating it as taxonomy terms.

That matters for the same reason the Getty adapter does: a vocabulary maintained in one place and referenced from many keeps its corrections and its multilingual labels, where a copied one diverges immediately.

**Note this module lives under the project's `legacy/` directory**, which is a statement about its status rather than about SKOS. Establish whether a project depends on it and what the current recommended path is before building new work on it.

---

- Reference a SKOS vocabulary from records.
- Use an institutional thesaurus as linked data.
- Read broader and narrower concept relations.
- Get preferred and alternative labels.
- Avoid duplicating a vocabulary as taxonomy.
- Keep vocabulary corrections propagating.
- Support multilingual concept labels.
- Reference a partner institution's vocabulary.
- Check whether a project depends on it.
- Note its position under legacy/.
- Establish the current recommended path.
- Compare with the Getty adapters.
- Audit vocabulary sources on a project.
- Plan vocabulary strategy for a collection.
- Document this module's role for the project.
- Review its status during an audit.
