<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS Component ships a small set of Single Directory Components (SDC) for Acquia CMS, including a React-based block that lists recent nodes over JSON:API.

---

Acquia CMS Component is a component-library glue module for Acquia CMS (now "Acquia Drupal Starter Kit"). It contains no PHP code, routes, permissions or Drupal config; instead it provides three Single Directory Components under its `components/` folder, discovered through the contributed `component` (SDC) module. Two are `library`-type components — `react_library`, which loads React 17, react-dom, create-react-class and babel-standalone from the unpkg CDN, and `api_library`, which registers a small `DrupalApi` JavaScript helper for building JSON:API requests. The third, `react_component_block`, is a `block`-type component ("React Node Component Block") that renders a client-side React widget listing the most recently created nodes of a chosen content type and drilling into a node's summary. The module depends on `acquia_cms_common`, `component` and `jsonapi_extras`, and is meant to be enabled as part of the Acquia CMS component set so editors can place the recent-nodes block and developers can build further JS components on the shared React/JSON:API libraries.

---

- Add a client-side "recent nodes" block to an Acquia CMS site without writing a Views listing.
- Let editors choose which content type the block lists (Article, Page, Place or Person).
- Let editors choose how many items the block shows (5, 10, 20 or 30).
- Fetch node data in the browser from Drupal's `/jsonapi/node/<type>` endpoint, sorted newest-first.
- Render a spinner while the JSON:API request is in flight, then a clickable list of node titles.
- Expand an item to reveal the node's body summary and collapse back to the list.
- Reuse the bundled `DrupalApi` JS helper to build JSON:API URLs (base URL, endpoint, params) in custom components.
- Provide React 17 + Babel standalone as a shared `react_library` component so multiple JS components can share one runtime.
- Serve as a worked example of authoring Single Directory Components (block and library types) in a contrib module.
- Progressively decouple part of a Drupal page (React island) while keeping the rest server-rendered.
- Compose Acquia CMS pages that mix server-rendered content with a JSON:API-driven React panel.
- Give front-end developers a starting point for JSON:API-backed widgets on Acquia CMS.
- Ship component form configuration (node type + item count) that Drupal's SDC block UI exposes.
- Depend on `jsonapi_extras` so the site's JSON:API is available and customizable for the widget.
- Keep component markup, JS, CSS and metadata co-located in one directory per component (SDC pattern).
- Extend the component set that Acquia CMS installs by default.
- Demonstrate wiring an SDC `block` component's `form_configuration` to HTML data-attributes consumed by React.
- Prototype a decoupled listing UI on top of an existing Drupal content model.
- Provide reusable building blocks for Acquia CMS site builders.
- Enable the React node block on landing pages to surface recent Articles or People.
- Use as scaffolding for teams migrating listing widgets toward client-side rendering.
