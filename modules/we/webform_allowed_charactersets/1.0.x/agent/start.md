<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Allowed Charactersets — agent start

**What**: Restricts webform text/textarea input to selected Unicode scripts. Depends on
`webform`. Config: `/admin/structure/webform/config/charactersets`
(perm: core **administer webform**).

## Set up
1. `drush en webform_allowed_charactersets -y`.
2. Go to the config page; check **Enable characterset validation** and the allowed sets.
3. Either check **Use it on all webforms** (global) OR add the handler
   **"Validate input characerset"** (`allowed_charactersets_handler`) to specific webforms.

## Key facts
- Config object: `webform_allowed_charactersets.settings`
  (`enable_characterset_validation`, `protect_all_forms`, `charactersets`).
- Global path: `hook_webform_submission_form_alter()` →
  `CharactersetService::addCharactersetValidation()` attaches `#element_validate` to every
  text/textarea element recursively.
- Per-form path: `CharactersetWebformHandler::validateForm()` runs the same service.
- Validity = input matches the Unicode property regex of **any** enabled set; non-string
  input passes. Server-side Form API validation only (submission gate, not a security check).
- No own permissions; uses core `administer webform`.
