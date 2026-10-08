# Anonymous author — manual setup guide

**Anonymous author** (`anonymous_author`) adds a new **field type** that lets
anonymous (logged‑out) visitors record who they are against content they create.
The field stores three things: a **name**, an **email**, and a **notify**
checkbox. A typical use is letting guests leave their name and email on the content
or comments they submit, and — if they tick "notify" — being emailed when their
content is later updated or receives a comment.

Importantly, this is plain author *metadata*: the stored name and email are free
text, **not** a real Drupal user account. The module does not reassign content
ownership and does not impersonate an account. It also does not grant anyone
permission to create content — whether an anonymous visitor may create the node or
comment in the first place is still governed entirely by core's normal
create permissions.

The field's widget is careful about who sees the inputs: on a **new** entity the
name/email fields appear only to anonymous users, and on an **existing** entity
only to users who hold the **Edit anonymous author fields** permission (so
moderators can correct submissions). Notification emails go to the visitor‑supplied
address, which is unvalidated — treat it like any user‑submitted content and guard
against abuse upstream if that matters to you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the field to a content or comment
   type and set the widget and formatter.

## Where it lives in the admin menu

There is no central settings page. You use the module by adding an **Anonymous
author** field to an entity type through **Manage fields**, then configuring its
**widget** (Manage form display) and **formatter** (Manage display) — see
[Configuration](configuration/index.md). Permissions are set under **People →
Permissions** (the **Edit anonymous author fields** permission).
