# Multiple Fields Remove Button — manual setup guide

**Multiple Fields Remove Button** (`multiple_fields_remove_button`) adds a per-item
**Remove** button to multi-value field widgets on Drupal edit forms. Drupal core lets
editors *add* rows to a multi-value field and reorder them, but there's no way to
delete a single value inline — you have to blank it out and save. This module fills
that gap: each row of a multi-value field gets its own Remove button, with the removal
handled smoothly over AJAX.

It works the moment you enable it — there is **nothing to configure**. Once on, a
Remove button appears automatically on every widget row of any field whose cardinality
is not exactly 1 (both **unlimited** and **fixed** multi-value fields), as long as the
field type and widget are supported. For unlimited fields the button deletes the row
and renumbers the rest; for fixed-cardinality fields it clears the row's value and
shifts the remaining values up. A small stylesheet gives the button a trash-can icon.

The module ships a sensible built-in list of supported field types (text, string,
email, link, numbers, telephone, date/datetime, entity reference, address, and more)
and deliberately skips widgets that already handle their own removal — such as the
Media Library widget, Inline Entity Form, and Entity Browser — so it never
double-adds a control. Its only dependency is core's **Field** module.

There is no settings form. If you need to fine-tune which fields get a button (add a
custom field type, skip a type or widget, or restrict to named fields only), that's
done by developers with four `hook_*_alter()` hooks, documented for an AI coding agent
in the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it;
   that's the entire setup.

## How to use it

1. **Enable the module** — that's all the setup there is:

   ```bash
   drush en multiple_fields_remove_button -y
   ```

2. **Edit any content** with an unlimited or fixed multi-value field (a
   multi-value Tags reference, a repeating Link field, and so on). Each existing row
   now shows a **Remove** button. Click it to delete that single value; the widget
   re-renders over AJAX, keeping the remaining rows correctly ordered.

There is no per-field toggle in the UI — the button appears everywhere a supported
multi-value field is shown. Widgets that manage their own removal (Media Library,
Inline Entity Form, Entity Browser, and similar) are left untouched by design.

To change *which* fields get a button — extend support to a custom field type, exclude
a specific type or widget, or limit the button to an explicit list of field names —
developers implement one of the module's four alter hooks; see the
[`agent/`](../agent/start.md) docs for the hook signatures and examples.
