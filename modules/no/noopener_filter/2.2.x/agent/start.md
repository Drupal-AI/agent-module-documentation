# Noopener Filter — agent index

Adds `rel="noopener"` to links whose `target="_blank"`. Two independent mechanisms:
a **text-format filter** (`filter_noopener`) for WYSIWYG/CKEditor markup, and an optional
**`hook_link_alter()`** for Drupal-generated links gated by one config flag.

- **Turn it on (enable the filter per text format; enable the global link-alter flag) and where state lives** →
  [configure/setup.md](configure/setup.md)

Key facts:
- Filter plugin id `filter_noopener`, type `TYPE_HTML_RESTRICTOR`; enable it on a text format at
  `/admin/config/content/formats`. It only touches `<a target="_blank">` and adds `noopener` (not `noreferrer`).
- Global link-alter is off by default; config `noopener_filter.settings:filter_links` (bool). Toggle at
  route `noopener_filter.settings` → `/admin/config/noopener-filter/settings`.
- Permission: `administer noopener filter`. No config schema, no plugin types, no Drush, no dependencies.
