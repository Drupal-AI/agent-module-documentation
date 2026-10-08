<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST resource plugins

Two `@RestResource` plugins expose the CSV datasets as JSON. Both extend core `rest`'s
`ResourceBase` and only implement `get()`. They require core `rest` (and typically
`serialization`) enabled, the resource enabled/configured (formats + auth) in REST config, and the
`restful get <resource-id>` permission granted to the calling role — standard core REST gating.

## `deprecation_versions` — `GET /api/deprecation-versions`

File `src/Plugin/rest/resource/DeprecationVersionsResource.php`, id `deprecation_versions`.
Returns a `ResourceResponse` describing what is available:

- `available_target_versions` — from `DataSource::getAvailableTargetVersions()` (string ints, e.g.
  `["11","12"]`, parsed from the `NN_` file prefixes).
- `endpoint_pattern` — `"/api/deprecation-status/{target_version}"`.
- `endpoints` — map of each version to its status URL.
- `data_files_by_version` — the base file names grouped per version (via regex on
  `DataSource::$datafiles`).

No parameters; a discovery/index endpoint.

## `deprecation_status` — `GET /api/deprecation-status/{target_version}`

File `src/Plugin/rest/resource/DeprecationStatusResource.php`, id `deprecation_status`,
canonical `/api/deprecation-status/{target_version}`.

- `get($target_version)` validates `$target_version` against
  `DataSource::getAvailableTargetVersions()`; an unknown version returns a `400` with an `error`,
  `message` and `available_versions` body.
- On success, `getFileData($target_version)` iterates `DataSource::$datafiles`, keeps only files
  prefixed `<target_version>_`, resolves each via `DataSource::getFullPath($base, (int)$version)`
  (so private/updated copies win), and reads them with `fgetcsv($fh, 0, ';')`. Each file becomes a
  key (base filename without extension) mapping to an array of CSV rows. Returns the whole dataset
  for that version as JSON.

## Notes for agents

- These endpoints return the same public ecosystem report data the HTML pages render, as raw rows —
  no per-record access logic beyond the REST permission. They read whichever copy `getFullPath()`
  resolves (shipped or the private updated files).
- The status endpoint returns the entire per-version dataset in one response (all 15 files), so it
  is large; there is no filtering/pagination.
