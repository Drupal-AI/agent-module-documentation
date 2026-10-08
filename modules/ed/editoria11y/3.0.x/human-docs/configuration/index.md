# Configuration

The **Core settings** form is where you tell Editoria11y *what* to scan on each
page, *which* regions to leave alone, and *who* sees the alerts. The defaults are
sensible for most sites, but it is worth walking through each field once so the
checker flags real, author-fixable problems and stays quiet about things editors
cannot control (a theme's decorative markup, third-party widgets, and so on).

## Open the Core settings form

1. Go to **Configuration → Content authoring → Editoria11y**
   (`/admin/config/content/editoria11y`).
2. Make sure you are on the **Core settings** tab (it opens there by default; the
   neighbouring **Demo** tab is just a sample page of broken content).

![The Editoria11y core settings page](../images/settings.png)

At the top, a short **Getting started** checklist summarizes the same steps this
page covers, and links out to the Configuration Guide, issue queue, and support
contacts.

## Choose which parts of the page to scan

- **Parts of the page to test** — this is the CSS selector (or selectors) that
  defines the area the checker looks inside. Left as **automatic**, Editoria11y
  scans the main content area of your theme. Enter your own selector here (for
  example a wrapper class used by your theme's content region) when you want to
  point the checker at a specific part of the page. Provide standard
  [CSS selectors](https://developer.mozilla.org/docs/Web/CSS/CSS_selectors); do
  not nest selectors inside one another or the inner content is checked twice.

- **Do not check for any errors inside these elements** — a selector list for
  regions that should be skipped entirely — no alerts of any kind. Left at
  **match content settings**, it follows the scan area above. Use this to exclude
  areas that produce unhelpful, repetitive, or inaccurate alerts.

## Handle editable regions and non-editable content

- **Page regions with user-editable content** — CSS selectors for the regions
  authors actually edit. The default is `main`. This lets the checker treat those
  areas as the editor's responsibility. As the field note warns, do not provide
  selectors that nest within each other, or the inner content will be checked
  twice.

- **Do not check for content errors inside these elements** — selectors for
  regions that are *on* the page but are **not** the content editor's
  responsibility, such as a theme's sidebar menu or a slide that is hidden from
  assistive technology. Content-quality errors inside these elements are
  suppressed. The field suggests examples like
  `#sidebar-menu a, .slide [aria-hidden="true"]`.

## Decide which roles see the alerts

- **Roles that will see developer alerts** — tick the roles (for example
  **Content editor**, **Administrator**) that should see the more technical
  "developer" alerts. As the note beneath the checkboxes explains, *all* roles
  that hold the **View Editoria11y checker** permission see the standard content
  alerts regardless; this section only governs the extra developer-oriented
  tests. (Developer tests themselves come from the `editoria11y_csa` submodule —
  the settings form links to it where relevant.)

## Which checks are enabled

Editoria11y ships with a full battery of content tests turned on — missing and
suspicious alt text, skipped headings, vague link text, tables without headers,
video that may need captions, and more — with a small number disabled by default
(such as graphic-contrast warnings and the "click here" link test) to reduce
noise. The selectors above are the main levers you use to keep the checker
focused; you tune *where* it runs and *which regions* it ignores rather than
switching individual tests off one by one for most sites.

## Save

Scroll to the bottom and click **Save configuration**. Your changes take effect
the next time an authorized user loads a page.

## What editors see on the front end

Once configured, any user with the **View Editoria11y checker** permission sees
the checker while browsing the live site. A small toggle panel is pinned to the
edge of the page; opening it lists every issue found on that page, and each issue
also gets an inline marker with a tooltip pinned to the element that needs
attention. Depending on their permissions, editors can dismiss a false positive
as **hidden** (just for themselves) or, for accessibility leads, mark it **OK**
for everyone.

## Review results on the dashboard

Findings from across the site are aggregated into a results dashboard at
**Reports → Content Accessibility Issues** (`/admin/reports/editoria11y`),
available to users with the **Manage Editoria11y results** permission. It rolls
the data up **by page** (which pages have the most issues) and **by issue type**
(which mistakes are most common site-wide), so an accessibility lead can triage
and track accessibility debt over time. Results for a page can be reset or purged
once the problems there are fixed.
