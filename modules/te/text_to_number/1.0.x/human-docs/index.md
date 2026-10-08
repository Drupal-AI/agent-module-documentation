# Text To Number — manual setup guide

**Text To Number** (`text_to_number`) provides an alternate form widget for
integer fields. Instead of forcing numeric-only input, it lets editors type text
such as "Missing" or "No value" and stores that as **NULL** rather than coercing
it to `0`.

The problem it solves is a subtle data-quality one. A standard number widget
turns a blank or non-numeric entry into `0`, which is then indistinguishable
from a genuine zero — bad news for a field where "not answered" and "zero" mean
different things (survey answers, counts, measurements). This module's widget
renders a plain text field with a "Missing" placeholder and normalises the input
when the form is submitted: an empty string is stored as empty, the literal
`Missing` (or `missing`) is stored as NULL, and any other value is stripped down
to digits before being saved. So a field can hold a real number, a genuine zero,
or an explicit "unknown" — three distinct states.

The module is small: it adds the widget and nothing else. There is no settings
page, no routes, no permissions, and no services — the only option is a single
"Size of textfield" setting on the widget itself. It works with the core
**integer** field type and runs on Drupal 8, 9, 10 and 11 with no dependencies
beyond core.

One thing to know before you use it: the digit-stripping is not a
negative-number-aware parse. A minus sign is removed along with any other
non-digit character, so the widget suits **non-negative** counts where telling
"unknown" apart from zero is what matters. It is listed as minimally maintained
(maintenance fixes only).

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The module has no menu or settings page of its own — you apply it per field on
the form display:

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage form display** screen of the content type that has the
   integer field.
3. For that integer field, choose the **Text to Number** widget. Optionally set
   the **Size of textfield** to control how wide the input is.
4. Save.

Now, on the create/edit form, editors can type `Missing` (stored as NULL) or a
number (stored as the integer) into that field.
