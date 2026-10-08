<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Summary Tabs renders a view's argument summary — the list of available values for a contextual filter — as a row of tabs instead of the default list of links.

---

Install it like any contributed module (`composer require drupal/views_summary_tabs`, then enable **Views Summary Tabs**); it needs only Views core and runs on Drupal `^9 || ^10 || ^11`. To use it, edit a view that has a **contextual filter (argument)** and, under that argument's "When the filter value is NOT available" option, choose **Display a summary**; the summary's **Format** selector then offers **Tabs** — pick it. The one setting the format adds is **Classes**, the CSS classes placed on the wrapping list, defaulting to `tabs tabs--primary` so the summary immediately looks like Drupal's primary tabs — change it to fit another design system, and toggle the standard **count** option to show or hide the per-value counts. The rendered markup is a `<nav>` region containing a list of links (not a `role="tablist"`), so it is accessible navigation, and the first tab is shown active when the URL carries no argument. If your site uses the **Olivero** theme the module automatically attaches Olivero's `tabs` library so the tabs are styled to match; other themes rely on their own tab CSS or the classes you set. Keep in mind these tabs are navigation — each tab loads a filtered page, it does not switch panels in place — and that the presentation only reads well when the number of summary values is small enough to fit one row (an A–Z, a handful of years), so check your real data before choosing it over the default list.

---

- Show an A–Z glossary as a row of tabs.
- Browse an archive by year in tabs.
- Present taxonomy categories as a tab row.
- Turn a contextual-filter summary into navigation.
- Build a browse-by-letter interface for a directory.
- Present a listing's available filter values above the results.
- Show per-value counts next to each tab.
- Build a year-selector for a publications archive.
- Present a contextual filter's options as clickable tabs.
- Show the available values above a filtered listing.
- Build a document library's browse-by-category bar.
- Present departments or regions as selectable tabs.
- Show a directory's alphabet navigation.
- Style the summary to match Olivero's primary tabs automatically.
- Restyle the tab strip with custom CSS classes.
- Present event types as a tab row.
- Show a taxonomy summary compactly.
- Build a faceted starting page from a view summary.
