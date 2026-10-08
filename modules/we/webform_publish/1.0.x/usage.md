<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Publish gives a permission to publish webforms.

---

Webform Publish **adds a permission to publish/unpublish webforms** — separating the ability to change a
webform's published (open/available) state from full webform administration, so a role can toggle form
availability without editing the form. It depends on the Webform module, provides its own permissions, in the
Webform package.

Use it to delegate publish control of webforms. It is a forms/workflow feature and it is **access-relevant**: it
grants a specific permission to change a webform's published state — gate it to the roles that should control
form availability (publishing a form makes it accept submissions). It layers on Webform's own access. Configure
the publish permission.

---

- Add a publish/unpublish permission for webforms.
- Control webform availability by role.
- Separate publish from full admin.
- Depend on the Webform module.
- Provide its own permissions.
- Delegate publish control.
- GRANT a specific publish-state permission.
- Gate it to roles that should control availability.
- Know publishing a form makes it accept submissions.
- Layer on Webform's own access.
- Have no broad access role beyond permission.
- Configure the publish permission.
- Handle webform publishing.
- Publish webforms.
- Configure the permission.
- Toggle availability.
- Handle the workflow.
- Control forms.
- Restrict the permission.
- Provide webform publish control.
