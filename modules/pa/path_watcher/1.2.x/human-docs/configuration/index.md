# Configuration

Path Watcher starts recording visits as soon as it is enabled, but you'll almost
always want to tune *what* it records, decide who may see the statistics, and
place its block. This page covers all three.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Path Watcher**, or navigate directly to
   `/admin/config/system/path-watcher`.

## Filtering what gets recorded

The settings form's main job is **filtering** — controlling which requests turn
into visit records. Use it to narrow tracking to the paths you actually care
about and to keep noise (and stored data) down. Because the module is intended
mainly for authorised requests and deliberately does not store IP addresses or
User‑Agent strings, the filters are your primary lever for keeping the dataset
small and privacy‑respecting.

Practical guidance:

- Record only the paths whose traffic you need to understand, rather than every
  request site‑wide.
- Keep in mind that records are written after the response is sent (during the
  kernel `TERMINATE` phase), so filtering here is about *what* is stored, not
  about page performance.

Save the form when you're done; changes take effect on subsequent requests.

## The visits block

Path Watcher provides a **block** that displays visit counts — by default meant to
sit at the bottom of the page. Place it like any other block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the region you want (for example a footer region) and click **Place
   block**.
3. Choose the Path Watcher visits block, configure its visibility as you would any
   block, and save.

## Who can see the statistics

Path Watcher provides its own permission governing access to the visit data. Grant
it only to trusted roles:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant Path Watcher's permission to the roles that should be able to view the
   statistics.
3. Save permissions.

## Privacy reminder

Browsing statistics can be personal data even without IPs or User‑Agents,
particularly when visits can be tied to logged‑in users or sessions. Record the
minimum you need through the filters above, disclose the tracking in your privacy
policy where appropriate, and keep the statistics gated behind the permission
rather than exposing the block or reports to anonymous users.
