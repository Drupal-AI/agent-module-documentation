<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ELI Permalinks — jurisdiction profiles & resolver

## Resolver (`EliPermalinkController::resolve`)
Route `/eli/{eli_path}` (regex `.+`, GET/HEAD, `no_cache`, `_access: 'TRUE'`).
1. Builds `$path = '/eli/' . trim($eli_path, '/')`.
2. `loadByProperties(['eli_path' => $path, 'status' => 1])` — only **published** permalinks resolve.
3. If `destination_url` set → `TrustedRedirectResponse($url, 302, [...canonical Link...])` (browser redirect).
4. Else serves `destination_file` managed file: `file_system->realpath($file->getFileUri())`, guarded by `is_file`, streamed as `BinaryFileResponse` inline with the file's MIME type.

Both destinations are administrator-configured on the entity — never taken from the request — so `_access: 'TRUE'` exposes no arbitrary redirect target or file.

## Profiles (`EliProfileInterface`)
Tagged services `eli_permalinks.profile` collected by `EliProfileManager` (`!tagged_iterator`). Shipped: `SpainEliProfile`, `EuropeanUnionEliProfile`. A profile encodes how ELI components map to/from a path. Add one by implementing `EliProfileInterface` and tagging the service.

## Management
`EliPermalinkForm` / `EliPermalinkListBuilder` under `administer eli permalinks` (restrict access: true). `EliRouteSubscriber` wires resolver routing.
