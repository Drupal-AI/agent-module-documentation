<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Getty Adapter (new) is the newer implementation of Getty AAT querying.

---

As with the two GND adapters, two Getty adapters reflect a change at the provider — Getty exposes its vocabularies through a SPARQL endpoint as well as older access paths, and the newer adapter targets the current arrangement.

Choose it for new projects. For an existing one, the action is the same as with GND: establish which adapter is configured, confirm it still resolves, and be aware that an authority adapter degrades quietly rather than failing loudly.

Everything said about the AAT itself under `wisski_adapter_aat` — why controlled vocabulary matters for aggregation and multilingual access — applies here; this is the same vocabulary reached a different way.

---

- Query Getty vocabularies through the current interface.
- Choose the newer Getty adapter for a new project.
- Establish which Getty adapter is configured.
- Confirm an authority adapter still resolves.
- Migrate from the older Getty adapter.
- Describe materials in controlled terminology.
- Keep vocabulary references current.
- Plan for a provider interface change.
- Compare results between Getty adapters.
- Audit unresolved vocabulary references.
- Reach Getty through its SPARQL endpoint.
- Document which adapter a project uses.
- Test against a copy before switching.
- Detect quietly degraded authority lookups.
- Document this module's role for the project.
- Review its status during an audit.
