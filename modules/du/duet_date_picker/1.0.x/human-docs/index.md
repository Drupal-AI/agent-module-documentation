# Duet Date Picker — manual setup guide

**Duet Date Picker** (`duet_date_picker`) provides a date field **widget** built on
the [Duet Date Picker](https://github.com/duetds/date-picker)
(`duetds/date-picker`) — an accessible, framework‑agnostic date‑picker web component
well known for its strong accessibility and internationalization. When you assign
this widget to a date field, it replaces the default date input with Duet's picker,
giving editors a keyboard‑friendly, screen‑reader‑friendly way to choose dates.

It's a pure input‑experience module. The value it stores is an ordinary Drupal date,
identical to what the standard widget would save, so switching to (or away from) this
widget doesn't change your data — only how people enter it. It has no bearing on
access control or permissions, and it has no site‑wide settings of its own.

Because everything happens at the field level, there is nothing to configure on a
central admin page: you simply pick Duet Date Picker as the widget on a date field's
form display. It works on Drupal 9, 10, and 11 and pulls in no other Drupal module
dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
turn it on per field from **Manage form display**, described in "How to use it"
below.

## How to use it

1. Make sure you have a **Date** (or Datetime) field on some content type, or add
   one under **Structure → Content types → *(your type)* → Manage fields**.
2. Go to that content type's **Manage form display**
   (**Structure → Content types → *(your type)* → Manage form display**).
3. Find your date field and, in its **Widget** column, choose the **Duet Date
   Picker** widget from the drop‑down.
4. Click **Save**.

From then on, editing that content type shows the Duet picker for that field. The
saved value remains a standard Drupal date, so any formatters, Views filters, or
other tooling that read the field keep working unchanged.
