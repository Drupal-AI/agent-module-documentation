<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Iconify Field adds an icon field to Drupal — a field type, a modal icon-picker widget and an inline-SVG formatter — backed by the Iconify icon sets, plus a CKEditor 5 submodule for placing icons in body text and an `iconify_field()` Twig function for templates.

---

Sites constantly need icons in structured places: a card's glyph, a service-listing marker, a call-to-action's symbol, a menu-item badge. Storing that as a plain text class name works until an editor mistypes it, and using an image field per icon is heavy and inconsistent. Iconify Field gives you a dedicated `iconify_field_icon` field type whose values are `collection:name` strings (e.g. `mdi:home`, `tabler:user`), an "Icon Picker" widget that opens a searchable modal listing every collection and icon, and an "Icon" formatter that renders the selection as **inline SVG with no client-side JavaScript**. The icon set is Iconify, which aggregates well over a hundred open collections — Material Design Icons, Bootstrap Icons, Font Awesome's free set, Tabler, Simple Icons and many more — under one naming scheme. The crucial implementation detail is that icons come from the **`iconify/json` PHP package installed by Composer**, not from Iconify's public API: the `IconResolver` service reads collection JSON from disk through `Iconify\IconsJSON\Finder`, inlines the SVG `body` into the render array (sized to `1em` by default so it inherits font size and `currentColor`), and caches the result in `cache.render`. That means no runtime request to a third-party host — good for privacy, offline builds and strict CSPs — but the icon data is a sizeable Composer dependency and updating icon sets is a Composer operation, not a UI one. Per-item options let editors add extra CSS classes and control accessibility (mark an icon decorative → `aria-hidden`, or give it an accessible name → `aria-label` + `role="img"`). Beyond the field, the module exposes a reusable `#type => iconify_field` form element for custom forms, anonymous JSON endpoints that back the picker (`/api/iconify_field/collections`, `/api/iconify_field/icons/{collection}`), and the bundled `iconify_field_ckeditor` submodule which adds a CKEditor 5 toolbar button that inserts icons as `<span data-icon="…">` markup. Core requirement is a notably tight `^11.2`, so the main module will not install on Drupal 10 (the CKEditor submodule alone declares `^10.1 || ^11`).

---

- Add an icon field to a content type or other entity.
- Let editors pick an icon from a searchable modal listing every Iconify collection.
- Render a chosen icon as inline SVG with no client-side JavaScript.
- Show an icon on a card, tile or teaser.
- Add a marker icon to a service or feature listing.
- Restrict a field to specific icon collections (e.g. only `mdi` and `tabler`).
- Set a default collection so the picker opens on a familiar set.
- Store multiple icons in one field (unlimited-cardinality icon list).
- Place icons inside CKEditor body text via the `iconify_field_ckeditor` submodule.
- Embed a single icon in a Twig template with `{{ iconify_field('mdi:account') }}`.
- Colour an icon from the theme (icons inherit `currentColor`).
- Size an icon to the surrounding text (`1em`) or to its native size.
- Add extra CSS classes to a rendered icon per field item.
- Mark an icon decorative so screen readers skip it (`aria-hidden`).
- Give a meaningful icon an accessible name (`aria-label` + `role="img"`).
- Avoid mistyped icon class names by using a validated picker.
- Keep icon rendering offline / CDN-free (icons ship as a Composer package).
- Reuse the `#type => iconify_field` picker element in a custom form.
- List available collections or a collection's icons via a JSON API.
- Expose an icon field over GraphQL (with `graphql_compose`).
- Import/export icon field values (with `single_content_sync`).
- Provide a consistent, design-system-wide iconography across content.
- Show an icon beside a heading or button label.
