# Select Registration Roles — manual setup guide

**Select Registration Roles** (`select_registration_roles`) adds a role chooser to
the user registration form, showing only the roles an administrator has approved
for self-selection — with an optional approval step per role. It lets new users
tell you at signup which audience they belong to, without opening the door to
arbitrary role assignment.

Sites with distinct audiences often want to know, right at registration, which one
someone belongs to: student or staff, buyer or supplier, member or volunteer.
Drupal's default answer is that roles are granted by an administrator — correct as
a security posture, but awkward as a workflow, because every registration then
waits on someone to act. This module offers the middle ground: an administrator
picks which roles appear as options on the registration form, a registering
visitor picks one or more, and roles you flag as needing approval leave the new
account **blocked** until an administrator acts, while unflagged roles activate the
account immediately. It depends only on core's **User** module.

Because this module lets a visitor influence their own roles, the security of the
whole arrangement rests on **which roles you choose to offer**. Never expose a role
that carries `administer permissions`, `administer users`, `administer nodes`, or
anything else that can grant further permissions — a role placed on the form is
available to anyone who can reach `/user/register`. In testing, a forged role that
was never offered on the form is rejected (Drupal's Form API refuses submitted
values that are not in the list of options), so a visitor cannot simply post a role
you did not offer. Worth knowing, though: that defence comes from Drupal core's
form validation rather than from the module re-checking its own allow-list, so keep
your judgement about which roles to offer as the real control.

This module is **maintenance-only** for new development. There is also a minor
known bug worth being aware of — see the configuration guide's note on the
registration-form warning.

This guide is written for a **human** working through the admin UI. If you want
terse references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which roles appear on the
   registration form and which require approval, and the safety rules to follow.

## Where it lives in the admin menu

The settings form is under **People → Registration Role Set By Admin** (config
route `select_registration_roles.roles_set_by_admin`). The role chooser it
produces appears on the public registration form at `/user/register`.
