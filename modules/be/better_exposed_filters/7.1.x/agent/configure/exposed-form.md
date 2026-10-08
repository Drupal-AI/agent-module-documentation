# Enable BEF on a view & configure widgets

No global admin page. BEF is turned on **per view display** in the Views UI.

## Turn it on
Edit a view (`/admin/structure/views/view/<id>`) → in the display's **Exposed form**
section set **Exposed form style** to **Better Exposed Filters** (exposed form plugin
id `bef`, class `Plugin/views/exposed_form/BetterExposedFilters`). Then click its
**Settings** to open the BEF options form.

## What you can configure
- **General**: auto-submit (refresh view on change), hide the submit button, allow
  hiding the submit button, secondary/"advanced" collapsible option group, reset button.
- **Per exposed filter**: choose a widget — Default (select), Checkboxes/Radio buttons
  (`bef`), **Links** (`bef_links`), **Single on/off** (`bef_single`), **Hidden**
  (`bef_hidden`), **Number** (`bef_number`), **Sliders** (`bef_sliders`), **Date picker**
  (`bef_datepicker`), **Datetime picker** (`bef_datetimepicker`). Widget-specific options
  include select all/none links, soft limit + more/less labels, scrollable container,
  collapsible fieldset, slider min/max/step, rewrite option labels.
- **Per exposed sort**: Default, Links (`bef_links`) or Radio buttons (`bef`).
- **Per exposed pager**: Default, Links (`bef_links`) or Radio buttons (`bef`).

## Where it is stored
All settings live inside the display's `exposed_form.options.bef` config (schema:
`config/schema/better_exposed_filters.*.schema.yml`). Because it is part of the view,
it exports/deploys with the view — no separate config entity, `drush config:export`
captures it. Config schema keys: `bef.general`, `bef.filter.<field>`, `bef.pager`,
`bef.sort.<field>`.
