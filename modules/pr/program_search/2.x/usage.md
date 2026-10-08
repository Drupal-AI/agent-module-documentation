Open Y Programs Search adds a configurable, multi-step "Programs Search" block that guides YMCA site visitors to the right program and gives them a deep link to register on the branch's Daxko system.

---

Part of the Open Y / YMCA distribution, the module (machine name `openy_programs_search`, project `program_search`) exposes a single block plugin — `programs_search_block` — backed by a `DataStorage` service that pulls program, session, location, school and category data from Daxko. It uses the sibling `daxko` API client for structured calls (branches, programs, sessions, childcare programs) and scrapes Daxko HTML pages with Symfony DomCrawler for schools, rate options and categories. Results are cached in a dedicated `openy_programs_search` cache bin and refreshed every 12 hours by an Open Y cron service. The block presents two flows — Child Care (location → school → program → rate → registration link) and adult Programs (location → category → program → session → registration link) — rebuilt step-by-step over AJAX. Per-block configuration enables only chosen locations and categories, while a site-wide admin form configures Daxko connection settings and the URL path templates, plus location-name find/replace, excluded locations and pinned-program weighting used to map childcare programs onto branches.

---

- Place a "Programs Search" block on YMCA pages so visitors can find programs by location and category.
- Offer a guided Child Care search: location, school, program, rate option, then a registration deep link.
- Offer an adult Programs search: location, category, program, session, then a registration deep link.
- Limit a given block instance to a subset of branches via the block's "Enabled locations" checkboxes.
- Limit a given block instance to a subset of program categories via the block's "Enabled categories" checkboxes.
- Fall back to all locations/categories automatically when a block leaves the filters empty.
- Connect a site to a specific Daxko account by setting the Daxko Client ID and base URL.
- Point the integration at a custom Daxko domain/host for cookie handling and page scraping.
- Customize the Daxko registration path template used to build program registration URLs.
- Customize the Daxko schools-by-program, categories and categories-by-branch path templates.
- Clean up branch names shown to users with location-name find/replace rules.
- Exclude specific branches from the childcare location map by node ID.
- Improve childcare program-to-branch matching by pinning program names in priority order.
- Warm all Daxko-derived caches on a schedule so visitor-facing searches stay fast.
- Manually warm the cache after a data change via `\Drupal::service("openy_programs_search.data_storage")->warmCache()`.
- Manually clear cached Daxko data via `\Drupal::service("openy_programs_search.data_storage")->resetCache()`.
- Generate branch-specific registration links that pass the selected program and session to Daxko.
- Generate childcare registration links that resolve to a school's scraped rate-option URL.
- Surface Daxko childcare rate options (e.g. before/after school) for a chosen school and program.
- Build a per-branch category list so adult program searches only show categories offered at that branch.
- Show clear "Sorry, nothing has been found." messaging when a step yields no options.
- Give block editors a link to the settings page and an error message when Daxko data can't be fetched.
- Restrict who can configure the integration with the "Administer programs search" permission.
