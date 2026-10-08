<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Translation Access replaces core's coarse "translate any entity" permission with per-entity-type, per-bundle, per-operation translation permissions that are additionally gated by the set of languages assigned to the acting user.

---

Content Translation Access extends Drupal core Content Translation so that the right to **create, edit (translate) or delete a translation** can be granted per **entity type + bundle** and is only effective for the **languages assigned to the current user**. It generates dynamic permissions of the form `cta create translation <type> <bundle>`, `cta translate <type> <bundle>` and `cta delete translation <type> <bundle>`, plus a global `cta translate any entity` escape hatch, and enforces them from `hook_entity_access` / `hook_entity_create_access` / `hook_entity_translation_(create_)access` / `hook_node_access`. The "assigned languages" set comes from pluggable **LanguageProvider** plugins (a plugin type this module defines); the bundled `content_translation_access_user` submodule ships a provider that reads a per-user `field_access_languages` field. The module also overrides the node translation overview controller to hide operation links for languages the user is not assigned, adds a `cta_language_select` field widget that only offers allowed languages, and adds a `CreateInLanguage` validation constraint. The access idiom is grant-only and fail-closed: every handler returns `AccessResult::allowed()` only when both an assigned language and the matching permission are present, and otherwise returns `AccessResult::neutral()` (never a spurious `forbidden()` and never a fail-open `allowed()`); it also honours `bypass node access` and `cta translate any entity`.

---

- Let a French translator create/edit only French translations of articles, not other languages.
- Grant translation rights per content type (e.g. translate articles but not pages).
- Grant per operation: allow creating translations but not deleting them.
- Replace the all-or-nothing core "translate any entity" permission with granular control.
- Assign each editor a personal set of languages via the user submodule's `field_access_languages`.
- Give a lead translator `cta translate any entity` to bypass the per-bundle checks (still needs an assigned language).
- Let a superuser with `bypass node access` translate everything unconditionally.
- Hide translate/edit/delete links in the node translation overview for languages a user is not assigned.
- Offer only permitted languages in the language `<select>` widget when creating content.
- Reject saving an entity in a language the owner is not allowed to create in (validation constraint).
- Build a custom "assigned languages" source (e.g. from a role, org unit or group) by adding a LanguageProvider plugin.
- Combine several LanguageProvider plugins; the union of their languages is the user's assigned set.
- Delegate translation of specific bundles to regional editorial teams.
- Keep translators out of the source/default-language edit workflow they are not assigned to.
- Enforce translation access consistently across the UI, the create form and entity validation.
- Support both nodes (full hook_node_access integration) and any other content-translation-enabled entity type.
- Let a role translate content without giving it the global core node "edit any" permission.
- Restrict who may edit a user's assigned-languages field via the submodule's field-access hook.
- Optionally hide non-translatable fields on translation forms unless a user holds `show entity non translatable fields`.
- Model multilingual editorial workflows where language, not just role, decides who may act.
- Scope translation duties in large multilingual sites so teams only touch their own languages.
