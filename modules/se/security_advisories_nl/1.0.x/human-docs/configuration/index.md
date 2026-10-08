# Configuration

Setting up the module is a matter of telling it *where* to fetch advisories from, then
running a fetch and deciding *who* may read the results.

## Open the settings

1. Log in as a user with the **administer security advisories nl** permission.
2. Go to the main settings at **`/admin/config/system/security-advisories-nl`** (config
   route `security_advisories_nl.settings`).

## Add and manage sources

The heart of the configuration is the **sources** page at
**`/admin/config/system/security-advisories-nl/sources`**. Each source you add
describes one feed to pull from, with:

- a **label** (a friendly name),
- a **URL** (the feed or API endpoint — it must be a valid URL; the form validates
  it),
- a **type** — `rss`, `json`, or `html` — telling the module which parser to use
  (NCSC, RSS/Atom, or WordPress REST), and
- an **enabled** flag so you can switch a source on or off without deleting it.

You can add, edit, delete, and enable/disable sources here. Because these URLs decide
what your server fetches over the network, only admins with the restricted **administer
security advisories nl** permission can change them — keep that permission to trusted
staff. The module fetches from these admin-supplied hosts with normal TLS certificate
verification left on, and there is no way for an anonymous visitor to influence the
fetch target.

## Fetch and maintain the advisories

The admin control panel offers manual actions (all gated by **administer security
advisories nl**, except where noted):

- **Fetch now** — pull advisories from all enabled sources.
- **Refetch content** — re-download the full article body for stored advisories.
- **Extract CVEs** — scan advisories for CVE identifiers.
- **Update severity** — normalise threat levels (Critical / High / Medium / Low).
- **Clear cache** — empty the module's HTTP response cache.
- **Queue status / Process queue now** — inspect and run the background fetch queue.
- **Clean up duplicates** — remove duplicate advisory entities.
- **Refresh advisory** — refresh a single advisory (this one uses the *manage security
  advisories* permission).

For unattended operation, make sure **cron** runs regularly — the queue does the
batched fetching, CVE extraction, and severity updates. Hourly is recommended for
critical sources.

## Publish to your audience

Two public pages render the advisories to visitors:

- **`/security-advisories`** — the listing of all advisories.
- **`/security-advisory/{advisory}`** — a single advisory.

Both require the **view security advisories** permission. Grant it under **People →
Permissions** to whichever roles (or Anonymous, if appropriate) you want to be able to
read the advisories, and use the **latest advisories** block on a homepage or intranet
if you want a compact summary elsewhere.

## Permissions summary

- **administer security advisories nl** — configure sources and run all maintenance
  actions. This decides the site's outbound fetch targets; restrict it to trusted
  staff.
- **manage security advisories** — manage the stored advisory entities (collection,
  refresh, delete).
- **view security advisories** — read the public listing and single-advisory pages.
