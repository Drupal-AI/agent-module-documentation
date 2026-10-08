# Field Suggestion — manual setup guide

**Field Suggestion** (`field_suggestion`) speeds up content entry by offering
editors a list of **often‑used values for a field** so they can pick one instead of
retyping it every time. When the same values keep coming up on a field, the module
collects them and presents them as suggestions that auto‑fill the field on
selection. Editors can **pin** and **unpin** suggestions to keep the most useful
ones handy, and the feature can be **ignored** on a per‑field basis where it isn't
wanted.

It's an editorial‑efficiency tool: it doesn't change what a field stores or who can
access it, it just reduces repetitive typing and helps reuse common values
consistently.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   its dependencies, and enable it.

There is **no central settings page**. You control suggestions per field and grant
the relevant permissions, described in "How to use it" below.

## How to use it

1. Under **People → Permissions**, grant the module's permissions to the
   appropriate roles:
   - **Administer field suggestion** — manage the feature.
   - **Ignore field suggestion** — turn suggestions off on a field.
   - **Pin and unpin field suggestion** — pin the most useful values.
2. Configure suggestions on the fields where reuse of common values helps.
3. When editing content, editors pick a suggested value to auto‑fill the field,
   and can pin/unpin values (with the right permission) to curate the list.
