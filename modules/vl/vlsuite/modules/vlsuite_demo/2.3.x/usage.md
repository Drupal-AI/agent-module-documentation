<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Demo installs example pages and the configuration behind them, so the suite can be seen working without building anything.

---

Evaluating a component library from a module list is impossible — the question is what a page assembled from it looks like, and that is answerable only by looking at one. This submodule answers it: enable it and the site has landing pages built from the suite's heroes, statements, cards, galleries and tabbed layouts.

That makes it the right first step when deciding whether to adopt VLSuite, and the right way to show a stakeholder what they would be getting. It is also a reference: the demo pages are worked examples of how the components are meant to be combined, which is faster to learn from than documentation.

**Remove it before launch.** Demo content is content — it appears in listings, in search, in sitemaps and in a site's content counts, and a demo page that survives to production is the kind of thing that turns up in a search result months later. Uninstalling the module does not necessarily remove content it created, so check what is left rather than assuming.

Treat it, like `acquia_purge_varnish_test`, as a module a production audit should be looking for.

---

- See the suite working without building anything.
- Evaluate VLSuite before adopting it.
- Show a stakeholder what the suite produces.
- Learn how components are meant to combine.
- Read worked examples of page assembly.
- Get landing pages built from the component set.
- Compare the suite against a design.
- Start from a demo page and adapt it.
- Decide whether to adopt the suite.
- Remove demo content before launch.
- Check what content survives uninstall.
- Keep demo pages out of search results.
- Audit production for demo modules.
- Onboard a developer to the component set.
- Demonstrate tabbed layouts and collections.