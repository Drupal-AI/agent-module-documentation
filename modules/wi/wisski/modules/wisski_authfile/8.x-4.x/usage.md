<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Authority File handles importing external authority files and linking records to them.

---

Not every authority is a live service. Institutions maintain local name lists, project-specific vocabularies and files inherited from predecessor systems, and those arrive as data to be imported rather than queried.

This submodule covers that case: import an authority file, hold it, and link collection records to its entries.

The reason to do this rather than typing names is the same as for any authority: consistency, disambiguation and the ability to correct centrally. The reason to do it *as an import* rather than as a live service is that the authority is yours, or is no longer maintained anywhere that answers HTTP.

**The thing to plan is the file's future.** An imported authority is a snapshot, and snapshots go stale. Decide who maintains it, how updates are applied, and — if the file originated somewhere external — whether the source still exists. A local authority file that nobody owns becomes, within a few years, a list of names with no provenance, which is where the project started.

---

- Import a local authority file.
- Link records to authority entries.
- Use a project-specific vocabulary.
- Handle an authority from a predecessor system.
- Reference an authority no longer online.
- Disambiguate names consistently.
- Correct a name centrally.
- Plan maintenance of an imported file.
- Decide how updates are applied.
- Check whether the source still exists.
- Record provenance for an authority file.
- Avoid an unowned name list.
- Migrate an authority into WissKI.
- Audit unlinked records.
- Combine local and live authorities.
