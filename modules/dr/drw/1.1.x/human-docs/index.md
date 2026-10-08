# Date Range Validation Widget — manual setup guide

**Date Range Validation Widget** (`drw`, sometimes called "Date Range Widget")
is a lightweight date field widget that adds **min/max validation** — including
handy **relative dates** like `today`, `-18 years`, or `+90 days`. It is perfect
for age verification, future‑only dates, event periods, and booking windows,
without writing any code.

The module is deliberately small: **no external dependencies and no
JavaScript**. All of its power lives in the widget's settings on a date field.
You choose the widget on your field's **Manage form display**, then set the
minimum and/or maximum allowed date directly in the widget's settings. You can
optionally turn on custom error messages and personalize them with the `@min`
and `@max` placeholders.

Because everything is configured per field, there is **no central settings
page**. You set restrictions on each field where you use the widget, so different
fields can enforce different rules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no global settings
form. Setup happens on each date field's **Manage form display**, described
below.

## Where it lives in the admin menu

The widget adds no admin page. You use it from **Structure → Content types →
*(your content type)* → Manage form display** (or the equivalent Manage form
display screen for any fieldable entity).

## How to use it

1. Add (or reuse) a **Date** or **Date range** field on your content type.
2. Go to that content type's **Manage form display**.
3. For your date field, choose **Date Range Widget** as the widget.
4. Click the ⚙️ (gear) to open the widget settings and set:
   - a **minimum** date and/or a **maximum** date, using an absolute date
     (`2024-01-01`) or a relative expression (`today`, `-18 years`, `+90 days`);
   - optionally **Enable custom error messages** to show your own validation
     text, using the `@min` and `@max` placeholders where you want the limits
     to appear.
5. Save. When someone submits the form, dates outside the allowed range are
   rejected with the standard (or your custom) message.

Common recipes: **age verification** with a maximum of `-18 years`;
**future dates only** with a minimum of `today`; an **event period** with
`Min: 2024-01-01`, `Max: 2024-12-31`; a **booking window** with `Min: today`,
`Max: +90 days`.
