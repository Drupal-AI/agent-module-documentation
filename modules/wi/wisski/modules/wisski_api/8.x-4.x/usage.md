<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI API exposes WissKI entities over HTTP, so external systems can read and write research data without going through the UI.

---

Research infrastructure is rarely one system. Data arrives from field recording apps, digitisation pipelines and other institutions' catalogues, and leaves for aggregators, portals and analysis tools. An HTTP API is how that traffic happens without someone exporting spreadsheets.

This submodule provides it for WissKI entities, so a script can create records, update them or read them back in whatever serialisation the API offers.

**Treat it as the most security-sensitive part of a WissKI install, and configure it deliberately.** An API that can write entities can write into the triple store, and one that can read them can read everything the store holds — including, in a museum or archive context, information that is deliberately not public: donor details, valuations, precise findspots of archaeological material, personal data about living people. Which authentication applies, which roles may call it, and whether read and write are separately controlled are the questions to settle before enabling it, not afterwards.

Because WissKI could not be enabled on the review install (see `wisski_core`), this is documented from source; the access model should be verified directly against the release you deploy.

---

- Create WissKI records from an external system.
- Update records from a digitisation pipeline.
- Read research data into an analysis tool.
- Feed an aggregator or portal.
- Exchange data with another institution.
- Script bulk changes over HTTP.
- Integrate a field recording app.
- Verify which authentication the API requires.
- Restrict who may call the API.
- Separate read access from write access.
- Protect non-public collection data.
- Withhold findspot data from an API consumer.
- Audit API access on a research site.
- Test the API against a copy before production.
- Plan data exchange for a research project.
