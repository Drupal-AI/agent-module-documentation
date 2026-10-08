# Fallback Formatter — manual setup guide

**Fallback Formatter** (`field_fallback_formatter`) is a field **formatter** that
renders a different, fallback field whenever the field you are displaying has no
value. Instead of showing a blank space where an empty field would be, the
display falls back to another field so the output always shows something
meaningful. It works both in the classic **Field UI → Manage display** and in
**Layout Builder**.

The distinction from a *field*‑level fallback is that this operates purely at
**display time**: it decides, as the page is rendered, whether to show the main
field's formatted output or the fallback field's. The underlying stored data is
untouched.

Access is respected carefully, and the rules are worth understanding:

- If the current user cannot access the *main* field at all, neither it nor its
  fallback is rendered — nothing shows.
- If the user can see the main field but it is empty, the fallback is rendered
  (provided the user can access the fallback and it has a value).
- If the fallback field is empty or the user cannot access it, nothing is
  rendered.

In short, the fallback never becomes a way to reveal a field a user could not
otherwise see, and an empty‑everywhere situation renders nothing rather than an
empty wrapper.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no site‑wide configuration page** for this module. You select the
formatter and its fallback field on your entity's display, described below.

## Where it lives in the admin menu

Fallback Formatter adds no admin page of its own. You use it from **Structure →
Content types → *(type)* → Manage display** (`/admin/structure/types/manage/{type}/display`),
or from a Layout Builder layout, by choosing the fallback formatter for a field.

## How to use it

1. Go to the **Manage display** tab for your entity (or edit a Layout Builder
   layout).
2. For the field you want to display, choose the **Fallback** formatter from the
   *Format* column.
3. Open the formatter's settings (the gear icon) and choose the **fallback
   field** — the field whose value should be shown when the main field is empty —
   along with how each field should itself be formatted.
4. Save. On rendered pages, the main field shows when it has a value; when it is
   empty, the fallback field's formatted value shows instead, subject to the
   access rules above.
