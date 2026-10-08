<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme hook & template

The module registers one theme hook via `hook_theme()`:

```
fullcalendar_block:
  variables:
    block_index: NULL
  template: fullcalendar-block.html.twig
```

`fullcalendar-block.html.twig` renders just the mount point:

```twig
<div{{ attributes }}></div>
```

`template_preprocess_fullcalendar_block()` adds the `fullcalendar-block` class and a
`data-calendar-block-index="<index>"` attribute. The JS (`js/fullcalendar_block.js`) finds each mount point
by that index and initialises a FullCalendar instance from the matching `drupalSettings.fullCalendarBlock[index]`.

Override by copying `fullcalendar-block.html.twig` into your theme (the index attribute must remain for the
JS to bind). Styling hook: `css/fullcalendar_block.css` (library `fullcalendar_block/fullcalendar`).
There are no field formatters or view modes — the calendar is entirely a block + attached JS.
