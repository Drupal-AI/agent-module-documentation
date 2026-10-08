<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Landing Content Editor ships a role configuration for people who build landing pages.

---

A page-building suite raises a permissions question that a plain content type does not. Building a landing page means creating content, placing blocks, editing layouts and often creating reusable blocks — a set of permissions that, granted carelessly, adds up to a great deal of control over how the site renders.

This submodule provides a configured role for that job, so the permissions arrive as a considered set rather than being assembled by someone granting whatever makes the error message go away.

**Review what it grants before using it.** A shipped role is a starting point matched to the suite's assumptions, not a policy decision for your site. Layout Builder permissions in particular are broad — `configure any layout` is very different from `configure editable layouts`, and the difference decides whether an editor can restructure pages they do not own. Read the role's permission list against how your site is actually organised.

Also worth noting: `vlsuite_demo` depends on this, so evaluating the demo installs the role.

---

- Give landing page builders a configured role.
- Grant Layout Builder permissions deliberately.
- Avoid assembling permissions ad hoc.
- Review what a shipped role grants.
- Distinguish any-layout from editable-layout permissions.
- Restrict who may restructure pages.
- Control who may create reusable blocks.
- Separate page building from site administration.
- Assign the role to an editorial team.
- Audit Layout Builder permissions.
- Adapt the role to a site's structure.
- Understand what the demo module installs.
- Document the role for a team.
- Remove the role if unused.
- Plan editorial permissions for a page builder.
