<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Real Estate Manager (re_mgr) — agent orientation

Custom content entity types (src/Entity/{Estate,Building,Floor,Flat}) each with a *_type config
entity, shared `EntityBase`/`EntityBaseDataTrait`, and a custom `EntityAccessControlHandler`
mapping view/update/delete/create to `{op} {keyword} entity` permissions.

- Routes (`re_mgr.routing.yml`): admin overview pages gated by
  `access real estate manager administration pages`; `re_mgr.purge` gated by `administer module`;
  per-entity revision-delete forms gated by `administer {type} entity`.
- Autocomplete: `re_mgr.entity_autocomplete` has `_access: 'TRUE'`, handled by
  `RealestateManagerEntityAutocompleteController` (extends core `EntityAutocompleteController`).
  It validates `selection_settings_key` with `Crypt::hmacBase64(...Settings::getHashSalt())` +
  `hash_equals`, and the entity query uses `accessCheck(TRUE)`.
- Submodules: re_mgr_presentation, re_mgr_visualization (webform+media), re_mgr_demo.

Security review (sound): the anon autocomplete route mirrors core's signed-key + accessCheck
protection; access handler enforces per-type permissions; restricted admin perms flagged. No
finding.
