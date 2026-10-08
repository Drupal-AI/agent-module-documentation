<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pagerer example is a demo submodule of Pagerer that adds a sample page (`/pagerer/example`) showing multiple Pagerer-styled pagers over real data, as a reference for site builders and developers.

---

The submodule ships nothing but a single publicly accessible route, `pagerer_example.page` at `/pagerer/example` (`_access: 'TRUE'`), handled by `Drupal\pagerer_example\Controller\PagererExampleController`. The controller runs two independent paged database queries (over core's `watchdog` and `key_value` tables) associated with pager elements `0` and `1`, renders them as tables, and attaches Pagerer pagers so you can see the configured pager styles working with more than one pager on a page. It injects the `pagerer.style.manager` plugin manager and the module extension list (its page title shows the running Pagerer version). It has no configuration, no settings, no permissions and no services of its own; it depends only on the parent `pagerer` module. Enable it to preview and learn Pagerer, then it can be safely uninstalled on production.

---

- Preview how Pagerer pager styles render before applying them to a real View or the core pager.
- See two independent pagers (elements 0 and 1) coexisting on one page.
- Verify Pagerer is installed and working after enabling the module.
- Confirm which Pagerer version is running (shown in the example page title).
- Learn how to associate a pager with a specific query via `->element(0)` / `->element(1)`.
- Use the controller as a copy-paste reference for building a paged table in a custom controller.
- Demonstrate Pagerer to a client or team without touching production Views.
- Check that multi-pager URL querystrings (e.g. `?page=0,1`) behave as configured.
- Test a new custom `@PagererStyle` plugin against a live page quickly.
- Sanity-check pager CSS/theming changes on a predictable sample page.
- Show the difference between page-based, item-based and range-based pager displays.
- Provide a QA target URL (`/pagerer/example`) for automated smoke tests of pagination.
- Reproduce pager bugs on a minimal, dependency-light page.
- Teach new developers how core `PagerSelectExtender` queries drive pagers.
- Validate that the `pagerer.style.manager` service resolves and lists style plugins.
- Compare pager behavior across themes by viewing the same example page.
- Use as a starting point for a custom "styleguide" of pager options.
- Confirm public (anonymous) access to a Pagerer page works as expected.
