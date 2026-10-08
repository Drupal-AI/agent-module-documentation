<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flexible descriptions provides a central UI to add, edit, and translate the description (help text) shown under fields on entity forms, without editing each field's settings.

---

The module defines a `flexible_description` config/content entity and stores an override description keyed by an entity-type|bundle identifier. Descriptions are edited inline through HTMX-driven controller routes (GET to render a mini form, POST to add/update, plus cancel), and access to those routes is checked per bundle via dynamically generated permissions ('manage flexible descriptions in {entity_type}|{bundle}'). A settings form (entity.flexible_description.settings, perm 'administer flexible_description') and a management form (perm 'manage flexible descriptions') drive configuration. It depends on the single_content_sync module (pulled via Composer) and ships an optional flexible_descriptions_sync submodule. Descriptions can be language-specific, so multilingual sites can localize help text. Use it to keep help text consistent and editable by non-developers.

---

- Give content editors editable help text on fields without touching field config.
- Centralize all field descriptions for a content type in one screen.
- Translate field help text per language on multilingual sites.
- Delegate description editing to a role via per-bundle permissions.
- Update guidance copy on forms without a config deployment.
- Add descriptions to fields that shipped without any help text.
- Standardize help text wording across similar bundles.
- Fix confusing default descriptions reported by editors.
- Provide contextual instructions on complex node forms.
- Maintain description text as content rather than code.
- Edit descriptions inline with HTMX without full page reloads.
- Grant 'manage flexible descriptions in article|node' to a sub-editor only.
- Keep media and node form help text consistent from one tool.
- Roll out new field guidance to authors quickly.
- Localize onboarding hints for regional editorial teams.
- Audit and clean up field help text across the site.
