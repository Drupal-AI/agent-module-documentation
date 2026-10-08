Views Accordion adds a "jQuery UI accordion" Views style plugin that renders a view's rows as a collapsible accordion, using the first field of each row as the clickable header/trigger.

---

Views Accordion integrates the jQuery UI Accordion widget into Views as a display style (format) plugin with the id `views_accordion`. When you set a view's Format to "jQuery UI accordion", each result row becomes one accordion section: the first (non-excluded) field is used as the section header/trigger, and the remaining fields make up the panel that expands when the header is clicked. The style requires the row style to be **Fields** and at least two fields, and it depends on the core `views` module plus the contributed `jquery_ui_accordion` module (which supplies the jQuery UI Accordion library). Its options form exposes the jQuery UI accordion settings: which row starts open (a specific row, none, or random), whether sections are collapsible (all can close at once), an animation easing effect and duration, `heightStyle` (auto/fill/content), the trigger event (click/mouseover), optional header icons, and "disable if only one result". When grouping is enabled you can instead use the group header as the accordion trigger. The style attaches its own JS behavior and drupalSettings, plus the jQuery UI effects core library when a non-default easing effect is chosen, and renders through the `views_accordion_view` theme hook / `views-accordion-view.html.twig` template. It provides no permissions, routes, services, or admin settings form of its own — all configuration lives inside the view.

---

- Display a view of FAQ entries as an accordion where the question is the header and the answer expands below.
- Turn a list of team members into an accordion with the name as trigger and bio as the panel.
- Build a collapsible product-feature list from a view without writing custom JavaScript.
- Use the first field (e.g. a title) of each row as the accordion header/trigger automatically.
- Require the Fields row style and at least two fields so headers and panels are distinct.
- Set a specific row (Row 1, Row 2, …) to start open when the accordion first loads.
- Start every section closed by choosing "None" for the open row (with Collapsible enabled).
- Open a random section on each page load using the "Random" start option.
- Allow all sections to be collapsed at once by enabling the Collapsible option.
- Choose an animation easing effect (swing, linear, easeInOutQuart, easeOutBounce, etc.) for open/close.
- Set the animation duration in milliseconds, or disable animation entirely with "None".
- Control panel sizing with `heightStyle` (auto, fill, or content).
- Trigger section expansion on hover instead of click by setting the event to Mouseover.
- Show jQuery UI header icons for closed vs open sections, or hide icons entirely.
- Customize the closed/open header icon classes (e.g. `ui-icon-triangle-1-e` / `ui-icon-triangle-1-s`).
- Hide the accordion when a view returns fewer than two results using "Disable if only one result".
- Use a Views grouping field's group header as the accordion trigger instead of the first row field.
- Render categorized content as grouped accordions (group header opens each category).
- Present documentation sections or policy clauses as expand/collapse panels driven by a view.
- Nest accordion views inside a page; the plugin scopes each by the view's DOM id.
- Theme the accordion output by overriding the `views-accordion-view.html.twig` template.
- Deploy the accordion configuration as part of the view's exported config (config schema included).
- Keep only one section open at a time (default jQuery UI accordion single-open behavior).
- Build a timeline or changelog where each dated entry expands to show details.
- Show a schedule or agenda where each session header expands to reveal its description.
