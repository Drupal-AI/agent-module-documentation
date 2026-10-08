Facets demo installs a complete, working faceted-search example — a Search API (database) index, a view with exposed facets, sample content, and the suggested contrib modules — so you can see how Facets is meant to be assembled end to end.

---

This facets submodule is a demonstration/starter package rather than a production feature. On install it pulls in Facets, Facets Exposed Filters, Search API with the database backend, Better Exposed Filters, Views AJAX History, Views Filters Summary, and Default Content, then imports sample nodes and taxonomy terms (via `default_content` UUIDs) and ships configuration for an example search index, view, and pre-built facets. The result is a browsable faceted search page you can inspect to learn the recommended setup, widgets, and processors. It has no config UI, permissions, hooks, or plugin types of its own. Use it on a scratch/dev site to explore Facets quickly, as a reference implementation, or as a starting point you adapt — not something to enable on a live site.

---

- Spin up a working faceted search demo in one install.
- Learn the recommended Facets + Search API + Views wiring.
- See exposed-filter facets configured with Better Exposed Filters.
- Explore sample facets, widgets, and processors in a real view.
- Get sample content and taxonomy terms to facet against.
- Use it as a reference implementation while building your own.
- Demonstrate faceted search to stakeholders quickly.
- Try AJAX faceting with Views AJAX History out of the box.
- See the Views Filters Summary integration in action.
- Prototype a search UI before designing the production version.
- Teach a workshop or tutorial on Drupal faceted search.
- Reproduce issues on a known-good baseline configuration.
- Compare your setup against a canonical working example.
- Evaluate whether Facets fits a project without building from scratch.
- Copy the example view/index config as a starting template.
- Test a Facets upgrade against a standard dataset.
- Showcase database-backed Search API faceting without Solr.
- Provide a sandbox for QA to click through faceted search.
- Bootstrap a local dev environment for Facets development.
- Demonstrate default_content-driven sample data importing.
