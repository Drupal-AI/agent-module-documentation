# Entity Reference Unrestricted Label — manual setup guide

**Entity Reference Unrestricted Label** (`entity_reference_unrestricted_label`) is
a field formatter for entity-reference fields that shows the **label of every
referenced entity to all users, regardless of entity access**. It is titled
**"Label (access bypass)"** — and the name is deliberate.

Core's own label formatter filters out referenced entities the current user cannot
view, so a user never sees the labels of content they lack access to. This module
does the opposite on purpose: it renders the labels of *all* referenced entities,
even ones the viewer is not allowed to access. That is genuinely useful in a narrow
set of cases — for example, an e‑learning platform that wants to show which exams
exist for a course even though the exam entities are only viewable by registered
users, or a magazine that needs to list the titles of subscriber‑only articles to
anonymous visitors.

**Please read this before enabling it.** Because it skips the access check
entirely, this formatter can **disclose information**. Entity labels are often
sensitive — an unpublished node's title, a private document's name, a restricted
user's name — and this formatter will leak them to anyone who can see the field.
The module is honest about this: its name and description announce the bypass, so
it is a documented footgun rather than a hidden bug. Use it **only** where you are
certain the referenced entities' labels are themselves non‑sensitive (for example a
public taxonomy), and **never** on a field that references access‑restricted
content whose titles should not be exposed. If in doubt, use core's
access‑respecting label formatter instead.

It has no third‑party dependencies and runs on Drupal 8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no site‑wide settings
form. You select the "Label (access bypass)" formatter on the field's *Manage
display*, described in "How to use it" below.

## Where it lives in the admin menu

Entity Reference Unrestricted Label adds no admin settings page. You use it from
**Structure → Content types (or any fieldable entity) → *(bundle)* → Manage
display**.

## How to use it

1. First, confirm the referenced entities' **labels are safe to show to everyone**
   who can see this field — this formatter will expose them regardless of access.
2. Go to the **Manage display** page of the entity that has the reference field
   (for example **Structure → Content types → Course → Manage display**).
3. Set that field's **Format** to **Label (access bypass)**.
4. Click **Update**, then **Save** the display.

Every referenced entity's label will now render for all users, including anonymous
ones, whether or not they could otherwise access the referenced entity.
