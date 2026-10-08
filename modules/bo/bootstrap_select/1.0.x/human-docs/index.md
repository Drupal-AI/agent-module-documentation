# Bootstrap select picker — manual setup guide

**Bootstrap select picker** (`bootstrap_select`) renders ordinary option/select
form fields with the **bootstrap-select** JavaScript widget. Instead of a plain
HTML `<select>`, the field becomes a styled Bootstrap dropdown that can include a
search box and multi-select styling — handy when a list is long or should match a
Bootstrap-themed site.

It changes presentation only. The options, the stored data, and access are all
untouched — the field still works exactly as before, it just looks and behaves
like a nicer dropdown. It applies to option field types, and you turn it on by
selecting the bootstrap-select widget on the field.

This is a lightweight, single-purpose widget module: enable it, then pick the
widget on the fields where you want the enhanced select.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no central settings page. You choose the bootstrap-select widget per
field under **Structure → Content types → (your type) → Manage form display**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage form display** for the content type (or other entity) that
   has the option/select field.
3. Change that field's widget to **bootstrap-select** and save.
4. Use a Bootstrap-based theme so the styled dropdown matches the rest of the
   site. The field now renders as a searchable, styled Bootstrap dropdown.
