# ECA Group — manual setup guide

**ECA Group** (`eca_group`) integrates
[ECA](https://www.drupal.org/project/eca) (Events-Conditions-Actions), Drupal's
no-code automation framework, with the
[Group](https://www.drupal.org/project/group) module. It adds Group-related
building blocks to ECA so your automation can both react to and act on group
activity without custom code:

- **Events** — for group activity such as membership changes and group content
  operations.
- **Conditions** — checks such as whether a user is a member of a group or holds a
  particular group role.
- **Actions** — operations such as adding or removing members.

With these in place you can automate common group workflows: onboarding a new
member, sending notifications when membership changes, or managing group roles as
part of a larger process.

Because some of these actions change **group membership and roles**, review any ECA
model that does so — an automation touching membership can grant access, and a
mistake could grant it to the wrong people. Otherwise the module is
straightforward: it has no settings form of its own, and you configure everything
in the ECA modeller. It depends on ECA (`^2 || ^3`) and Group (`^3 || ^4`), and
targets Drupal 10.4+ / 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside ECA and Group.

There is **no configuration page** for this module — it has no settings form. You
build group automation in the ECA modeller, described in "How to use it" below.

## Where it lives in the admin menu

ECA Group adds no admin page of its own. Groups and group types are configured on
the Group side at **Groups** / **Configuration → Group** (`/admin/group`), and the
models that react to group activity are built in the ECA modeller at
**Configuration → Workflow → ECA** (`/admin/config/workflow/eca`).

## How to use it

1. Set up your group types and groups with the **Group** module first.
2. In the ECA modeller at **Configuration → Workflow → ECA**, create a model that
   listens for a Group event (for example a membership change).
3. Add the group conditions (membership/role checks) and actions (add/remove
   members, and so on) this module provides.
4. **Review models that change membership or roles** before enabling them, and test
   that they cannot grant unintended access, since these actions affect who can do
   what inside a group.
