<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Role description lets each user role carry an explanatory description and shows it beside the role checkboxes on the account form — so whoever assigns roles knows what each one actually means.

---

Drupal roles have a machine name and a label and nothing else, which is fine while a site has three roles and painful once it has fifteen. "Content approver", "Editor", "Publisher" and "Reviewer" are indistinguishable from their labels alone, and the person assigning them — often an administrator who did not design the permission scheme — has no cue short of comparing permission grids. This module keeps a free-text description per role in one config object (`role_description.settings`, a `role_id => description` map) and surfaces it where the decision is made: two `hook_form_alter` implementations in `includes/role_description.form.inc` set each string as the `#description` under the matching role checkbox — on core's account form (`user_form`) and, when `role_delegation` is enabled, on its delegated role-change widget and standalone assign form. Descriptions are edited at `/admin/people/role-description` (form `SettingsForm`, gated by core's `administer permissions`, the same permission that already governs roles), which lists every role except `anonymous` and `authenticated`. Because roles are configuration, so are the descriptions — they export with `drush cex`, and `role_description.config_translation.yml` plus the `config_translation` dependency registers them for translation (though core cannot yet translate the sequence through the UI, so translations go in per-language override files). There is no stable release yet; the newest is `1.0.0-rc2`, core requirement `^10 || ^11`.

---

- Explain what each role means on the account form.
- Help administrators assign the right role.
- Distinguish similarly named roles at a glance.
- Document a permission scheme where it is actually used.
- Add guidance to role checkboxes without patching core.
- Translate role descriptions for a multilingual site.
- Reduce mis-assigned roles.
- Onboard a new administrator to the role model.
- Describe a role's scope in plain language.
- Show role guidance to delegated admins via role_delegation.
- Keep role documentation next to the roles themselves.
- Export descriptions together with site configuration.
- Clarify the difference between editor and publisher.
- Support a site that has grown to many roles.
- Reduce questions about which role to grant.
- Document why a given role exists.
- Give a delegated admin the context they need to assign roles.
- Improve accuracy of user administration.
- Set descriptions programmatically from an install profile or update hook.
- Keep role guidance current as the role set changes.
