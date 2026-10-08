# Metatag Simple Widget — manual setup guide

**Metatag Simple Widget** (`metatag_simple_widget`) provides a streamlined,
author-friendly field widget for the [Metatag](https://www.drupal.org/project/metatag)
module. The standard Metatag "Firehose" widget exposes dozens of meta tag fields,
which can overwhelm content authors who aren't familiar with HTML meta tags. This
module offers an alternative **"Simplified meta tags form"** widget that focuses on
just the most commonly used fields — meta title and meta description (the essentials
authors actually edit).

It also includes a **"show default values"** setting. Turning it off hides default
token values such as `[node:title] | [site:name]` from the form, so authors aren't
confused by Drupal's tokens or entity structures — they simply see clean, empty
fields to fill in.

There are **no global settings or configuration pages**. All behaviour is controlled
per field, on the form display, by switching the Metatag field's widget. It depends
on the Metatag module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Metatag dependency.

There is **no configuration page** — you switch to the simplified widget on a
field's form display, described in "How to use it".

## Where it lives in the admin menu

The module adds no admin page. You use it entirely from **Structure → Content types
→ *(your type)* → Manage form display**, where it appears as a widget option for the
Metatag field.

## How to use it

This assumes you already have a Metatag field on the bundle.

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content types → *(your content type)* → Manage form
   display**.
3. Find the **Metatag** field and click the gear icon (⚙️) next to its widget
   selector.
4. Change the widget to **Simplified meta tags form**.
5. Optionally toggle whether to **show default values** like `[node:title]`, then
   click **Update** and **Save**.

Authors editing that content type will now see the simplified title/description form
instead of the full Metatag interface.
