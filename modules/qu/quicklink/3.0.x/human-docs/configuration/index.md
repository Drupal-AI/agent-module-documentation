# Configuration

Quicklink works well out of the box — everything here is optional tuning. All of
its behavior lives in one settings form, organized into vertical tabs. The tabs
are only visual grouping; they all save into the same `quicklink.settings` config
object, which you can export and deploy.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Development → Performance → Quicklink**, or navigate
   directly to `/admin/config/development/performance/quicklink`.

## What to ignore

These options keep Quicklink from prefetching links it shouldn't. All are on by
default:

- **Ignore admin paths** — do not prefetch `/admin` or `/edit` links (and admin
  menu links). Leave on so editors' admin clicks aren't wasted on prefetch.
- **Ignore AJAX links** — do not prefetch links that trigger AJAX behavior.
- **Ignore hashes** — skip URLs containing `#`, so anchor links aren't prefetched
  repeatedly.
- **Ignore file extensions** — skip links that end in a file extension (`.pdf`,
  `.zip`, etc.) so downloads aren't fetched.

Plus two free-text lists (one entry per line):

- **URL patterns to ignore** — any link whose href contains one of these
  substrings is skipped. Good for `/cart`, `/checkout`, and similar.
- **Ignore selectors** — CSS selectors whose links should be skipped, for example
  `.footer a`.

Note that the logout link (`user/logout`) is *always* ignored and cannot be
un-ignored.

## Overrides (scope)

- **Parent selector** — a CSS selector that limits which part of the page
  Quicklink scans for links, for example `.main-content`. Leave empty to scan the
  whole document.
- **Allowed domains** — a per-line list of extra domains Quicklink may prefetch
  from. Empty means only the site's own origin.
- **Prefetch-only paths** — a per-line list of paths; when set, **only** these
  paths are ever prefetched.

## When to load the library

These decide whether Quicklink loads at all on a given page:

- **Prefetch for anonymous users only** (on by default) — the library is not
  loaded for logged-in users, keeping private/session pages out of prefetching.
- **Do not load during an active PHP session** (on by default) — skips loading
  whenever a session exists (useful for Drupal Commerce carts and similar).
- **Content types that opt out** — checkboxes to prevent the library from loading
  on pages of specific content types.

## Throttle (how aggressively to prefetch)

- **Total request limit** — the maximum number of prefetch requests per page load
  (0 = unlimited).
- **Concurrency throttle limit** — the maximum number of simultaneous prefetches
  (0 = the library's own default). Lower this to avoid saturating slow/mobile
  networks.
- **Viewport delay** — how long (in milliseconds) a link must stay visible in the
  viewport before it is prefetched (0 = no delay).
- **Idle wait timeout** — how long (in milliseconds) to wait for the browser to be
  idle before prefetching begins (default 2000).

## Debug

- **Enable debug mode** (off by default) — logs to the browser console exactly
  what Quicklink is and isn't prefetching, and why. Handy while tuning the options
  above; turn it off in production.

## Save

Click **Save configuration**. Changes take effect immediately — the module
attaches the config's cache tags, so no manual cache clear is needed.
