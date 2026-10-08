<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# thebigword Connector (tmgmt_thebigword) — agent index

**A TMGMT translator plugin routing translation jobs to thebigword and pulling results back.**

- **Version:** 8.x-1.x · package Translation Management
- **Core:** ^10 || ^11 · depends on `tmgmt`, `tmgmt_file`, `tmgmt_language_combination`
- **Configure:** add a `thebigword` provider at `entity.tmgmt_translator.collection` (TMGMT → Providers)
- **Plugin:** `ThebigwordTranslator` (+ `ThebigwordTranslatorUi`)
- **Routes:** `/tmgmt_thebigword_callback` (`_access: TRUE`, remote file-state notify), `/no_preview` (`_access: TRUE`), `/pull_all_remote_translations` (perm `administer tmgmt`+`accept translation jobs`), `/admin/tmgmt/job/{item}/thebigword/review` (custom access)
- **Permissions:** `access tmgmt thebigword primary review`, `... secondary review` (both bypass logon to the Review Tool — grant to trusted roles only), `configure tmgmt thebigword language skills`

**Security:** reviewed sound. The open `callback` route re-fetches the authoritative `CmsState` from thebigword's API and matches it before importing, and only acts on job items with an existing local RemoteMapping — an unauthenticated caller cannot inject translation data. The two external-review permissions are explicitly flagged (logon bypass) and restrict access.

See [configure/setup.md](configure/setup.md)
