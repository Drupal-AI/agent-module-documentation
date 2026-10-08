<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Automatic Anchors — settings reference

Config object: `auto_anchors.settings`. Form: `\Drupal\auto_anchors\Form\SettingsForm`
at `/admin/config/auto_anchors/settings` (permission `administer automatic anchors`, `restrict access: true`).
All four keys are consumed only by the client-side `js/auto_anchors.js` via `drupalSettings`.

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `root_elements` | string (comma-separated CSS selectors) | `body` | Container(s) to search within. Combined with each `anchor_elements` entry to form the jQuery selector. |
| `anchor_elements` | string (comma-separated CSS selectors) | `h2, h3, h4, h5, h6` | Elements inside the roots that receive generated ids. Need not be headings — any selector works. |
| `link_content` | string (text/HTML) | `#` | Content placed between the inserted `<a>…</a>` permalink tags. Shown only to users with `show automatic anchor links`. Rendered as HTML by jQuery `.append()`. |
| `exclude_admin_pages` | boolean | `true` | When true, the library and settings are not attached on admin routes (`router.admin_context`). |

## How the selector is built
For roots `[body]` and anchors `[h2, h3, h4, h5, h6]` the JS produces
`body h2, body h3, body h4, body h5, body h6`. Note the config stores the anchor list as
`h2, h3, h4, h5, h6` (with spaces); the JS splits on `,` and trims are not applied to the parts before
concatenation, but the leading space is harmless inside a descendant selector.

## Behaviour notes
- Id generation is idempotent per load and never overwrites an element's existing id.
- The inline permalink is appended **inside** the matched element, so for a heading the `#` link becomes
  the last child of the heading.
- `show automatic anchor links` is evaluated per user inside `hook_page_attachments()`, so the emitted
  `drupalSettings` differ by permission; on a site with aggressive page caching, confirm the render cache
  varies appropriately (the hook adds no explicit cache context for this permission).

## Read-only inspection
- `drush cget auto_anchors.settings` — dump current values.
- `drush pmu`/`pml` — module status. (Do not mutate on shared sites.)
