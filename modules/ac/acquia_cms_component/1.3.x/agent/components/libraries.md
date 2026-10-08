<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shared JS library components

Two `type: library` Single Directory Components under `components/libraries/`. They ship no PHP and no
Drupal `*.libraries.yml`; the contrib `component` module exposes them as `component/<name>` asset
dependencies that other components (here, `react_component_block`) list under `dependencies:`.

## `react_library`

File: `components/libraries/react_library/react_library.component.yml` (twig template is the required
empty stub). Declares four **external** JS assets loaded from the unpkg CDN via protocol-relative URLs:

- `//unpkg.com/react@17/umd/react.production.min.js`
- `//unpkg.com/react-dom@17/umd/react-dom.production.min.js`
- `//unpkg.com/create-react-class@15.7.0/create-react-class.min.js`
- `//unpkg.com/babel-standalone@6.26.0/babel.min.js`

Each is `{ type: external, minified: true, crossorigin: anonymous }`. babel-standalone is included so that
components served with `type: 'text/babel'` (like `react_node_block.js`) are compiled in the browser.

## `api_library`

Files: `api_library.component.yml` + `drupal-api.js` (empty twig stub template). Registers a global
`window.DrupalApi` constructor. Methods on `DrupalApi.prototype`:

- `baseUrl` default `"/jsonapi/"`; `setBaseUrl(url)`.
- `setEndpoint(endpoint)` → `apiUrl = baseUrl + endpoint`; `getApiUrl()`.
- `setParams(params)` → appends `?<parseParams(params)>` to `apiUrl`.
- `parseParams(params)` → recursively serializes a nested object into `key[sub]=value&...`, then
  `encodeURI()`.
- `callApi(callback, inputData, url)` → `fetch(url, {method:'GET', cache:'no-cache', ...inputData})`;
  on HTTP 200 parses JSON and invokes `callback(data)`, else passes `{}`; `.catch` logs to console.

`props` is empty for both. `drupal-api.js` is declared `preprocess: false`.

## Operate

These components are consumed as dependencies, not placed directly. Enabling `acquia_cms_component` +
`component` makes them available; any custom SDC can depend on `component/react_library` and/or
`component/api_library` to reuse the React runtime and the JSON:API helper.
