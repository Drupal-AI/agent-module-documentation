EcoIndex adds an `ecoindex` field type and an in-browser preview that measures a node's EcoIndex score and grade, so contributors can see and store the environmental impact of their content.

---

EcoIndex is an unofficial Drupal integration of the Green IT association's EcoIndex algorithm (the GreenIT-Analysis `ecoIndex.js` library). It provides a dedicated `ecoindex` field type that stores five values on content — score (0–100), letter grade (A–G), DOM element count, HTTP request count and total transferred size in KB — together with a matching widget and two field formatters. Contributors attach the field to a content type, then open a per-node preview route (`/node/{node}/ecoindex`) that renders the page as an anonymous visitor and runs the EcoIndex computation in the browser; the results are cached in the browser's `localStorage` and copied into the node's edit form so they can be saved on the entity. A settings form lets a site set a minimum acceptable score, warn contributors when a page falls below it, and optionally block publishing of content that does not reach the threshold (enforced by a validation constraint). It also integrates with the Diff module to compare EcoIndex values across revisions.

---

- Track the EcoIndex score and grade of individual nodes as structured field data.
- Add an "environmental impact" field to a content type via *Manage fields* using the EcoIndex field type.
- Display a node's EcoIndex score on its full view using the EcoIndex score formatter.
- Display a node's letter grade (A–G) on teasers or listings using the EcoIndex grade formatter.
- Show the score/grade column in a Views listing of content to compare pages at a glance.
- Let contributors measure a page's eco impact from the node edit form via the "Refresh EcoIndex score" link.
- Preview a page exactly as an anonymous visitor would load it, so measurements reflect the public experience.
- Capture DOM element count, request count and total page weight (KB) alongside the score for deeper analysis.
- Set a site-wide minimum EcoIndex score that contributors should reach for their content.
- Warn a contributor with an on-screen message when a measured page scores below the configured minimum.
- Block publication of content that does not meet the minimum score, enforcing an eco-quality gate.
- Store measured values on the entity so they persist and appear in revisions.
- Compare EcoIndex score and grade between two revisions of a node using the Diff module.
- Give editorial teams a repeatable workflow to monitor and improve page weight over time.
- Surface eco-performance data to non-technical contributors without external tooling.
- Encourage lighter pages by making the score visible during content editing.
- Report on the environmental footprint of a site's key landing pages.
- Manually enter or correct score, grade, element count, request count and size via the field widget.
- Use the field's default score formatter to render the numeric score inline in any display mode.
- Combine with content workflows so low-scoring pages are flagged before going live.
- Provide sustainability KPIs for content governance and editorial guidelines.
