# acquia_purge_geoip — agent start

Submodule of **acquia_purge**. Adds `Vary: X-Geo-Country` to Drupal responses so cached pages
vary by visitor country (Acquia Cloud's edge populates `X-Geo-Country`). No config, no UI, no
permissions — a single response event subscriber.

- Enable it and what it does → [configure/setup.md](configure/setup.md)
- Parent module → [../../../../1.5.x/agent/start.md](../../../../1.5.x/agent/start.md)
