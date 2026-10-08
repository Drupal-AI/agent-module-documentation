Carbon impact evaluator estimates and displays the CO2 footprint of a Drupal site's node pages, per byte and per visit, using the Green Web Foundation CO2.js library.

---

The module ships a block that renders a floating "carbon impact" badge on node pages. When a visitor loads a page, client-side JavaScript (js/carbon-impact-evaluator.js) measures the page's transfer size with the browser Performance API and feeds it to the CO2.js library, which supports two models: OneByte ("Per Byte") and Sustainable Web Design ("Per Visit", which additionally weighs first-vs-return visit ratios, green-host status, and the datacenter's grid intensity via an ISO alpha-3 country code). The result is formatted to three decimals and colour-graded A+ through F. An administrator enables one or both models, a green-host flag, and the datacenter country in the settings form at /admin/config/system/carbon-impact-evaluator/settings. Per-node visit tallies and the most recent per-byte/per-visit figures are recorded in a custom co2_info database table (maintained via node insert/delete/view hooks and two AJAX endpoints), and a summary table of all tracked pages is available to administrators at /carbon-impact-evaluator/table. The module tracks node pages only; admin paths and the module's own paths are excluded.

---

- Show site visitors an at-a-glance CO2 badge (A+ to F grade) on each content page.
- Estimate per-page carbon emissions using the Sustainable Web Design model (gCO2 per visit).
- Estimate per-page carbon emissions using the OneByte model (gCO2 per byte transferred).
- Enable both calculation models simultaneously to compare methodologies.
- Report a lower footprint when the site is hosted on a certified green host by toggling the Green Host setting.
- Refine SWD estimates by specifying the datacenter country (ISO alpha-3 code) so grid carbon intensity is factored in.
- Give sustainability/ESG teams a rough, in-browser measure of a page's environmental impact.
- Raise editor and stakeholder awareness of how page weight (images, scripts) drives emissions.
- Track how many total visits, first visits, and return visits each node has received since install.
- Review a consolidated admin table of every tracked page with its visit counts and latest CO2 figures.
- Compare the carbon footprint of heavy landing pages against lean content pages.
- Demonstrate the effect of image optimization or asset reduction by watching a page's grade improve.
- Add a visible sustainability commitment signal to a marketing or corporate site.
- Support "green web" or digital-sustainability initiatives with a lightweight, no-external-service tool.
- Provide a teaching/demo aid for explaining web carbon accounting to clients.
- Surface the badge only on public content pages while keeping it off admin and report screens.
- Place the badge block in any theme region via Block layout, styling it with the shipped CSS.
- Automatically create a tracking row when a node is created and remove it when the node is deleted.
- Use the browser's real transfer sizes (including reloads) rather than static estimates.
- Store the latest computed emissions per node for later reporting without a third-party analytics service.
- Localize the badge labels (per Byte / per Visit / g CO2) through Drupal's translation system.
