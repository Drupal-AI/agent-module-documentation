<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Allowed Charactersets

Lets you restrict what character sets are accepted in webform `textfield` and `textarea`
inputs. You pick which Unicode scripts are allowed (Latin, Cyrillic, Chinese, Japanese,
Korean, Arabic, Greek, Hebrew, Devanagari, Thai, and more) on a global settings page, then
either apply validation to **all** webforms or add the **"Validate input characerset"**
handler to individual forms. Input that contains none of the allowed scripts fails
validation. A common use is blocking spam submissions written in scripts you never expect.

---

## Summary

Settings live at `/admin/structure/webform/config/charactersets`
(`webform_allowed_charactersets.settings`): `enable_characterset_validation`,
`protect_all_forms`, and the `charactersets` checkboxes. When "protect all forms" is on,
`hook_webform_submission_form_alter()` calls the `CharactersetService` to recursively attach
an `#element_validate` callback to every text/textarea element. Otherwise you add the
`CharactersetWebformHandler` (`id: allowed_charactersets_handler`) per form, whose
`validateForm()` runs the same service.

`CharactersetService::isValidCharacterset()` builds a Unicode property regex
(`\p{Latin}`, `\p{Cyrillic}`, script ranges, etc.) for each enabled set and returns TRUE if
the input matches **any** enabled set; non-string input is treated as valid. Validation is
server-side via the Form API, so it is a submission gate, not a security boundary.

---

## Use cases

- Block spam webform submissions written in scripts your audience never uses.
- Require Latin-only input on an English-language contact form.
- Allow only Cyrillic (plus Latin) on a Russian/Ukrainian localized form.
- Permit Chinese, Japanese, or Korean scripts on region-specific forms.
- Enforce Arabic or Hebrew input on RTL-language submission forms.
- Apply one policy site-wide by enabling "Use it on all webforms".
- Apply per-form policies by adding the "Validate input characerset" handler.
- Combine multiple allowed sets (e.g. Latin + Greek) for bilingual forms.
- Reduce moderation load by rejecting obviously off-language garbage text.
- Keep names/addresses in an expected script for downstream systems.
- Turn validation on/off centrally without editing each webform.
- Limit free-text comment fields to a chosen script.
- Prevent homoglyph/mixed-script abuse in usernames collected via webform.
- Gate survey open-text answers to the languages you can process.
- Quickly disable all character validation by unchecking every set.
