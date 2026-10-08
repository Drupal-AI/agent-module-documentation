# Permissions

`robotstxt.permissions.yml` defines one permission:

- **`administer robots.txt`** — access the settings form
  (`/admin/config/search/robotstxt`) and edit the robots.txt content.
  Marked as a maintenance task; grant only to trusted roles since it controls
  what search engines are told to crawl.

The public route `robotstxt.content` (`/robots.txt`) is `_access: TRUE` — open
to everyone, as a robots.txt must be.
