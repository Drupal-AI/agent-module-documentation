# Flag Conditional Confirm — manual setup guide

**Flag Conditional Confirm** (`flag_conditional_confirm`) adds a new link type to
the [Flag](https://www.drupal.org/project/flag) module called **Conditional
Confirm Form**. It gives you finer control over *when* a flag asks the user to
confirm their action.

Out of the box, a Flag link type either always shows a confirmation form or never
does. This module lets you have it both ways depending on the situation. The
canonical example is a flag that should require confirmation when a user
**unflags** content but not when they **flag** it — so a careless click can't
quietly undo something, while flagging stays a single tap.

You can also drive the decision with your own logic. If you choose the **Custom
condition** option, the module looks for implementations of
`hook_flag_conditional_confirm_confirmation_required()`; when that hook returns
`TRUE`, the confirmation form is shown. This is a developer‑oriented escape hatch
for confirmation rules that depend on the entity, the user, or anything else your
code can inspect.

The module has no access‑control role of its own — flagging access still follows
the Flag module's configuration. It simply changes the confirmation behaviour of
the link.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with the Flag module).

There is **no central settings page** — you choose the Conditional Confirm Form
link type on each individual flag, so there is no separate configuration chapter
in this guide.

## Where it lives in the admin menu

You configure this per flag, in the Flag module. Go to **Structure → Flags**
(`/admin/structure/flags`), create or edit a flag, and choose **Conditional
Confirm Form** as its **Link type**. An additional setting then appears for
choosing the condition (including the **Custom condition** option described
above).

## How to use it

1. Go to **Structure → Flags** and add or edit a flag.
2. Set the flag's **Link type** to **Conditional Confirm Form**.
3. Configure the condition — for example, require the confirmation form only when
   unflagging, or select **Custom condition** to let your own
   `hook_flag_conditional_confirm_confirmation_required()` decide.
4. Save the flag.
