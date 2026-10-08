<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
tac_lite_create is a submodule of tac_lite that hides taxonomy term options a user is not allowed to use when they add or edit a node — controlling which terms appear on content forms, not who can create content.

---

Where the parent `tac_lite` module uses Drupal's node_access system to control who can view/update/delete existing nodes, `tac_lite_create` works purely through `hook_form_alter()` on the node form. For each tac_lite scheme that has **"Visibility on create and edit forms"** enabled (a `tac_lite_create` flag it adds to the scheme configuration at `/admin/config/people/tac_lite/scheme_<n>`) — or that grants `update` — it computes the terms the current user is allowed to use (via `_tac_lite_user_tids()`) and removes the disallowed term options from `select`, `radios`, and `checkboxes` taxonomy widgets on the node form. Users with the `administer tac_lite` permission are exempt and see all terms. It does **not** control which content types a user may create (use core role permissions for that), only which vocabulary terms are offered. The submodule has no configuration page, permissions, services, routes, or config schema of its own; its single setting lives inside the parent's `tac_lite.settings` config as `tac_lite_config_scheme_<n>.tac_lite_create`. The default value of a term the user cannot use is preserved (not stripped) so existing values on an edited node are not lost.

---

- Show content authors only the taxonomy terms they are permitted to tag content with.
- Hide "Private" or "Staff only" terms from users who may not use them on the node form.
- Restrict a Department term field so each editor only sees their own department's terms.
- Complement tac_lite view/update grants with matching create-form term visibility.
- Keep editors from accidentally assigning categories they lack access to.
- Enable per-scheme via the "Visibility on create and edit forms" checkbox.
- Automatically apply form-term visibility for schemes that grant update permission.
- Limit term options on select, radio, and checkbox taxonomy widgets on node forms.
- Let administrators (administer tac_lite) continue to see every term.
- Avoid losing a node's existing term value even if the editor may not use that term.
- Align content-creation term choices with taxonomy-based access rules.
- Prevent editors from tagging content into categories they cannot see.
- Pair with the parent's per-user grants so individual users get individual term choices.
- Reduce editorial mistakes by removing irrelevant term options from forms.
- Scope taxonomy vocabularies referenced by node fields to the controlling vocabularies.
- Provide create-time term filtering without writing custom form_alter code.
- Support multiple schemes, each independently toggling form-term visibility.
- Work on any node bundle whose fields reference a tac_lite-controlled vocabulary.
- Keep the access model in one place (tac_lite schemes) for both viewing and tagging.
- Give partners a curated term list matching the projects they work on.
