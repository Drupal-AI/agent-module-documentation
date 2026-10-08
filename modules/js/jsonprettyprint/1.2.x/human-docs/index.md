# JSON Pretty Print — manual setup guide

**JSON Pretty Print** (`jsonprettyprint`) provides a **field formatter** that
displays text fields containing JSON with proper indentation and line breaks.
Instead of showing a stored JSON string as one long unreadable line, the formatter
renders it neatly indented so it is easy to read on the page.

It is a pure content-display feature. It changes only how a field is *displayed* —
it does not alter the stored value, and it has no access-control role. It is handy
whenever a (long) string or text field holds JSON that a site builder or content
editor needs to read at a glance, such as a stored API response, a configuration
blob, or debugging output.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

This module has **no configuration page** of its own — there is no admin settings
form. You apply it per field on **Manage display**, described under "How to use
it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the display settings for the entity whose field you want to format —
   **Structure → Content types → *(your type)* → Manage display** (or the
   equivalent Manage display tab for any other fieldable entity).
3. Find the string / long-text field that stores JSON, and set its **Format** to
   **JSON Pretty Print**.
4. Save the display. When that entity is viewed, the field's JSON is shown indented
   and readable rather than as a single line.
