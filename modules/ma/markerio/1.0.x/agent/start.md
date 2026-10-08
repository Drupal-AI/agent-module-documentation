# Marker.io — agent index

Embeds the Marker.io visual feedback / bug-reporting widget site-wide (via a cache-friendly lazy
builder) for users with the `access markerio` permission. Needs a Marker.io project key +
subscription. Config UI: `markerio.settings` (`/admin/config/system/markerio`). Provides config
schema + 2 permissions; no Drush, no plugin types.

- **Settings keys, permissions, how/where the widget is attached, and the drupalSettings contract** →
  [configure/settings.md](configure/settings.md)

Key facts:
- `markerio.settings`: `project` (project key, string), `nid` (track node id, bool).
- Permissions: `administer markerio configuration` (settings form), `access markerio` (see widget).
- Attach path: `hook_page_bottom()` → `#lazy_builder markerio.lazy_builder:build`; the builder
  early-returns (empty) unless the user has `access markerio` and a project key is set.
- Passes `drupalSettings.markerio` = `{project, user_email, user_name, [nid]}`; authenticated
  users' email/name come from their account. Widget UI + issue routing are Marker.io's SaaS.
