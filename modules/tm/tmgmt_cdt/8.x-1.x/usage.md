<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Translation Centre (CdT) is a TMGMT translator for the Translation Centre for the Bodies of the EU (cdt.europa.eu).

---

Translation Centre (CdT) provides a TMGMT (Translation Management Tool) translator plugin for the
**Translation Centre for the Bodies of the EU** (CdT, cdt.europa.eu) — so translation jobs managed through
TMGMT can be sent to the CdT translation service. It depends on the TMGMT module, in the Translation
Management package.

The cURL options used for CdT API requests (which carry the module's API password / access token and
the content submitted for translation) come from the `tmgmt_cdt.curl_options` config. Store the
CdT credentials as secrets. It is a multilingual/integration plugin; TMGMT governs the workflow.

---

- Translate TMGMT jobs via the EU CdT.
- Provide a TMGMT translator for CdT.
- Depend on the TMGMT module.
- Configure cURL options via tmgmt_cdt.curl_options.
- Store the CdT credentials as secrets.
- Manage translation via TMGMT.
- Configure the CdT connection.
- Translate content.
- Handle credentials securely.
- Route jobs to CdT.
- Support multilingual sites.
- Configure the translator.
- Translate via CdT.
