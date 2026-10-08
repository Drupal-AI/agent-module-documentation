<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Utilities bundles small utility modules and helpers used across the LocalGov Drupal distribution, including a character-count submodule.

---

LocalGov Utilities is a container of small utility helpers for the LocalGov Drupal distribution —
the UK local-government Drupal platform. It is marked `hidden` (it is a distribution support module,
not something site builders enable directly by browsing) and depends on Textfield Counter. It ships a
`localgov_char_count` submodule that adds character-count feedback to text fields (helping editors keep
titles/summaries within recommended lengths), and provides other small conveniences that the LocalGov
distribution relies on.

Use it as part of the LocalGov Drupal ecosystem rather than standalone; on a LocalGov site it is
typically enabled by the distribution. It is an editorial/utility module with no access-control role.
Because it is `hidden`, expect it to be managed by the distribution's dependencies rather than toggled
manually.

---

- Provide utility helpers for LocalGov Drupal.
- Add character-count feedback to text fields.
- Help editors keep titles within length limits.
- Support the LocalGov distribution.
- Depend on Textfield Counter.
- Ship the localgov_char_count submodule.
- Stay hidden from the module browse UI.
- Bundle small conveniences for LocalGov.
- Enable as part of the LocalGov ecosystem.
- Show remaining characters as editors type.
- Constrain summary/title lengths editorially.
- Act as a distribution support module.
- Provide no access-control behaviour.
- Be managed via distribution dependencies.
- Improve LocalGov editorial UX.
- Wrap textfield_counter for LocalGov defaults.
- Guide editors on recommended field lengths.
- Serve UK local-government sites.
- Complement other localgov_* modules.
- Add small utilities the distribution needs.
