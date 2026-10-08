# Allowed Text Format Field Widget — manual setup guide

**Allowed Text Format Field Widget** (`allowed_text_format_field_widget`) lets a
field's widget decide **which text formats** are offered on that field, instead
of always offering every format the current user is allowed to use.

Here is the problem it solves. Drupal's text-format selector normally shows the
intersection of the formats that exist and the formats the user has permission to
use. That is a *permission* question, not a *content-modelling* one — so an editor
who holds **Full HTML** sees it offered on every text field on the site, including
ones where it makes no sense: a short summary that should be plain text, a
caption, a fixed-format teaser. Nothing stops them picking it, and once one
caption contains a table and inline styles, the design has to cope. This module
lets you say, per field, "this field is a caption, so only offer the plain-text
format here" — regardless of what the author may use elsewhere.

**Keep one distinction clear, because it is easy to misread:** this module
narrows *what is offered*, not *what is permitted*. The real security boundary is
still the text format's own filter chain and the "use text format X" permissions.
A user who may use Full HTML still may. And anything that writes to the field
outside this widget — a migration, JSON:API, a webform handler, a second form
display — is unaffected. So treat it as content-model enforcement and editorial
guidance, never as a control that prevents someone using a format they hold the
permission for.

This is a release candidate (1.1.0-rc1), so test it before relying on it in
production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central settings page. You configure it on **Structure → Content
types → (your type) → Manage form display**, inside a text field widget's own
settings, where you choose the allowed formats for that field.

## How to use it

1. Go to **Manage form display** for the entity bundle.
2. Open the settings (the cog icon) of a text/formatted-text field's widget.
3. Choose which text format(s) that field's widget should offer, then **Update**
   and **Save**.
4. Editors filling in that field now see only the formats you selected — while
   their underlying permissions remain exactly as before.
