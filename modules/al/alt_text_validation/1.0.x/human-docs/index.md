# Alt-Text Validation — manual setup guide

**Alt-Text Validation** (`alt_text_validation`) helps your editors write good image *alt text*
for accessibility, and helps you audit the alt text already on your site. It does this in two
ways. First, it **validates** alt text as content is saved: configurable rules can block a save
(for example, when alt text is empty) or just warn about it (for example, when the alt text
merely repeats the image filename). Second, it **audits** every image across the site — in image
fields *and* in `<img>` tags embedded in rich-text fields — into a downloadable report so you
can see where the problems are.

Rules are configuration entities you manage in the admin UI. Each rule has a type (empty check,
matches-filename, length limit, "must not begin with / contain / equal / end with a phrase",
regular-expression match, and a few more), an action (*prevent*, *warn*, or *off*), and a
message. Six sensible defaults ship enabled, and a master switch lets you run in report-only
mode — keeping the rules for auditing while not yet enforcing them on save. That makes a gradual
rollout easy: start everything as *warn*, gather data, then promote rules to *prevent*.

The audit report is a View at **Reports → Alt Text Report**, populated by cron, by an on-page
"rebuild" button, or by a Drush command; it reads a custom audit table (not live entities), so
it must be built before it shows data. The module depends on core **Field** and **Views**, on
the contrib **Views Data Export** module (which provides the CSV download), and on the
`league/commonmark` library. Two permissions separate *administering the rules* from *viewing
the report*. It works on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — the services, the constraint, and how the audit
queue works — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the Views Data
   Export dependency), enable it, and set the two permissions.
2. [Configuration](configuration/index.md) — the settings form and master switch, the rule
   types and defaults, and the three ways to build the audit report.

## Where it lives in the admin menu

- **Settings:** **Configuration → Content authoring → Alt-Text Validation**
  (`/admin/config/content/alt-text-validation`).
- **Rules:** the rule list hangs off that settings path
  (`/admin/config/content/alt-text-validation/rules`).
- **Report:** **Reports → Alt Text Report** (`/admin/reports/alt-text-report`).

## How to use it

Enable the module and, out of the box, six *prevent* rules apply on save — most notably that alt
text must not be empty. Review the rules and adjust each one's action to *warn* or *off* to suit
your site (see [Configuration](configuration/index.md)). To see the state of alt text
everywhere, build the audit report (via cron, the report's rebuild button, or Drush) and
download it as CSV. On-save validation applies to anyone editing a covered field and is governed
by the master switch and each rule's action — it is not itself permission-gated.
