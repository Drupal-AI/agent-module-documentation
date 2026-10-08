# Double field — manual setup guide

**Double field** (`double_field`) adds one field type whose every value is
actually **two values** — a `first` and a `second` — bundled together as a single
field. It's the tidy answer to all the little "pairs" that come up when modelling
content: a spec name and its value ("Weight | 4.2 kg"), a person and their role
("Jane Doe | Director of Photography"), a question and an answer, a link label and
its URL, a rating verdict and a numeric score. Rather than creating two separate
fields and keeping them in step by hand, you add one Double field and get both
halves managed together, including on multi‑value fields where each item is its
own pair.

What makes it flexible is that each of the two subfields is **independently
typed**. On the storage form you pick a type for `first` and a type for `second`
from ten choices — boolean, text, long text, integer, float, decimal, email,
telephone, date, and URL. That choice decides how each half is stored, validated,
edited, and displayed. So you could pair a plain text label with a real email
address (rendered as a clickable `mailto:` link), or a constrained select list
with a bounded number.

On the edit form, each subfield gets an appropriate sub‑widget — a text box, a
checkbox, a number field, a range slider, a color picker, a date picker, or a
select/radios list when you constrain it to allowed values — and you can lay the
two out side by side. On display, four formatters cover the common shapes: an
unformatted list, an HTML list (`ul`, `ol`, or a `dl` definition list), a
collapsible **Details**/accordion (first value as the summary, second as the
body), and a **Table** with optional column headers and a row‑number column.

Double field has **no settings page of its own** — everything is configured on
the field itself, just like any Drupal field. That's why this guide has no
separate configuration page; the "How to use it" section below covers the whole
workflow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Double field adds **no admin page**. The field type appears wherever you add
fields — **Structure → Content types → *your type* → Manage fields → Add field** —
and its widget and formatter are configured on the same content type's **Manage
form display** and **Manage display** tabs.

## How to use it

### 1. Add a Double field

On any fieldable entity, go to **Manage fields → Add field** and pick **Double
field**. If you want a repeatable list of pairs (a spec table, opening hours),
set the field's cardinality to *unlimited*.

### 2. Storage settings — choose the two subfield types

On the storage settings, choose a **type for the first subfield** and a **type for
the second**, each from: Boolean, Text, Text (long), Integer, Float, Decimal,
Email, Telephone, Date, or Url. This is the key decision — it controls everything
downstream. Note that these types are **locked once the field holds data**, so
plan them before you start entering content.

### 3. Field settings

Per subfield you can set a **label**, mark it **required** (independently — one
half can be optional while the other is mandatory), set **min/max** bounds on
numeric types, choose **On/Off labels** for booleans, and turn on **list** mode to
restrict entries to a set of **allowed values** (a key/label list). Allowed values
turn the sub‑widget into a select list or radio buttons.

### 4. The edit widget

On **Manage form display**, the field uses the **Double field** widget. For each
subfield you choose a sub‑widget suited to its type — for example a text box,
email, telephone, URL or **color picker** for text; a **number field**, plain box
or **range slider** for numbers; a checkbox for booleans; a date picker for dates;
and select/radios when list mode is on. You can also set label placement,
placeholder text, textarea size, and an **inline** toggle to place the two inputs
side by side.

### 5. Choose a display formatter

On **Manage display**, pick one of four formatters:

- **Unformatted List** *(default)* — the two values in a simple list.
- **HTML List** — a `ul`, `ol`, or `dl` definition list (with `dl`, the first
  value becomes the term and the second its definition).
- **Details** — a collapsible accordion using the first value as the summary and
  the second as the body (set it open or closed by default).
- **Table** — a table with optional column labels and a row‑number column, ideal
  for a long repeatable field.

Every formatter lets you **hide** a subfield entirely, render email/telephone/URL
values as **links**, format numbers (thousands and decimal separators, scale),
pick a **date format**, and show a list's key instead of its label.

### 6. Reading and writing values in code

There's no single `value` — an item has a `first` and a `second`:

```php
$node->field_specs = ['first' => 'Weight', 'second' => 4.2];
$node->field_specs->appendItem(['first' => 'Material', 'second' => 1.0]);
$first  = $node->field_specs->first;
$second = $node->field_specs->second;
```

### Importing with Feeds

Double field ships a Feeds target plugin, so you can import paired data from a CSV
and map the columns to the `first` and `second` properties.
