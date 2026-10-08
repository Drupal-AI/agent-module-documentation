<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Form Overrides replaces the default page titles and submit-button labels on node create, edit, and delete forms, set globally or per content type, with optional token replacement.

---

Rather than writing a `hook_form_alter` for every content type, this module moves those common tweaks into configuration. A global settings form (`/admin/config/content/node-form-overrides`, permission `administer content types`) sets default values for the create/update button labels, create/update page titles, and the delete-form title and description — the shipped defaults use node tokens like `Add new [node:content-type:name]`. Each content type's edit form also gains a "Label Overrides" tab (via `hook_form_node_type_form_alter` and third-party settings) with an "Override global defaults" checkbox; when ticked, the per-type values take precedence, otherwise the global config is used (`_node_form_overrides_get_setting`).

At render time, `hook_form_node_form_alter` swaps the submit `#value` and form `#title` for new vs. edit operations, and `hook_form_node_confirm_form_alter` swaps the delete-form title and description. If the optional Token module is installed the values are passed through the token service (`replacePlain` for titles/buttons, `replace` for the delete description, with node — and group, when present — context); without Token the raw string is used. All configuration is gated by `administer content types` (a trusted admin permission), the entity builder saves only a whitelisted set of keys, and the only markup injection (the delete-form description) comes from admin-entered config — so there are no anonymous or untrusted-input paths.

---

- Rename the "Save"/"Update" node submit buttons site-wide
- Set custom create/edit page titles for node forms
- Customise the delete-confirmation form title and description
- Override labels globally as defaults across all content types
- Override labels per content type via the "Label Overrides" tab
- Toggle a content type between global defaults and its own values
- Use tokens like `[node:content-type:name]` in titles and labels
- Include group tokens on group-context node forms
- Give editors clearer, action-specific button text
- Match button/title wording to a content type's purpose
- Localise/adjust confirmation wording for deletes
- Provide friendlier "Are you sure…" delete prompts
- Configure defaults once at `/admin/config/content/node-form-overrides`
- Restrict configuration to users with `administer content types`
- Fall back to global config when a per-type value is left blank
- Replace repetitive `hook_form_alter` code with config
- Set distinct create vs. update titles per content type
- Add the token browser link when the Token module is enabled
- Keep overrides in exported configuration for deployment
- Standardise node-form UX wording across a site
