<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Allowed HTML (ckeditor5_allowed_html) — agent index

A single **text-format filter plugin** that re-implements core's *"Limit allowed HTML tags and
correct faulty HTML"* filter, but with the **Allowed HTML tags list made editable** again (in core
CKEditor 5 that field is read-only / derived from the toolbar). Under CKEditor 5, core reads a
filter's `HTMLRestrictions` to build the editor's General HTML Support (GHS) allow-list, so making
this list editable is how you widen what CKEditor 5 permits without writing custom editor plugins.

- **The one plugin, its settings, how the allow-list is parsed and enforced, and how to enable it** →
  [plugins/filter.md](plugins/filter.md)

## What it actually is

- One plugin: `FilterAllowed` (filter id **`filter_allowed`**, label *"Limit allowed HTML tags and
  correct faulty HTML - Editable tag list"*), in
  `src/Plugin/Filter/FilterAllowed.php`, extending core `Drupal\filter\Plugin\FilterBase`.
  Type `TYPE_TRANSFORM_REVERSIBLE`.
- **No** `.routing.yml`, `.permissions.yml`, `.services.yml`, `.links.*`, `.module`, `.install`, no
  submodules, no Drush, no JS/CSS and **no CKEditor 5 plugin** of its own — it is purely an output
  filter. The "CKEditor 5" name refers to feeding GHS via the filter's restrictions.
- Config: no config object of its own; settings live inside the text-format entity
  (`filter_format.*`). Schema `filter_settings.filter_allowed` in
  `config/schema/ckeditor5_allowed_html.schema.yml` (`allowed_html` string, `filter_html_help`
  bool, `filter_html_nofollow` bool).
- Dependencies: core `filter` only (implicit; the `.info.yml` declares none). Core requirement
  `^8.8 || ^9 || ^10 || ^11`. Installed here as **1.5.x-dev** (git checkout, no packaged release).

## Mechanism (from source)

- `settingsForm()` exposes the editable **Allowed HTML tags** textarea (`allowed_html`) plus
  *Display basic HTML help* (`filter_html_help`) and *Add rel="nofollow" to all links*
  (`filter_html_nofollow`). If empty it seeds a default tag list.
- `process()` mirrors core `FilterHtml`: it runs **`Xss::filter($text, array_keys(allowed))`** for
  tag filtering, then `filterAttributes()` for per-tag attribute/value filtering.
- `getHTMLRestrictions()` parses the textarea into the standard restrictions array using the
  Masterminds HTML5 parser (custom `Tokenizer` subclass so tags like `<iframe>` parse as elements,
  not text). It **always** forces the global `*` attributes `style => FALSE`, `on* => FALSE`,
  `lang => TRUE`, `dir => {ltr,rtl}` — i.e. `style`, event handlers and JS URLs are always stripped
  (by `Xss::filter`), exactly as in core.
- `tips()` renders the standard HTML filter tips table (static examples, no user data rendered
  unescaped).

## Operate it

Enable the module, edit a text format at `/admin/config/content/formats/manage/<format>`, choose
*"…Editable tag list"* instead of core's filter, and edit the **Allowed HTML tags** field. Editing
text-format filters requires the core **`administer filters`** permission (a trusted, admin-level
permission). Add only the tags/attributes you actually need. See
[plugins/filter.md](plugins/filter.md).
