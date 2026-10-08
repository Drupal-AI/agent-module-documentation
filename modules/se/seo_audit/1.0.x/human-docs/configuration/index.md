# Configuration

SEO Audit has two things to do before it reports anything useful: set up how the
crawl behaves, and then request a crawl. Both live under **Configuration → Search
and metadata → SEO Audit**.

## Configure the crawl

Open the settings page at `/admin/config/search/seo-audit/settings` (route
`seo_audit.settings`). Here you tune how the crawler runs and what it checks:

- **Crawl concurrency, depth, and limit** — control how aggressively the crawler
  fetches pages: how many at once, how deep into the link graph it goes, and how
  many pages it will visit in total. Keep these modest on a busy production site,
  since crawling adds real server load.
- **Enable or disable individual checks** — turn each SEO metric on or off.
  Requesting only the data you need speeds up the crawl and avoids unnecessary
  overhead.
- **Email notifications** — optionally have the module email you when a crawl
  finishes, so you do not have to sit and watch it.

The crawler respects `robots.txt` and can target live, staging, or local
virtual-hosted sites. The crawl target is set here by an administrator — treat
the ability to configure and trigger audits as privileged, and restrict it to
trusted roles.

## Request a crawl

Go to `/admin/config/search/seo-audit/crawl` and start an audit. Because the work
is queued and processed on cron, the crawl runs in the background rather than
blocking your browser — schedule it (via cron) for a quiet time on large or
production sites so the extra requests do not compete with real traffic.

## View and export results

Open `/admin/config/search/seo-audit/results` to read the findings. Reports are
prioritised and colour-coded by HTTP status for quick scanning, and each user
sees only their own crawl results. You can export a report as **PDF, CSV, or
JSON** for sharing or tracking over time.
