# Configuration

Before running an analysis, tell the detector what to scan and how sensitive to be.

## Open the settings form

1. Log in as a user with the **Administer Content Cannibalization Detector**
   permission.
2. Go to **Configuration → Search and metadata → Content Cannibalization Detector**,
   or navigate directly to `/admin/config/search/cannibalization`.

## Content types

Select **which content types to include** in the analysis. Only published nodes of
the chosen types are compared, so you can focus the audit on the content that
actually matters for SEO (for example articles and landing pages) and leave utility
content out.

## Similarity threshold

The **minimum cosine‑similarity score** at which a pair of pages is flagged as a
potential cannibalization issue. The default is **40%**. Lower it to catch looser
overlaps (more findings, more noise); raise it to surface only the strongest,
near‑duplicate matches. The threshold also relates to how findings are graded:

- **Critical (80–100%)** — pages are nearly identical; merge them into one.
- **High (60–79%)** — significant overlap; redirect the weaker page.
- **Medium (40–59%)** — moderate overlap; set a canonical URL on the secondary page.
- **Low (below 40%)** — minor overlap; differentiate the keyword targeting.

## Keyword sources

Choose **which parts of a page contribute keywords**: title, body, path alias, and
meta tags. Each source is weighted when scoring — title (3×), meta tags (2.5×), URL
paths (2×), and body (1×) — so what you include meaningfully shapes the results.
(Meta‑tag extraction requires the Metatag module.)

## Custom stop words

The module ships with 130+ built‑in English stop words (common words ignored during
analysis). Add your own **site‑specific common terms** here — brand names,
boilerplate, section labels — so they don't inflate the apparent similarity between
otherwise distinct pages.

## Save and run

Save your settings, then go to **Reports → Content Cannibalization**
(`/admin/reports/cannibalization`) and click **Run Analysis**. Re‑run it whenever
your content changes to keep the report current — or automate it from the CLI with
`drush ccd:analyze`.
