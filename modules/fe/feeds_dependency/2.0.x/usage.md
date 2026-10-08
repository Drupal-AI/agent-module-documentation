<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Dependency lets you declare that one Feeds importer depends on another, so the dependency imports first and referential data lines up when the dependent feed runs.

---

Real-world imports are rarely independent. A feed of articles references a feed of authors; a feed of products references a feed of categories. If the articles import before the authors exist, the references dangle or the rows are skipped, and the usual workaround is remembering to run the feeds in the right order by hand — which fails the first time someone runs them alphabetically or on a schedule.

This module makes the ordering explicit and enforced. On each feed it adds a "Feed dependency" reference field and a "Clear the dependency" checkbox. When you import a feed — through the UI, cron, a batch, or a push — its referenced dependency feeds import first, recursively, so the referenced entities exist before the referencing feed looks for them. Optionally, clearing a feed also clears the feeds it depends on. It turns an implicit, error-prone convention into feed data that the import process honours. It depends on the **Feeds** module, since it extends that module's import handler, and its value is entirely in multi-feed setups. Confirm the dependency graph matches your content's reference structure, and keep it acyclic — a wrong or circular dependency reintroduces the problem it exists to solve.

---

- Run one feed before another automatically.
- Import authors before articles.
- Import categories before products.
- Import media before the nodes that reference it.
- Enforce feed import order.
- Resolve entity references across feeds.
- Avoid dangling references on import.
- Declare a feed dependency on a feed's edit form.
- Set a feed dependency programmatically via `feed_dependency_id`.
- Remove manual run-order steps.
- Make scheduled (cron) feed runs import in the correct order.
- Chain related imports into a dependency chain.
- Fix skipped rows caused by missing references.
- Model a feed dependency graph.
- Coordinate multi-feed migrations.
- Cascade a clear so deleting a feed also clears its dependency.
- Keep a normalized content import consistent.
- Prevent order-dependent import bugs.
- Preserve ordering across import, batch, cron, and push.
- Maintain a set of related feeds without a custom module.
