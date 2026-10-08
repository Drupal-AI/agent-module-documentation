# Ajax Callbacks Field Formatter — manual setup guide

**Ajax Callbacks Field Formatter** (`ajax_callback_field_formatter`) is a display
formatter for **Link** fields that renders the link as an AJAX‑callback trigger
instead of an ordinary navigation link. When a visitor clicks it, the link fires
an AJAX callback — an in‑place update — rather than loading a new page. That lets
you build interactive link behaviors on a piece of content without writing custom
form/render code.

You use it by choosing it as the formatter for a Link field on an entity's
**Manage display** tab, just like any other field formatter. It is purely a
display concern: it has no content of its own and no access‑control role. The
AJAX callback it triggers runs with the **current user's** privileges, so it does
not grant any access the user wouldn't otherwise have.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. Like all field formatters, you select it per
field under **Structure → (content type) → Manage display**
(`/admin/structure/types/manage/{type}/display`) — or the equivalent Manage
display tab for any entity that has a Link field.

## How to use it

1. Add or find a **Link** field on the entity type you want.
2. Go to that entity's **Manage display** tab.
3. For the Link field, choose the **Ajax Callbacks** formatter (rather than the
   default link formatter).
4. Save. The field's links now trigger an AJAX callback / in‑place update instead
   of navigating to a new page.

Because the callback runs with the current user's privileges, no extra access is
granted — the usual field and entity access rules still apply.
