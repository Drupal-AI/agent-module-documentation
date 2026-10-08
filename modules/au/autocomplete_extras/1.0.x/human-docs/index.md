# Autocomplete Extras — manual setup guide

**Autocomplete Extras** (`autocomplete_extras`) gives site builders more control
over how Drupal's autocomplete widgets behave. Out of the box, an autocomplete
field's behaviour (such as how many characters you must type before suggestions
appear, and how many results are returned) is fixed. This module lets you tune
those on a per-field basis.

It is a field-widget enhancement. It changes only the editing experience of
autocomplete fields — it adds no content and has no access-control role.

The settings are not a central page; they live on each field's widget
configuration in **Manage form display**. Because of that, this guide has two
parts: an overview (this page) and installation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Autocomplete Extras has no central settings page. Its per-field settings appear
in the widget configuration on **Structure → Content types → (your type) →
Manage form display** (or the Manage form display tab of any other fieldable
entity).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Manage form display** for the entity type and form mode where your
   autocomplete field appears.
3. Open the field's widget settings (the gear icon).
4. Adjust the extra options this module adds — such as the minimum number of
   characters before suggestions appear, result limits, and matching behaviour.
5. Click **Update**, then **Save**.

The settings apply to that field instance only, so different autocomplete fields
can behave differently.
