# Views Conditional — manual setup guide

**Views Conditional** (`views_conditional`) adds a single Views field that
outputs different content depending on an **IF / THEN / ELSE** rule. You pick an
earlier field in the same row, compare it against a value with an operator (equals,
greater than, contains, is empty, and so on), and supply the text to show when the
condition is true — and, optionally, the text to show when it is false. It is the
easy way to turn a raw value into a human‑readable label, badge, or flag right
inside a view.

The module works entirely **inside the Views UI**: there is no admin settings
page, no permissions, and no separate configuration entity. Everything is
configured per‑field when you build a view, and the settings are stored as part of
the view's own configuration. It depends only on core **Views**.

One thing to keep in mind: the conditional field can only read fields that are
**rendered before it**, so you must place it *after* every field it references in
the field list. The fields it tests are usually set to *Exclude from display* so
that only the conditional output appears.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no admin settings page — all configuration happens per field
inside a view, described in *How to use it* below.

## Where it lives in the admin menu

Views Conditional has **no admin menu item and no settings form**. It appears
only inside the Views editor, as a field you can add to any view: in the *Add
fields* dialog it is listed as **Views: Views Conditional** under the *Views*
group.

## How to use it

1. Edit a view and go to its **Fields** section.
2. Add the fields you want to test **first**. Set each of those source fields to
   **Exclude from display** so only the conditional output is shown.
3. Add the **Views: Views Conditional** field (it appears near the bottom of the
   field list). Because it has no query of its own, place it **after** every field
   it references.
4. In its settings form:
   - **If this field…** — pick which earlier field to test (only fields above this
     one are listed).
   - **Is…** — choose the comparison operator: equals, not equals, greater/less
     than (with or‑equal variants), empty, not empty, contains, does not contain,
     and string‑length comparisons.
   - Enter the **value** to compare against.
   - **Then output this…** — the text to show when the condition is true.
   - **Otherwise, output this…** — optional text to show when it is false.
5. Both the compare value and the output text accept **replacement tokens**:
   `{{ field_machine_name }}` for any field above this one in the list, plus
   `DATE_UNIX` and `DATE_STAMP` for the current time. Options also let you
   translate the Then/Or text and strip HTML tags from the output.

Typical uses include showing a "Free" badge when a price is 0, "In stock" /
"Out of stock" text from a quantity field, or an "Expired" vs "Active" label by
comparing a date field against `DATE_UNIX`.
