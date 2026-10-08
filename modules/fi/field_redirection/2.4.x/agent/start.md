<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Redirection — agent index

Adds one field formatter, `field_redirection_formatter` ("Redirect"), that redirects the
entity page to the URL in a `link` / `entity_reference` / `file` field when the entity is
viewed. No configure route or settings form; state is the formatter `type` + `settings` on a
field component in an `entity_view_display` config entity. One permission, `bypass redirection`.

- **The formatter, its settings (`code`, `404_if_empty`, `page_restrictions`, `pages`), where
  stored, redirect-loop/cron/maintenance guards, and the "Full content only" rule** →
  [configure/redirect-formatter.md](configure/redirect-formatter.md)
- **The `bypass redirection` permission and how it changes behavior** →
  [permissions/bypass-redirection.md](permissions/bypass-redirection.md)

Key fact: attach `field_redirection_formatter` to a link/reference/file field on the **Full
content** view mode. On view it resolves the destination and sends a `RedirectResponse` with
`settings.code` (default 301). It no-ops under CLI/Drush and does not redirect users holding
`bypass redirection`.
