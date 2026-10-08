<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WordsOnline Drupal Connector is a translator connecting the Translation Management Tool with WordsOnline Translation Services.

---

WordsOnline Drupal Connector provides a TMGMT (Translation Management Tool) translator plugin for
WordsOnline — connecting Drupal's translation workflow to the WordsOnline translation service, so translation
jobs managed through TMGMT can be sent to WordsOnline. It depends on the TMGMT module, in the Translation
Management package.

Use it to translate content via WordsOnline through TMGMT. Security notes: it authenticates to the WordsOnline
API with credentials — **store those as secrets** (not in exported config), operate over HTTPS, and be aware
content submitted for translation is sent to the WordsOnline service (a data-handling consideration for
sensitive content). It is a multilingual/integration plugin; TMGMT governs the workflow. Configure the
WordsOnline connection.

---

- Translate TMGMT jobs via WordsOnline.
- Provide a TMGMT translator for WordsOnline.
- Depend on the TMGMT module.
- Store WordsOnline credentials as secrets.
- Operate over HTTPS.
- Send content to WordsOnline for translation.
- Mind data handling for sensitive content.
- Manage translation via TMGMT.
- Have no access-control role.
- Configure the WordsOnline connection.
- Handle WordsOnline translation.
- Translate content.
- Handle credentials securely.
- Configure the translator.
- Route jobs to WordsOnline.
- Support multilingual sites.
- Translate via TMGMT.
- Configure credentials.
- Connect to WordsOnline.
- Translate through WordsOnline.
