<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Filter Parameter (views_filter_param) — agent index

**A Views field that emits the current page's filter query as a `destination-link`, so row actions return to the filtered listing.**

- **Version:** 9.0.x
- **Core:** ^8 || ^9 || ^10
- **Depends:** views
- **Package:** Views

**Surface:** no routes/permissions. Views field plugin `filter_param_views_field` (`ViewsFilterParam::render()` builds the param string). `.module`: `hook_views_data`, `hook_form_alter` + `filter_redirect_submit_handler` (reads `destination-link` query, redirects after submit).

**Security:** no SQL — `query()` is a no-op, so no filter-injection into the DB. The post-submit redirect target comes from the user-supplied `destination-link` query param and is passed to `Url::fromUri('internal:' . $url)`; `internal:` limits it to same-site paths (off-site values throw) but is otherwise unvalidated and reflects the query string — treat as a same-site redirect helper.

See [extend/field.md](extend/field.md).
