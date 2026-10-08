<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Links (external) — agent index

**What it is.** A tiny frontend module that makes outbound links open in a new browser tab using a
client-side jQuery `window.open()` click handler — deliberately *not* `target="_blank"`, so the
rendered markup keeps validating. Version **2.0.0-alpha5** (**alpha**), core `^10 || ^11`, license
GPL-2.0-or-later. No composer or module dependencies beyond Drupal core.

**How it actually works (read the code, don't assume):**
- `external.module` → `external_page_attachments()` attaches the `external/external` library and
  `drupalSettings.external.externalpdf` (a single boolean mirroring `external_docs_enabled`) **only**
  when the `external_enabled` config flag is true **and** `external_active()` returns true (the current
  path/alias is not matched by the `external_disabled_patterns` list).
- `external_active()` builds a regexp from `external_disabled_patterns` (`preg_quote`-escaped; `*`
  expands to `.*` and the `<front>` token expands to the configured front-page path) and matches it
  against both the current path and its alias; a match disables the behaviour on that page.
- `js/external.js` → `Drupal.behaviors.external` binds a click handler to: external `http(s)` links
  (a host-vs-`location.hostname` string heuristic), any `a.newtab` link, and — if the PDF option is
  on — any `a[href*=.pdf]`. The handler is `window.open(this.href); return false;`. Anchors it has
  processed are tagged `.external-processed` so re-attachment does not double-bind.
- `src/Form/ExternalAdminSettings.php` → a `ConfigFormBase` settings form at
  `/admin/config/content/external` (route `external.admin_settings`, permission `administer external`,
  `restrict access: TRUE`): checkboxes `external_enabled` and `external_docs_enabled`, plus the
  `external_disabled_patterns` textarea.

**What it provides / does NOT provide.** Provides: one config object, one settings form + route, one
permission, one JS library, one admin menu link. No fields, formatters, filters, plugins, services,
entities, Drush commands, config entities, or update hooks (only `hook_uninstall` deleting its
config). It performs **no** server-side HTTP fetch — navigation is done entirely by the visitor's
browser.

**Config keys** (`external.settings`, schema in `config/schema/external.schema.yml`):
`external_enabled` (bool, default true), `external_docs_enabled` (bool, default false),
`external_disabled_patterns` (string; default `admin*`, `img_assist*`, `node/add/*`, `node/*/edit`).

**UX/accessibility caveats worth surfacing to whoever asks for this behaviour:** opening in a new tab
breaks the back button for that tab, is a context change that WCAG expects to be announced (this
module announces nothing and adds no external-link icon), and it takes the middle-/ctrl-click choice
away from the user because the click handler returns `false`.

**Solution docs:**
- [Configuration, route & behaviour](config/settings.md) — install/enable, the three settings, the
  admin route/permission, and exactly how the JS decides which links to open in a new tab.
