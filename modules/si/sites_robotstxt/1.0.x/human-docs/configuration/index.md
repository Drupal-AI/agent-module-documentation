# Configuration

There are two places to configure: the per‑site robots.txt content, edited on each
site, and the global fallback behaviour, on the settings form.

## Set a site's robots.txt content

To give a site its own robots.txt, edit that site and fill in its **"Site specific
robots.txt additions"** field. This content is stored as part of the site's
SiteSetting configuration, so it is exportable alongside the site's other settings.

When a visitor requests `/robots.txt`, the module serves the active site's content;
if that site has none, it falls back to the global RobotsTxt configuration.

## Global behaviour settings

1. Log in as a user with the **`administer robots.txt`** permission (this
   permission is owned by the RobotsTxt module).
2. Go to **Configuration → Search and metadata → Sites Robots.txt**, or navigate
   directly to `/admin/config/search/sites-robotstxt`.

On this form you control the global behaviour, including:

- **Child‑site inheritance** — a child site inherits its parent site's robots.txt,
  and the child's own `/robots.txt` returns a 404 rather than serving separate
  content.
- **No‑context behaviour (optional)** — you can have `/robots.txt` return a 404 when
  no site context is active, rather than serving the global default.

## Save

Click **Save configuration**. Requests to `/robots.txt` reflect the active site's
content immediately. Because the output is read‑only and the form is permission‑
gated, there is no anonymous write surface to worry about.
