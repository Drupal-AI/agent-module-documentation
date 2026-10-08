<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CiviCRM Afform Block — agent start

Drupal↔CiviCRM bridge. Provides one Block plugin `civicrm_afform_block` that renders a CiviCRM Afform.
Depends on core `block` and the `civicrm` module.

- Block config stores `civicrm_afform_block_form_name` (Afform machine name) + resolved `civicrm_afform_block_directive_name`.
- `blockForm()` lists Afforms via `Afform::get()` (types form/search/system); actual render happens in
  `hook_block_build_civicrm_afform_block_alter` which loads CiviCRM resources + Angular module.
- No module permissions/routes; placement needs `administer blocks`; the Afform enforces CiviCRM permissions at render.
- Key files: `src/Plugin/Block/CivicrmAfformBlock.php`, `civicrm_afform_block.module`.
- See ../usage.md.
