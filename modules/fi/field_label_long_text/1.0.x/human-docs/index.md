# Field Label Long Text — manual setup guide

**Field Label Long Text** (`field_label_long_text`) is a small, lightweight
module that lifts Drupal's built‑in limit on **field label length**. By default,
Drupal caps a field label at 128 characters — fine for "Start date," but too
short when a field genuinely needs a long label or a full‑sentence question, as
you often find in surveys and detailed forms. This module lets you raise that
limit to whatever length you need.

It can also **switch the label input from a single‑line text field to a
textarea**, so when you're writing a long, multi‑line label you have room to see
and edit the whole thing comfortably rather than squinting at a narrow box.

Both behaviours are controlled from a simple settings form. The module affects
only the label's length and input type — it changes nothing about how field data
is stored or who can access it. It depends only on core's Field module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   for choosing the label input type and character limit.

## Where it lives in the admin menu

Field Label Long Text provides a settings form at the route
`field_label_long_text.admin_settings` (reachable under **Configuration**, at a
path such as `/admin/config/field_label_long_text`). Set your preferred label
input type and character limit there — see [Configuration](configuration/index.md).

## How to use it

1. Install and enable the module.
2. Open the module's settings form (see [Configuration](configuration/index.md))
   and choose whether field labels should use a **text field** (with a raised
   character limit) or a **textarea**, and set the character limit if applicable.
3. Save. From then on, the field label input on field edit forms honours your
   choice — a longer character limit, and/or a textarea for multi‑line label
   text.
