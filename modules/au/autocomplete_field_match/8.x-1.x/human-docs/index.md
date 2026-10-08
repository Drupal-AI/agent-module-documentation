# Autocomplete Field Match — manual setup guide

**Autocomplete Field Match** (`autocomplete_field_match`) lets an
entity-reference autocomplete match on a field other than the entity's title.
By default, autocomplete suggestions are found by matching what you type against
the referenced entity's label. With this module you can instead (or additionally)
match on another field — for example a product SKU or a user's email address.

It is a content-editing / field feature. The suggested entities still follow
normal entity access — the autocomplete respects access checks — and the module
has no access-control role of its own. It depends on core's **Field** and
**Field UI** modules.

Configuration is per widget: you choose which field the autocomplete matches in
the field's widget settings. There is no central settings page, so this guide has
two parts: an overview (this page) and installation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Autocomplete Field Match adds no central settings page. You configure which
field to match in the widget settings on **Structure → Content types →
(your type) → Manage form display** (or the Manage form display tab of any other
fieldable entity).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Manage form display** for the entity type/form mode that has your
   entity-reference field.
3. Open the field's autocomplete widget settings (the gear icon).
4. Choose which field the autocomplete should match against (for example SKU or
   email) instead of only the title.
5. Click **Update**, then **Save**.

Editors can now find the referenced entity by typing a value from that field.
