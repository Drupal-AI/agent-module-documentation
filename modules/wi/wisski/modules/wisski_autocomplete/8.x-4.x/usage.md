<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Autocomplete enriches autocomplete suggestions with additional information, so a researcher can tell two similar records apart.

---

Autocomplete on a research database has a disambiguation problem that ordinary content does not. A collection may hold forty people called Müller, six objects called "cup", and several places with the same name in different countries. A suggestion list showing only titles is unusable.

This submodule lets additional information appear within the title pattern — dates, roles, identifiers, whatever the pathbuilder can supply — so a suggestion is identifiable rather than merely present.

It is a dependency of `wisski_core`, which places it as infrastructure rather than an option: entity reference is fundamental to a semantic data model, and selecting the wrong referent is the most common and most damaging data quality error in this kind of work. A cataloguer who picks the wrong Müller creates a factual error that propagates through every query and every export afterwards.

---

- Distinguish two records with the same name.
- Show dates alongside a person's name.
- Show a role or identifier in a suggestion.
- Reduce mis-selected entity references.
- Improve cataloguing accuracy.
- Disambiguate place names.
- Configure what appears in the title pattern.
- Draw extra information from the pathbuilder.
- Prevent a data quality error at source.
- Speed up entity selection for cataloguers.
- Show an authority identifier in suggestions.
- Support reference selection across adapters.
- Audit records for mis-selected references.
- Train cataloguers on disambiguation.
- Reduce downstream errors in exports.
