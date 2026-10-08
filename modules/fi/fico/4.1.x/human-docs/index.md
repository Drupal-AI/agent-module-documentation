# Field formatter conditions — manual setup guide

**Field formatter conditions** (`fico`) lets you attach a "hide when…" rule to any field on
an entity's *Manage display*, so the field is conditionally removed from the rendered output.
It's the point-and-click way to say things like "hide this label when its value is empty",
"show this field only to editors", "hide this block on everything except the listed pages", or
"only the content author should see this field" — all without writing preprocess functions,
Twig conditionals, or extra view modes.

You set a condition per field, right where you configure the field's formatter. The chosen
condition (and its own little settings form) is stored in the display configuration, so it
travels with your exported config. At render time the module evaluates the condition and, when
it matches, removes the field from the output. It works both with ordinary formatter fields and
with **Display Suite** fields (Display Suite is a required dependency of this module).

The built-in conditions cover a lot of common needs — empty / non-empty target fields, a target
field containing (or not containing) a string, a boolean value, author / non-author, the current
user's role, an empty link title, date/time output, and path-based visibility with `*`
wildcards. Developers can add their own conditions by writing a small plugin.

> **Important:** this hides a field from *display only*. It removes the field from the rendered
> page; it is **not** a data-access or entity-access control. Don't rely on it to protect
> sensitive data — a hidden field's data may still be reachable through other channels (APIs,
> other view modes, etc.).

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Display Suite) with Composer
   and enable it.

## Where it lives in the admin menu

There is **no settings page**. Conditions are configured inside each field's formatter settings
on the entity's **Manage display** tab — for example **Structure → Content types → Article →
Manage display** (`/admin/structure/types/manage/article/display`).

## How to use it

### Add a condition to a regular field

1. Go to the entity's **Manage display** tab.
2. Click the gear (settings) icon for the field you want to conditionally hide.
3. Expand the **Conditions** section.
4. Pick a **Condition** from the dropdown — its own settings form appears.
5. Fill in the condition's settings, click **Update**, then **Save** the display.

Only conditions that apply to that field's type are offered in the dropdown.

### Display Suite fields

When a display uses a Display Suite layout, the same **Conditions** section appears on each
Display Suite field's settings, so DS-managed fields can be hidden the same way.

### The built-in conditions

| Condition | What it does |
|-----------|--------------|
| **Hide when target field is empty** | Hide this field when another chosen field has no value. |
| **Hide when target field is not empty** | The inverse — hide when the other field *does* have a value (handy for "summary vs. full body" layouts). |
| **Hide when target field contains a string** | Hide when a chosen text field contains a given string (with optional whole-word and case-sensitive matching). |
| **Hide when target field lacks a string** | The inverse string match. |
| **Hide on a boolean field's value** | Hide based on a boolean field being on/off. |
| **Hide from the author** | Hide the field from the content's author. |
| **Hide from non-authors** | Show the field only to the author. |
| **Hide when current user has role** | Hide from users in the selected role(s); optionally include or exclude the admin (user 1). |
| **Hide a link field with empty title** | Hide a link when its title text is empty. |
| **Hide on specific pages** | Show only on listed paths, or hide on all pages except listed ones, using `*` wildcards. |
| **Hide date/time output** | Conditionally hide a date/time value. |

### Combining conditions with view modes

Because visibility is stored per field per view mode, you can often replace a pile of bespoke
view modes with a single display plus a few conditions — for instance a "members only" field
hidden from anonymous roles, or an empty phone field suppressed so it doesn't render an empty
wrapper.

### For developers

Conditions are `FieldFormatterCondition` plugins. To add a project-specific rule, create a plugin
in your own module extending `FieldFormatterConditionBase` and set `$build[$field]['#access'] =
FALSE` in its `access()` method when the field should be hidden. See the sibling
[`agent/`](../agent/start.md) docs for the plugin contract and a full example.
