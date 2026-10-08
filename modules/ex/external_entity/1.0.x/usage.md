<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Consumes content from a remote source (typically another Drupal site running External Entity Server) as native, read-only Drupal content entities that can be rendered with view modes, listed in Views, and attached through entity reference fields — without importing or duplicating the data.

---

External Entity (machine name `external_entity`) is a framework, requiring no modules outside Drupal core, that turns remote resources into a first-class Drupal content entity type (`external_entity`). Site builders create a Connection to a remote server, then define External Entity Types (bundles) that map a remote resource + variation onto a render target. Data is fetched on demand over HTTP through a pluggable Connection Type (the shipped `external_entity_server` plugin talks to the [External Entity Server](https://www.drupal.org/project/external_entity) companion module), optionally authenticated by a pluggable Authentication Type (the shipped `basic_authentication` plugin adds HTTP basic auth). Each fetched item is exposed as an `external_entity` content entity whose properties are rendered by a Render Type plugin — the shipped `internal_entity` render type instantiates a local entity of a chosen type/bundle, maps remote properties onto its fields, and renders it through a normal view display. Fetched results are held in a dedicated `external_entity` cache bin (custom database backend supporting tag-based invalidation), and the module ships Views integration (query, row, field, filter, wizard), an entity-reference selection handler, and a reference formatter so remote content behaves like local content across the site-building UI. It provides four configuration entity types (type, connection, resource display, resource alteration) plus the `external_entity` content entity, five permissions, config schema, and three plugin types; it defines no Drush commands.

---

- Display news, events, or other content from a central Drupal site on many satellite sites without duplicating or migrating it.
- Map a remote content type (e.g. `article`) to a local External Entity Type and render it with existing view modes and field templates.
- Connect to a remote External Entity Server by domain and pick which exposed resources this site may consume.
- Add HTTP basic-auth credentials to a connection so protected remote resources can be fetched.
- Render remote items through a local entity type/bundle display by mapping remote properties onto local fields (the `internal_entity` render type).
- List and filter remote content in a standard View using the External Entity base table and the bundled Views wizard/row/field/filter plugins.
- Choose a view mode for the Views row so remote rows are rendered exactly like local entity teasers or full views.
- Attach remote content to local entities via an entity reference field targeting `external_entity`, using the External Entity selection handler for autocomplete.
- Render referenced remote entities in a chosen view mode through the External Entity reference formatter.
- Alter or normalize a remote resource property before display using Resource Alteration configuration entities.
- Cache fetched remote data in the dedicated `external_entity` bin to avoid a network round-trip on every page load.
- Let the remote server push targeted cache invalidations to the consumer so displayed content stays fresh when the source changes.
- Build a multi-site content hub where one authoritative site publishes and satellites subscribe and theme locally.
- Reuse remote taxonomy, media references, or other fields by mapping them onto local equivalents in Manage Display.
- Add a new remote backend by writing a custom Connection Type plugin (annotation `@ExternalEntityConnectionType`).
- Add a new credential scheme (token, OAuth, header key) by writing a custom Authentication Type plugin (`@ExternalEntityAuthenticationType`).
- Add an alternative rendering strategy by writing a custom Render Type plugin (`@ExternalEntityRenderType`).
- Expose remote resource variations (e.g. per-language or per-view-mode variants) and pick which variation a display uses.
- Keep the source of truth in one place while presenting live content, themed to each consuming site's design.
- Avoid decoupling: continue using blocks, Views, layouts, and field formatters against remote data.
- Give editors an admin UI under Structure and Configuration to manage types, connections, displays, and alterations.
- Restrict who can manage connections, types, displays, and alterations using the module's granular admin permissions.
