# Field Widget Add More — manual setup guide

**Field Widget Add More** (`field_widget_add_more`) brings the friendly "Add another
item" button — and per-row "Remove" buttons — to fields that have a **fixed, limited
cardinality greater than one**. Core only offers that incremental add/remove
experience for *unlimited* fields; a field capped at, say, 3 values always renders
all three widget rows at once. This module restores the nicer UX for capped fields:
editors start with a single row and add more, one at a time, up to the field's limit
— at which point the "Add" button disappears.

Importantly, it never touches your field **storage** or cardinality. The cap stays
exactly what you set; the module only changes how the *edit form* behaves, showing
rows incrementally instead of all at once. It works with **any widget type**,
because it wraps the complete widget form rather than a specific widget plugin. Turn
it on for a capped "phone numbers" field, a "up to 5 links" field, a capped
entity-reference field — anything with a fixed cardinality above 1 — and it cuts the
clutter of empty rows while still enforcing the limit. Adding and removing rows
happens over AJAX, so the page never reloads, and the first field of a new row is
focused automatically.

There is no settings page, no permission, no service, and no Drush command. You
enable the feature **per field, per form mode**, right on the bundle's **Manage form
display** page — the module simply adds a "Show add more button" checkbox to the
widget's settings, and only for fields whose cardinality qualifies (a fixed number
above 1; it is hidden for cardinality 1 and for unlimited fields, which already have
core's own Add-more). The choice is stored as a third-party setting on the form
display, so it travels with your exported configuration. It has no dependencies
beyond Drupal core and ships no submodules.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no admin page of its own. You turn the feature on from the **Manage form
display** page of any bundle, for example **Structure → Content types → *[type]* →
Manage form display**
(`/admin/structure/types/manage/<type>/form-display`).

## How to use it

1. Enable the module.
2. Make sure the field you want has a **fixed cardinality greater than 1** (set on
   the field's storage settings). Cardinality 1 and unlimited fields are not
   eligible.
3. Go to the bundle's **Manage form display** and click the gear/cog icon on that
   field's row.
4. Tick **Show add more button**, click **Update**, then **Save**.

The edit form for that bundle now starts the field with a single row, shows an **Add
another item** button (which disappears once the field reaches its cap), and gives
each row a **Remove** button. Turn it off again by unticking the box and saving.

If you manage configuration as code, the setting appears on the
`core.entity_form_display.<entity>.<bundle>.<mode>` config as
`third_party_settings.field_widget_add_more.add_more: true` under the field's
component, so you can also toggle it there:

```php
$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node', 'article', 'default');
$c  = $fd->getComponent('field_phones');            // a cardinality-N (N > 1) field
$c['third_party_settings']['field_widget_add_more']['add_more'] = TRUE;
$fd->setComponent('field_phones', $c)->save();
```
