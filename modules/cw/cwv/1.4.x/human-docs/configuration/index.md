# Configuration

CWV ships **inert**: after install it captures no data at all. That is
deliberate — it lets you review the privacy and storage implications and decide
your sampling and URL policy before a single beacon is written. This page walks
through the settings you'll want to set.

You need the **Administer CWV** (`administer cwv`) permission to reach the
settings, and **View CWV reports** (`view cwv reports`) to read the reports at
**Reports → CWV** (`/admin/reports/cwv`).

## Turn capture on

The single most important setting: **capture is disabled until you enable it.**
Until you do, the bundled tracking script does not collect or post metrics and
the report panels stay empty. Enable capture once you're comfortable with the
sampling and URL settings below.

## Sampling rate

Real‑user monitoring does not need every page view — a sample is enough to see
trends without flooding your database. The **sampling rate defaults to 0.1**
(one in ten sessions). Raise it on a low‑traffic site where you want more data
points, or lower it on a high‑traffic site to keep table growth in check.

## URL storage policy

Each beacon is tied to a URL, and URLs can carry personal or sensitive
information in their path or query. CWV gives you **three URL‑storage policies**
so you can match the privacy exposure your site can tolerate:

- **Hash** — store only a hash of the URL (most private).
- **Path‑only** — store the path but drop the query string.
- **Full** — store the complete URL (most detail, least private).

Choose the policy that fits your GDPR / CCPA posture. When in doubt, start with a
more private option.

## Outlier filtering

**Outlier filtering is on by default for new installs.** It drops obvious
non‑RUM noise — measurements from backgrounded browser tabs, broken‑page beacons,
and similar artefacts — before anything is stored, so your metrics reflect real
user experience rather than junk data. Leave it on unless you have a specific
reason to capture raw beacons.

## Endpoint hardening and table‑size guard

The beacon endpoint accepts measurements from any visitor, including anonymous
ones — that is how real‑user monitoring works. To keep that from becoming a
liability, CWV applies **per‑IP flood protection** and a **configurable
table‑size guard** that caps how large the beacon storage can grow. Review these
alongside a **retention plan**: decide how long you keep beacon rows and prune
older data on a schedule so the tables don't grow without bound.

## Save

Save the settings form. Once capture is enabled, real visitors' browsers begin
posting metrics (at your sampling rate), and the panels at **Reports → CWV**
start filling in — correlating each Core Web Vital against the Drupal‑side
signals CWV collects.
