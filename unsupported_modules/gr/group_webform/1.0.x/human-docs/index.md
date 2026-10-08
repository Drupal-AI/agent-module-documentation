# Group Webform — manual setup guide

**Group Webform** (`group_webform`) integrates the
[Webform](https://www.drupal.org/project/webform) module with the
[Group](https://www.drupal.org/project/group) module (version 3.x) by exposing each
webform as a Group relation type. That means webform *submissions* can be owned by,
and access‑controlled through, a Group — so one group's form submissions stay
separate from another's.

Under the hood, the module derives one relation plugin per webform (targeting the
`webform_submission` entity type). Each relation declares that access is handled by
Group core, which installs per‑group permissions for submissions and folds group
membership into the submission's access check. In other words, viewing, creating,
editing, and deleting a group's submissions is gated by the group role permissions
Group generates — not by custom access code in this module. When you create a new
webform, it becomes available as a relation right away, without a manual cache
clear.

It's a rewrite of the older contrib `group_webform` for Group 3.x, originally built
for the LocalGov Microsites distribution — which makes it a good fit for
multi‑tenant setups where each site or group needs its own forms and its own
submissions kept private.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Webform and Group.

There is **no central settings page**. You configure Group Webform per group type,
by adding webforms as relations and granting group permissions — described below.

## How to use it

1. Make sure Webform and Group 3.x are set up, with at least one group type and the
   webform(s) you want to use already created.
2. On a group type, install the **Group webform** relation for each webform you
   want to attach. (The cardinality is fixed at one submission per relation, which
   is intentional.)
3. Grant the generated per‑group create / view / update / delete
   webform‑submission permissions to the appropriate group roles.
4. Optionally grant the **access group_webform overview** group permission, which
   gates a per‑group Webforms overview link so group admins can see their group's
   forms.

From then on, group members can submit the attached webforms scoped to their group,
and each group's submissions are isolated from the others by Group's access system.
