# Configuration

No Referrer starts protecting code-generated links the moment it's enabled, using
its default settings (all three attributes on). This page covers the settings form
and the one extra step needed to protect user-generated content.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default) — the module adds no permission of its own.
2. Go to **Configuration → Content authoring → No Referrer**, or navigate directly
   to `/admin/config/content/noreferrer`.

## The three attribute toggles

Each of these is a checkbox, and all are **on by default**. They control which
attributes the module applies, so you can keep just the protections you want:

- **rel="noreferrer"** — the *privacy* one. Stops the browser sending your page's
  URL as the referrer to non-allowed external links.
- **rel="noopener"** — the *security* one. Added to links that open in a new
  window/tab, preventing the linked page from accessing `window.opener` (reverse
  tab-nabbing).
- **referrerpolicy="no-referrer"** — stops referrer leakage from externally hosted
  images, iframes, scripts, and stylesheets embedded in user-generated content.

For example, if you only care about the security aspect, untick the first and keep
the second.

## Allowed domains

A text field where you list trusted hosts, separated by spaces (for example
`example.com example.org`). Links to these hosts are exempt from `noreferrer` and
`referrerpolicy`, so the referrer is still sent to them. Matching is
case-insensitive and covers subdomains too — listing `example.com` also matches
`www.example.com`.

## Protecting user-generated content — enable the filter

The attribute toggles above cover links Drupal generates. To also protect links
and embedded resources typed into body fields, comments, and other rich text, you
must **enable the No Referrer filter** on the relevant text formats:

1. Go to **Configuration → Content authoring → Text formats and editors**.
2. Edit a format (for example *Basic HTML* or *Full HTML*).
3. Under **Enabled filters**, tick the filter named *Add referrerpolicy,
   rel="noopener" and/or rel="noreferrer"*.
4. Save the format.

The filter rewrites the `rel` attribute on links and adds `referrerpolicy` to
external images/iframes/scripts/stylesheets. It also cleans up faulty or
chopped-off HTML, so you don't need to separately enable the "Correct faulty and
chopped-off HTML" filter. Internal and allow-listed URLs are left untouched.

## Publish & subscribe (sharing an allow-list across sites)

If you run several sites and want them to share one canonical allow-list:

- **Publish** — tick this to write your allowed-domains list to a JSON file at a
  hard-to-guess URL. Other sites can then point at that URL.
- **Subscribe URL** — set this to the URL of another site's published list. On save
  and on every cron run, No Referrer fetches that list and replaces your local
  allowed-domains with it. Invalid responses are logged and ignored.

## Save

Click **Save configuration**. Changes apply immediately to newly rendered pages.
