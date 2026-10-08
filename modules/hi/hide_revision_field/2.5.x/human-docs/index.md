# Hide Revision Field — manual setup guide

**Hide Revision Field** (`hide_revision_field`) cleans up your content editing
forms by hiding the core **"Revision log message"** field — the little textarea
where editors are supposed to note what changed. On many sites that field is just
noise: people never fill it in, but it still takes up space on every add/edit
form. This module lets you hide it (and optionally the whole revision tab) while
still creating revisions normally.

It works by replacing the core widget for the revision log field with its own
configurable widget on every revisionable entity type — nodes, media, taxonomy
terms, and any custom types other modules add. Because of that, all its behavior
is stored in the standard **form display** config for each bundle, right on the
"Manage form display" page. There is no separate settings screen to hunt for.

You control visibility three ways, and they can be combined: **per entity type
and bundle** (hide it on Articles but keep it on Pages), **by permission** (only
show it to trusted editors who hold the "access revision field" permission), and
**per user** (let individual editors opt in or out from their own profile). You
can also give the field a default message and tweak the textarea's rows and
placeholder.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — hide or show the field per bundle on
   "Manage form display", the widget settings field by field, and the two
   permissions.

## Where it lives in the admin menu

There's no dedicated settings page. You configure the field on each bundle's
**Manage form display** tab — for example **Structure → Content types → Article →
Manage form display**
(`/admin/structure/types/manage/article/form-display`) — by opening the settings
gear on the **Revision log message** row. This requires the core **Field UI**
module. The module's two permissions live at **People → Permissions**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage form display** page for the bundle you want to tidy up.
3. Open the settings gear on the **Revision log message** row and untick **Show
   the revision log message field** (optionally also hide the whole revision
   tab).
4. Update, then save the form display.

Revisions are still created — you've only hidden the message field from the form.
See [Configuration](configuration/index.md) for permission-based and per-user
options.
