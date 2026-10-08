dBug for Drupal is a developer utility that dumps any PHP variable as a colored, collapsible HTML table (a port of ColdFusion's `cfdump`), returned as a render-array-friendly markup string instead of echoing directly.

---

The whole module is one class, `Drupal\dbug\Dbug`, plus an asset library (`dbug/dbug`, the `js/dBug.js` toggling script and `css/dBug.css` styling). You call the static helper `Dbug::debug($var)` to get an HTML string that renders arrays, objects, resources and XML as nested, clickable tables — far more readable than `var_dump()` or `print_r()`. Arrays and objects are shown key-by-key with recursion detection (`*RECURSION*`), objects also list their methods as `[function]`, booleans render as `TRUE`/`FALSE`, and database/GD/XML resources get specialized tables. Unlike the original PHP dBug it does not `echo`; it returns markup so you embed it in a render array and attach the `dbug/dbug` library for the collapse/expand JS and CSS. An optional second `$forceType` argument (`"array"`, `"object"`, `"xml"`) forces how the value is interpreted — required when dumping an XML string or file — and a third `$bCollapsed` argument renders the tables collapsed by default. It defines no routes, permissions, config, plugins, or Drush commands; it is purely a code-level debugging aid for developers.

---

- Dump a complex array in a custom controller and see it as a nested, collapsible table instead of raw `print_r()`.
- Inspect an entity or config object's structure while developing, with each property clickable to expand/collapse.
- Render a readable dump of a service or object, including a list of its methods (`[function]`).
- Debug a render array mid-build by embedding `Dbug::debug($build)` output in the page.
- Show booleans clearly as `TRUE`/`FALSE` rather than the empty/1 output of `var_dump()`.
- Dump an XML string or file as a structured table using the `"xml"` forceType argument.
- Force a value to be treated as an array or object with the second `$forceType` parameter.
- Render dumps collapsed by default (third `$bCollapsed` argument) when inspecting large structures.
- Detect and label recursive references in nested data as `*RECURSION*` instead of looping forever.
- Inspect a database result resource as a table of rows and fields.
- Dump a GD image resource to see its width, height and color count.
- Attach the `dbug/dbug` library so the dump tables get their colored styling and toggle behavior.
- Return debug output as markup so it can be placed in a block, page, or form element during development.
- Quickly compare two variables side by side by dumping both into the same render array.
- Add temporary in-page diagnostics to a custom module without writing HTML by hand.
- Give a nicer developer experience than `kint`/`devel` when you only need a single dependency-free dump helper.
- Inspect the shape of an API response array before writing code against it.
- Debug form state values by dumping `$form_state->getValues()` as a readable table.
- Log-free, on-page inspection of variables during theme or preprocess development.
- Present a collapsible dump of nested configuration to understand its keys.
- Use it as a lightweight, zero-config alternative to full debugging suites on a dev environment.
- Dump the contents of a queue item or job payload while debugging background processing.
- Show an object graph with methods to understand an unfamiliar class quickly.
- Embed a dump into a custom `/admin` diagnostic page for a module you are building.
