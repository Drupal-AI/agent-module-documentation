# Configuration

The module's only configuration is the **allowed hosts** list — the Data & Insights
origins that embeds may come from. It does double duty: it gates validation (embeds
from any other host are rejected) and, when the CSP module is enabled, it drives the
`frame-src` Content-Security-Policy directive.

## Open the settings form

1. Log in as a user with the **Administer media_tyler_data_insights hosts** permission.
2. Go to **Configuration → Media → Tyler Data & Insights**, or navigate directly to
   `/admin/config/media/tyler-data-insights`.

## Allowed hosts

The form is a single textarea — enter **one host per line**. Each entry must be an
**`https://` origin with no path**: a scheme (which must be `https`) and a host only.
For example:

```
https://data.example.gov
https://insights.example.com
```

The form validates each line and stores the trimmed, non-empty ones. Multiple domains
are fine — useful for multi-agency setups. Click **Save configuration** when done.

## What the list does

- **Validation:** when a media item is saved, the pasted embed must contain exactly
  one iframe, its path must be a Data & Insights `/w/…` (visualization) or `/stories/…`
  URL, and its host must be on this list. Anything else fails with a clear validation
  error, so broken or off-domain iframes never get saved.
- **Content Security Policy:** if the **CSP** module is enabled, every allowed host is
  appended to the `frame-src` directive on non-admin routes automatically (creating the
  directive if it isn't there), so a strict CSP won't block the embed.

## Permission

- **Administer media_tyler_data_insights hosts** — reach this settings form and edit
  the allowed hosts.

Note that *creating* media of the Tyler Data & Insights type is governed by the normal
core **Media** permissions on the media type — so you can let editors add
visualizations while reserving the host list for trusted administrators.

## Setting it from the command line

The values live in the `media_tyler_data_insights.settings` config object under
`allowed_hosts`:

```bash
drush cget media_tyler_data_insights.settings
```
