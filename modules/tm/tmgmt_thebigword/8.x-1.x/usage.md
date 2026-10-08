<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Translation Management Tool (TMGMT) service plugin that connects Drupal to thebigword's professional/human translation service: it uploads job items as files, tracks their remote state, and pulls completed translations back into TMGMT.

---

The module registers a `thebigword` TMGMT translator plugin (`ThebigwordTranslator`) with a settings UI (`ThebigwordTranslatorUi`) where you configure the service credentials/endpoint. Translation jobs are exported as files (it requires `tmgmt_file`) and sent to thebigword; the module exposes a set of routes for the round trip. `/tmgmt_thebigword_callback` (`_access: 'TRUE'`) receives thebigword's file-state notifications — but before acting, the controller re-fetches the file's authoritative `CmsState` from thebigword's API (`file/cmsstate/<id>`) and only proceeds if it matches, and it only ever operates on job items that already have a matching local RemoteMapping, so the open callback cannot inject arbitrary data. `/pull_all_remote_translations` (permission `administer tmgmt` + `accept translation jobs`) batch-pulls finished translations, and `/admin/tmgmt/job/{item}/thebigword/review` redirects a reviewer to thebigword's external Review Tool under a custom access check.

Two "external review" permissions (primary/secondary) are marked with explicit security warnings: they let a holder open a Review Tool task directly, bypassing logon, so grant them only to trusted roles. A third permission configures language-skill mappings. Set it up by adding a `thebigword` translator under **TMGMT → Providers** (`entity.tmgmt_translator.collection`), entering the API details, and mapping Drupal languages to thebigword language skills.

---
- Send Drupal content to thebigword for professional translation via TMGMT
- Add a `thebigword` provider under TMGMT Providers
- Configure thebigword API credentials/endpoint on the translator form
- Export job items as files to thebigword (tmgmt_file)
- Receive remote file-state notifications on the callback route
- Have the callback re-validate state against thebigword before importing
- Pull all completed remote translations in a batch
- Redirect reviewers to thebigword's external Review Tool
- Map Drupal languages to thebigword language skills
- Grant primary external-review access to trusted reviewers only
- Grant secondary external-review access to trusted reviewers only
- Enable debug logging of callback requests via settings
- Track job items through RemoteMapping records
- Restart/report errors back to thebigword on import failure
- Localize a multilingual site with a human translation vendor
- Combine language pairs via tmgmt_language_combination
- Review and accept returned translations inside TMGMT
