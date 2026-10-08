# Configuration

Unlike the base Smart Content module, Smart Content CDN needs a couple of settings
before it will personalize at the edge. Do this once, after installing on your
Pantheon environment.

## Open the settings form

1. Log in as a user with the **configure smart content cdn** permission (it's a
   restricted permission, so typically an administrator).
2. Go to **Configuration → System → Smart Content CDN Configuration**, or navigate
   directly to `/admin/config/system/smart-content-cdn`.

## The settings

- **Vary Header toggle** — turn this **on**. It's what tells the module to add the
  `Audience` and `Interest` values to the response's `Vary` header, so the CDN
  caches a separate variant per segment. With it off, no edge personalization
  happens.
- **Default Geo value** — set this to a **two-letter country code in all
  uppercase** (for example `US`). This is the fallback country used when no geo
  header is present, and it should match the default segment you set up on the
  geolocation side of your Smart Content configuration.
- **Interest field mapping** — map the content fields that represent a visitor's
  interest, so the module can detect interest decisions on a page and vary the
  cache accordingly.

Click **Save** to store the configuration.

## How it behaves once configured

With the Vary header enabled, a response event subscriber inspects each page's
cache tags as it is sent. If the page contains a geo decision it adds **Audience**
to the `Vary` header; if it contains an interest decision it adds **Interest**.
Pantheon's CDN then caches and serves a distinct variant of the page per audience
segment, and merges cleanly with any other `Vary` headers already set. The geo and
interest values themselves come from the request headers Pantheon Edge
Integrations injects, and the module also manages a `subscriberToken` cookie for
the visitor.
