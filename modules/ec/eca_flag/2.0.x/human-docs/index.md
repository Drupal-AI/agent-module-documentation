# ECA Flag — manual setup guide

**ECA Flag** (`eca_flag`) connects the
[Flag](https://www.drupal.org/project/flag) module to
[ECA](https://www.drupal.org/project/eca) (Event-Condition-Action). Flag provides
the familiar "bookmark this", "report this", or "mark as read" primitive; ECA
provides no-code automation built on Drupal's event system. Joining them means that
**flagging and unflagging become events that can start an automated workflow**, and
**flagging becomes an action a workflow can perform** — all without custom code.

Concretely, the module contributes three kinds of building blocks to ECA:

- **Events** — react to *Insert flagging entity* / *Flag*, and to *Delete flagging
  entity* / *Unflag*. When one fires, ECA puts several items on the token stack:
  `flag` (the flag entity), `flagging` (the flagging entity), and `entity` (the
  flagged or unflagged entity). When an unflag affects many entities at once, you
  instead get a list called `flaggings`, each item holding those same tokens.
- **A condition** — asserts whether a given entity is flagged or not. (Other
  flag-related checks can be built with ECA's *Compare two scalar values* condition
  using tokens from the flag entities.)
- **An action** — retrieves one or many flagging entities for a given entity and
  places them on the token stack. Flag's own flag/unflag actions can also be used
  from ECA models.

**Watch out for loops.** An action that flags something can trigger an event that
flags something else, and ECA will happily follow the chain. A model that both
listens for and performs flag operations needs a condition to break the cycle —
test with a small dataset before enabling it on production.

The module has no routes, permissions, or settings of its own — everything is
configured in the ECA modeller. Its dependency ranges are deliberately wide: ECA
`^2 || ^3` and Flag `^4 || ^5`, plus PHP 8.1+ and core `^10.4 || ^11`. Because both
ranges span two majors, verify which ECA and Flag majors your site actually runs
before assuming plugin names and event signatures match this documentation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside ECA and Flag.

There is **no configuration page** for this module — it has no settings form. You
build flag-driven automation in the ECA modeller, described in "How to use it"
below.

## Where it lives in the admin menu

ECA Flag adds no admin page of its own. Your flags are defined on the Flag side at
**Structure → Flags** (`/admin/structure/flags`), and the models that react to
flagging are built in the ECA modeller at **Configuration → Workflow → ECA**
(`/admin/config/workflow/eca`).

## How to use it

1. Define a flag with the **Flag** module at **Structure → Flags** (for example a
   "Report" or "Bookmark" flag).
2. In the ECA modeller at **Configuration → Workflow → ECA**, create a model that
   listens for the *Flag* / *Unflag* event.
3. Use the `flag`, `flagging`, and `entity` tokens (or the `flaggings` list) in your
   conditions and actions — for example, email a moderator when content is reported,
   or add a bookmarked item to a queue.
4. If your model also performs flag/unflag actions, add a condition that prevents it
   from re-triggering itself, and test on a small dataset first.
