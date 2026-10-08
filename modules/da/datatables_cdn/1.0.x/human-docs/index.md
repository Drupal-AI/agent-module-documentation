# DataTables CDN — manual setup guide

**DataTables CDN** (`datatables_cdn`) registers Drupal asset libraries that load
the popular **DataTables** jQuery plugin — and its responsive extension — straight
from the public `cdn.datatables.net` CDN. DataTables turns a plain HTML `<table>`
into an interactive, sortable, searchable, paginated table. This module is the
"no download" alternative to the older DataTables module: instead of manually
placing the library files in your site's `libraries/` folder, you enable this
module and the assets are pulled from the CDN.

It's a developer/theming building block, not a click‑and‑go feature. Enabling it
makes three libraries available — `datatables_cdn` (the plugin), a
`datatables_responsive` variant, and a local `datatables` init library — which you
then attach to a render array or theme so the plugin enhances your tables. There
is no settings page. Its declared dependency is core's jQuery (the project also
declares an unusual `ckeditor` dependency — verify whether you actually need that
in your build).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Important: third‑party CDN egress and security

Because the CSS and JavaScript are declared as **external** assets, your visitors'
browsers fetch them directly from `cdn.datatables.net` — a third party — on every
page that uses them. Two consequences to plan for:

- **Content Security Policy / egress.** If your site uses a Content Security
  Policy, you must allow `cdn.datatables.net` as a script and style source, or the
  assets will be blocked. On sites with strict data‑egress or privacy
  requirements, be aware that every visitor makes a request to that external host.
- **No Subresource Integrity (SRI).** The external assets are declared without an
  SRI hash, so a compromised or man‑in‑the‑middled CDN could serve altered
  JavaScript that runs in your users' browsers. One of the CSS URLs is also
  protocol‑relative (`//cdn.datatables.net/…`), inheriting the page's scheme. If
  this risk matters to you, the safer options are to host DataTables locally
  instead, add an SRI hash, or lock the script sources down with a CSP. It's also
  wise to keep the pinned CDN version current so you pick up upstream security
  fixes.

This is a supply‑chain consideration rather than a bug in the module — but it is
the main thing to weigh before choosing the CDN approach over a self‑hosted one.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module only registers libraries. You use
it by attaching a library to your markup.

## How to use it

Attach one of the libraries to a render array via `#attached`, then render a
`<table>` (from Views or custom markup) for the plugin to enhance:

```php
$build['#attached']['library'][] = 'datatables_cdn/datatables';
```

Use `datatables_cdn/datatables` (the init library) or the raw
`datatables_cdn/datatables_cdn`, and `datatables_cdn/datatables_responsive` for
the responsive variant. The init script lives in the module's `js/datatables.js`
and initialises tables carrying the `datatables` class; follow the DataTables.net
documentation for the plugin's own options.
