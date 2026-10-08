<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# React Node Component Block

Single Directory Component (`type: block`) at
`components/block/react_component_block/`. Machine name: `react_component_block`. Human name in metadata:
"React Node Component Block". Rendered as a placeable block by the contrib `component` (SDC) module.

## Files

- `react_component_block.component.yml` — SDC metadata.
- `react-node-component.html` — the `template` (a single `<div class="react-node-component">`); note the
  React mount actually targets elements with class `react_component_block`, not this div.
- `react_node_block.js` — the React component (served with `attributes: { type: 'text/babel' }`, so it is
  compiled in the browser by babel-standalone).
- `react_node_block.css` — spinner + list styling.

## Configuration (`form_configuration`)

The SDC block form exposes two selects (stored on the block, surfaced to the browser as HTML
data-attributes):

- `type` — select, options `article` / `page` / `place` / `person`, default `article`. Becomes
  `data-type`, used as the JSON:API resource: `node/<type>`.
- `display_item` — select, options `5` / `10` / `20` / `30`, default `5`. Becomes `data-display-item`,
  used as JSON:API `page[limit]`.

`props` is declared empty (`properties: {}`). `dependencies:` lists `component/react_library` and
`component/api_library`, so placing this block pulls in React and the `DrupalApi` helper.

## Client-side data flow (`react_node_block.js`)

- IIFE receiving `DrupalApi`; instantiates `drupalApiOj = new drupalApi()`.
- A `create-react-class` component `Node`:
  - `componentDidMount()` reads `this.props.attributes` (the copied data-attributes), sets endpoint
    `node/<data-type>`, params `{ sort: "-created", page: { limit: <data-display-item> } }`, then
    `drupalApiOj.callApi(cb)` — a `fetch()` GET to `/jsonapi/node/<type>?...`.
  - `render()` shows a `.loader` spinner until loaded, then `No results` if empty, else a `<ul>` of node
    titles. Each `<a>` links to `article.attributes.path.alias`; clicking calls `loadBody` to show that
    node's `attributes.body.summary`; a "Back" link (`clearBody`) returns to the list.
- Bottom of the file: iterates `document.getElementsByClassName('react_component_block')`, copies every
  attribute except `class`/`id` into an `attributes` object, and `ReactDOM.render(<Node .../>, element)`.

## Operate

1. `drush en acquia_cms_component` (installs SDC discovery via `component`).
2. Enable JSON:API (pulled in via `jsonapi_extras`); ensure the viewing user may read `node/<type>` — the
   list is only as populated as JSON:API access allows (anonymous sees only published, access-granted
   nodes).
3. Place the "React Node Component Block" through the `component` SDC block UI; pick `type` and
   `display_item`.

No Drupal route, permission, service, or settings form is added by this module (`configure: null`). The
listing is entirely client-side; SEO/crawlers see only the empty mount `div`.
