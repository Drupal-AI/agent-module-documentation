# Configuration

Scrape to field has two levels of configuration: **global settings** that apply to
the whole module, and **per-field settings** that you set on individual nodes.

## Global settings

Go to **Configuration → Content authoring → Scrape to field Settings**
(`/admin/config/content/web-scraper`). Here you set site-wide defaults:

- **Request Timeout** — how long a scrape request may take before it is abandoned.
- **Cron scraping frequency** — how often, on cron runs, scraping should occur by
  default.
- **Allowed HTML tags** — which HTML tags are permitted in scraped values.

## Per-field configuration

Open a node and select its **Scraper Config** tab. For each supported field type
(string, text, integer, decimal and float) you can configure:

- **Source URL** — the web page to scrape data from.
- **Selector type** — choose **CSS Selector** or **XPath Expression**.
- **Extract method** — how to pull the value out of the targeted element.
- **Value cleaning** — enable search-and-replace operations to clean the scraped
  data before it is stored.
- **Multiple results handling** — how to treat fields that accept multiple values.
- **Test this configuration** — a real-time button that validates your selector and
  previews the result before you save, so you can confirm it grabs the right value.
- **Scraping frequency override** — override the global frequency for this specific
  field.

Because the fetching runs in the background via cron, remember that a saved
configuration only takes effect on the next qualifying cron run.

## Permissions

Access is controlled under **People → Permissions**
(`/admin/people/permissions`):

- **Administer scrape to field settings** — access to the global configuration
  form.
- **Configure any node scrape to field** — configure scraping on any node.
- **Configure own node scrape to field** — configure scraping only on nodes the
  user authored.

Grant these only to trusted editors, since a scrape configuration points Drupal at
an external URL and stores whatever it fetches into your content.
