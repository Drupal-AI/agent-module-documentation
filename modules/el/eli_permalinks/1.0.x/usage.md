<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ELI Permalinks creates stable European Legislation Identifier (ELI) permalinks and resolves them to a destination URL or an attached file, using pluggable jurisdiction profiles.
---
An administrator creates `eli_permalink` config/content entities that each carry an `eli_path` (e.g. `/eli/es/...`) plus a destination — either a `destination_url` to redirect to, or a `destination_file` managed file to serve. The public resolver route `/eli/{eli_path}` (`_access: 'TRUE'`, GET/HEAD, `no_cache`) loads the matching **published** (`status = 1`) permalink and either issues a 302 `TrustedRedirectResponse` to the configured URL or streams the referenced managed file inline, in both cases emitting a `rel="canonical"` Link header. Jurisdiction `EliProfile` plugins (Spain, European Union shipped) encode how ELI components map to a path, and are collected via a tagged-service manager; an `EliRouteSubscriber` wires the resolver.

The resolver is intentionally public because ELI URIs are meant to be openly citable, and it only ever exposes destinations an administrator explicitly configured on a published permalink — the redirect target and the served file are admin-set entity references, not request input, so there is no arbitrary file read or SSRF (the redirect is a browser 302, not a server-side fetch). Managing permalinks requires the `administer eli permalinks` permission. Set up by enabling the module, choosing/adding a jurisdiction profile, and creating permalinks.
---
- Publish stable ELI (European Legislation Identifier) permalinks for legislation
- Redirect an ELI permalink to a canonical destination URL
- Serve an attached PDF/document file under an ELI permalink
- Emit a rel="canonical" Link header on every resolved permalink
- Use the Spain jurisdiction profile for Spanish ELI paths
- Use the European Union jurisdiction profile for EU ELI paths
- Add a custom jurisdiction profile via a tagged EliProfile plugin
- Manage permalinks from an admin list builder UI
- Restrict permalink management to the administer eli permalinks permission
- Publish/unpublish individual permalinks (only status=1 resolve)
- Cite legislation with a persistent, technology-neutral URL
- Point legacy legal URLs at current documents via permalinks
- Keep permalinks cache-friendly for redirects (max-age 3600)
- Map ELI path components consistently through profile logic
- Serve legislation documents inline with correct MIME type
