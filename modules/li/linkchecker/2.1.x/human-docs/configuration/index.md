# Configuration

Setting up Link checker has two parts: telling it **which fields to scan**, and
tuning the **global options** for how it checks and what it does with the results.

## Step 1 — choose which fields to scan

Link checker does not scan anything until you opt fields in. For each field you
want watched:

1. Go to the field's settings (for example **Structure → Content types → Article →
   Manage fields → Body**).
2. In the **Link checker settings** section, tick **Scan broken links**.
3. Pick an **Extractor** — the piece that knows how to pull links out of that kind
   of field:
   - **HTML** extractor — reads links from formatted (rich‑text) fields such as
     Body.
   - **Link** extractor — reads links from core Link fields.

You can do this on any fieldable entity type, not just nodes. There are also two
global toggles on the settings form (below) for scanning **custom blocks** and for
**ignoring unpublished content**.

## Step 2 — the settings form

Go to **Configuration → Content authoring → Link checker**
(`/admin/config/content/linkchecker`). The main options are:

### What to check

- **Which links** — check internal links, external links, or both. By default both
  internal (`/node/123`) and external (`https://…`) links are checked.
- **Default URL scheme** and **Base path** — help the module turn scheme‑relative
  and internal links into full addresses it can request. Set the base path to your
  site's host if internal links are not resolving correctly.
- **Scan links in blocks** — also extract links from custom block content.
- **Check only published content** — skip links that appear only in unpublished
  content.
- **Extract from tags** — checkboxes for which HTML tags to read links from:
  `<a>`/`<area>` (on by default), plus optional `<img>`, `<iframe>`, `<audio>`,
  `<video>`, `<object>` and `<embed>` sources for catching broken media.
- **Filter blacklist** — text filters (such as *Align images* or *Smileys*) whose
  markup should be excluded so it is not mistaken for links.

### How to check

- **Maximum simultaneous connections** (default 8) and **per‑domain connections**
  (default 2) — limit how hard the crawler hits sites at once, so you do not
  overload a target server or your own.
- **Check interval** — how long to wait before re‑checking a link. The default is
  four weeks.
- **User‑Agent** — the identifying string sent with each request.
- **Impersonate account** — an account to act as when checking internal links that
  sit behind access control, so protected pages are not reported as broken.
- **Ignore hosts** — a list of hosts (one per line) whose links should never be
  checked.

### What to do about results

- **Ignore response codes** — HTTP codes that should *not* be treated as broken.
  By default 200, 206, 302, 304, 401 and 403 are ignored.
- **Unpublish content after repeated 404s** — automatically unpublish an item once
  its links have returned 404 a set number of times (off by default).
- **Repair permanently moved (301) links** — automatically rewrite links that
  return a 301 redirect to their new destination (off by default).
- **Logging level** — how verbose the module's log messages are.

Click **Save configuration** to apply. These settings are stored as configuration,
so they export and deploy with `drush config:export` / `config:import`.

## Step 3 — let cron do the work

Link checker checks links on cron, not instantly. Each cron run does two things:
it extracts links from any content that has not been indexed yet, and it queues
links whose check interval has elapsed. Separate background workers then make the
actual HTTP requests and run any follow‑up actions (301 repair, 404 unpublish). As
long as cron runs regularly, the report stays current on its own.

## The Broken links report

Results appear at **Reports → Broken links** (`/admin/reports/linkchecker`),
visible to users with the *access broken links report* permission. Each row shows
the content the link came from, the URL, when it was last checked, the request
method, the HTTP code and any error.

## Command‑line tools

Two Drush commands help you manage links directly:

- `drush linkchecker:analyze` (alias `lca`) — re‑extract links from all content and
  re‑check them. Useful after a big content migration or site relaunch.
- `drush linkchecker:clear` (alias `lccl`) — clear all stored links and start
  fresh.
