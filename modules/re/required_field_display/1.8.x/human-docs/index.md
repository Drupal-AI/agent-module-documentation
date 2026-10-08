# Required Field Display — manual setup guide

**Required Field Display** (`required_field_display`) fills a small but real gap in
Drupal's Field UI. The **Manage fields** listing shows each field's label, machine
name, and type — but not whether the field is *required*. This module adds that
missing signal, marking the required fields right on the Manage fields screen so
you can see at a glance which fields are mandatory.

It is purely an administrative display aid. It changes nothing about how fields
behave or validate — it only styles the existing Field UI table — which makes it
completely safe to add and just as safe to remove. There are no settings, no
permissions, and no dependencies.

It is most useful before a migration or a form redesign, where "which fields are
mandatory" is one of the first things a content-model audit needs to know.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no configuration page — it works the moment you enable it.

## Where it lives in the admin menu

It adds no admin page of its own. The effect appears wherever the Field UI's
**Manage fields** table is shown — for example **Structure → Content types →
*(your type)* → Manage fields**. Required fields are simply marked there.

## How to use it

There is nothing to configure. Enable the module, then open any bundle's **Manage
fields** screen and you will see which fields are required highlighted directly in
the table. When you no longer need the reminder, you can safely uninstall the
module with no side effects.
