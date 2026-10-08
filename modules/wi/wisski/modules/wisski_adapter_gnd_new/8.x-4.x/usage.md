<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI GND Adapter (new) is the newer implementation of GND querying, alongside the original adapter.

---

Two adapters for the same authority file usually means an interface change at the provider: the GND's access paths have moved over time, notably toward the lobid.org API, and a newer adapter follows the current one while the older remains for installations that depend on it.

For a new project, the newer adapter is the sensible default. For an inherited one, the useful action is to establish which is in use and whether the older one still works — an authority adapter that silently stops resolving leaves records referencing identifiers nobody is checking, and the symptom is subtle: labels stop updating rather than anything visibly failing.

The same live-query consequences apply as for the original adapter: availability, label control and identifier deprecation are the provider's, not the project's.

---

- Query the GND through the current interface.
- Choose the newer GND adapter for a new project.
- Establish which GND adapter an inherited site uses.
- Detect an authority adapter that stopped resolving.
- Notice labels that stopped updating.
- Migrate from the older GND adapter.
- Reference people and corporate bodies.
- Keep authority references current.
- Plan for a provider interface change.
- Check availability handling.
- Compare results between the two adapters.
- Audit unresolved authority references.
- Document which adapter a project depends on.
- Test the adapter against a copy.
- Document this module's role for the project.
- Review its status during an audit.
