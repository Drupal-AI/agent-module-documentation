# Address Country Unknown — manual setup guide

**Address Country Unknown** (`address_country_unknown`) lets an **Address** field
be filled in without forcing a country to be chosen. Drupal's standard Address
widget really wants a country selected before it will accept the rest of an
address — but sometimes the country is genuinely unknown, or simply not required
for what you're collecting. This module provides alternative Address **widgets and
formatters** that allow an empty or unknown country value.

It's a focused enhancement to the **Address** module (a required dependency) with
no content and no access rules of its own. There's nothing to configure globally —
you just choose its widget and formatter on the fields where you want an optional
country.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page. You choose its widget and formatter per field under
**Structure → Content types → [your type] → Manage form display** (for the input
widget) and **Manage display** (for how the saved address is shown).

## How to use it

1. Make sure your content type (or other entity) has an **Address** field.
2. Go to **Manage form display** for that content type and set the Address field's
   widget to the one provided by this module (the widget that allows an empty /
   unknown country).
3. Go to **Manage display** and, if you want addresses with no country to render
   cleanly, set the field's format to this module's matching formatter.
4. Save. Editors can now save that address field without picking a country.
