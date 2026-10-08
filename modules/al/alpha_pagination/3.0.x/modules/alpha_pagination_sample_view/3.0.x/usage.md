<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alpha Pagination Sample View installs a ready-made example View that demonstrates the Alpha Pagination A-Z paginator against the default article content type.

---

This submodule of Alpha Pagination ships one View in `config/install/views.view.alpha_pagination_sample.yml`. On enable it imports the `alpha_pagination_sample` View, which lists published article nodes at path `/alpha-pagination-sample` with a "Global: Alpha Pagination" header, a glossary contextual filter on the title (character limit 1, uppercase), and individual 0-9 numeric items. It is intended as a copy-and-learn reference rather than a production feature; the paginator only lights up letters that have matching articles, so you need article content (created manually or via Devel) to see it work. It depends on core Views and the parent `alpha_pagination` module.

---

- See a fully-working Alpha Pagination configuration without building a View by hand.
- Learn how the glossary contextual filter, source field and area handler fit together.
- View the example at `/alpha-pagination-sample` after enabling the submodule.
- Copy the example View as a starting point for your own alphabetic listing.
- Demonstrate individual numeric (0-9) pagination items alongside letters.
- Test Alpha Pagination against the default article content type.
- Populate articles (e.g. with Devel) to watch letters activate/deactivate.
- Clone and rename the View to paginate a different entity or field.
- Reference the exported View config for correct handler option values.
- Remove the submodule once you no longer need the demo (the imported View can be deleted).
