# Configuration

Public files URL replacer has just three settings: a master on/off switch, the
external base URL to serve files from, and an option to only rewrite files that are
missing locally.

## Open the settings form

1. Log in as a user with the **Administer files_url_replacer settings** permission.
2. Navigate to **`/admin/config/files_url_replacer`**.

## The settings, field by field

- **Activate Replacer** — the master on/off switch (config key `active`). When
  unchecked, the module does nothing and file URLs behave normally. Check it to
  turn URL replacement on. This is how you switch the behaviour off again later:
  untick it, save, and clear caches.

- **External base URL** — the base URL that public‑file links should point at
  (config key `url`), typically your production site, for example
  `https://www.example.com`. The form validates that what you enter is a **valid,
  external URL** and rejects anything that isn't. Only public‑scheme files are
  rewritten; `.css` and `.js` are always left alone.

- **Check if local file exists** — an optional refinement (config key `check`).
  When ticked, a file's URL is only rewritten when the file is **absent locally**;
  files that do exist on your disk keep their local URL. This lets locally
  regenerated image‑style derivatives stay local while everything missing is
  proxied to the remote host. There is special handling so that a missing image
  derivative still resolves correctly against the external site.

## Save

Click **Save configuration**. Saving invalidates the service container so the
`file_url_generator` swap is rebuilt and takes effect immediately.

## Notes for multilingual sites

If your site uses a URL language prefix (via language negotiation), that prefix is
stripped from the base URL before replacement, so links resolve correctly across
languages.

## Turning it off

To stop rewriting URLs, untick **Activate Replacer**, save, and clear caches. The
site returns to serving files from their normal local URLs.
