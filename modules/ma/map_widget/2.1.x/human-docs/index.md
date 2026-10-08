# Map Widget — manual setup guide

**Map Widget** (`map_widget`) gives Drupal's `map` field items a proper editing
interface. A `map` field stores an associative array — a set of arbitrary
key/value pairs — which is handy for developers but normally has no usable form
widget at all, leaving site builders with nothing to put on the edit form. This
module supplies the missing piece: a repeatable key/value table where editors type
their own keys and values.

Under the hood it provides two things. The first is a form element (`#type:
map_associative`) that renders and validates a set of key/value rows. The second
is a **field widget** that puts that element onto any field whose items are maps —
you just select it on the field's form display. The widget's settings export
cleanly as configuration, and a small stylesheet tidies up the rows.

Because the underlying form element is a plain, reusable element, developers can
also drop it straight into custom forms wherever they need an arbitrary key/value
input — not just on map fields.

There is no configuration page, no permissions and no Drush commands: you enable
the module and choose the widget on a field's **Manage form display** screen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Map Widget adds no pages of its own. You choose it as the widget for a `map` field
on the field's **Manage form display** screen (Structure → Content types →
*type* → Manage form display, or the equivalent for other entity types).

## How to use it

1. Have a field whose items are stored as a **map** (associative array).
2. Go to the entity's **Manage form display** screen — for example **Structure →
   Content types → Article → Manage form display**.
3. Find the map field and set its **Widget** to the Map Widget
   (associative-array) widget, then save.
4. Adjust any widget settings offered (via the gear/settings icon next to the
   widget), then save the form display.

Now, when editors add or edit that entity, the field shows a key/value table:
they type a key and a value on each row and can add more rows as needed.

A couple of things worth knowing:

- **Keys are whatever the editor types.** The stored value is a plain associative
  array with no fixed schema for its contents, so if downstream code expects
  particular key names, validate or normalise them in code.
- **The form element is reusable.** Developers can use the `map_associative`
  element directly in custom forms — see the [`agent/`](../agent/start.md) docs
  for the exact snippet.
