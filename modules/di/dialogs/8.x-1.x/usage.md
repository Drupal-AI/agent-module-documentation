Dialogs For All! makes any internal Drupal link open in an AJAX dialog, modal, or off-canvas tray by adding magic `dialog` query-string parameters to the link.

---

The module implements `hook_link_alter()` and inspects each rendered link's query for a `dialog` parameter. When present, it rewrites the link into a Drupal AJAX dialog trigger: it adds the `use-ajax` class, sets `data-dialog-type` (default `dialog`, or `modal`), optionally `data-dialog-renderer` (e.g. `off_canvas`, `off_canvas_top`), and `data-dialog-options` (a JSON blob of jQuery UI dialog options such as width, height, title, show/hide effects). It attaches the `core/drupal.dialog.ajax` library plus any additional effect libraries the link requests (validated against Drupal's library discovery). All parameters under the `dialog` namespace are stripped from the final URL so they never appear in the emitted `href`. A special empty `destination` query parameter is filled with the current path, which is handy for links to forms. There is no admin UI, no routes, no permissions, and no configuration: behaviour is driven entirely by how you author the link's query string. This is convenient for menu links, field-rendered links, and links produced by text filters (pair it with the `renderfilter` module for filtered body text).

---

- Turn a menu link into a modal: `/node/add/page?dialog=modal`.
- Open any internal page in a non-modal dialog with the short form `internal:/some/path?dialog`.
- Make an "Edit" or "Add" admin link pop as a modal instead of a full page load.
- Open content in an off-canvas tray: `?dialog[renderer]=off_canvas`.
- Open an off-canvas tray docked to the top: `?dialog[renderer]=off_canvas_top`.
- Combine type and renderer: `?dialog[type]=modal&dialog[renderer]=off_canvas`.
- Set explicit dialog dimensions via array syntax: `?dialog[options][height]=100&dialog[options][width]=200`.
- Set dialog options via a JSON string: `?dialog[options]={"height":100,"width":200}`.
- Give the dialog a custom title: `?dialog[options]={"title":"Look at this!"}`.
- Add a show effect: `?dialog[options][show]=fadeIn&dialog[options][duration]=5000`.
- Add a hide effect with easing: `?dialog[options]={"hide":{"effect":"fadeOut","duration":15000,"easing":"linear"}}`.
- Load extra jQuery UI effect libraries: `?dialog[libraries]=core/jquery.ui.effects.pulsate|core/jquery.ui.effects.explode`.
- Pass libraries as an array instead of a pipe-delimited string: `?dialog[libraries][]=core/jquery.ui.effects.explode`.
- Auto-fill the return destination for a form link: `?dialog&destination` (empty destination becomes the current page).
- Present a "quick view" of a node or entity from a listing without leaving the page.
- Open contextual admin forms (block config, taxonomy term edit) as modals from custom links.
- Use with menu items so site editors get modal workflows without writing any JavaScript.
- Render links inside filtered text as dialogs by combining with the `renderfilter` contrib module.
- Keep URLs clean: dialog parameters are removed from the final `href`, so shared links stay tidy.
- Let contributed modules extend the available dialog types beyond `dialog` and `modal`.
- Let contributed modules register additional renderers beyond the built-in off-canvas ones.
