<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smartcat translator provides a TMGMT translator plugin that sends translation jobs to the Smartcat translation platform.

---

Smartcat translator (tmgmt_smartcat) is a translator plugin for the Translation Management Tool
(TMGMT) that connects Drupal's translation workflow to Smartcat — a translation management/CAT
platform. Content sent for translation through TMGMT is dispatched to Smartcat (where human or machine
translation happens) and the results are pulled back into Drupal. It depends on TMGMT and TMGMT File.

Use it to route TMGMT translation jobs through Smartcat for professional/managed translation. The
security-relevant point is the Smartcat API credentials — store them as secrets — and awareness that
content submitted for translation is sent to the external Smartcat platform (a data-handling
consideration for sensitive content). It is a multilingual/integration plugin; TMGMT governs the
translation workflow and this module supplies the Smartcat backend.

---

- Route TMGMT jobs to Smartcat.
- Send content for translation to Smartcat.
- Pull translations back into Drupal.
- Provide a TMGMT translator plugin.
- Depend on TMGMT and TMGMT File.
- Store Smartcat API credentials as secrets.
- Use professional/managed translation.
- Connect to the Smartcat platform.
- Understand content is sent externally.
- Handle sensitive content carefully.
- Supply the Smartcat backend.
- Integrate a CAT platform.
- Dispatch translation jobs.
- Manage translations via TMGMT.
- Authenticate to Smartcat.
- Support multilingual workflows.
- Retrieve completed translations.
- Use TMGMT's workflow.
- Translate via Smartcat.
- Configure the Smartcat connection.
