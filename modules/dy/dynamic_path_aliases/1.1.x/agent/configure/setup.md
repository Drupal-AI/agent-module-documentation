<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Dynamic Path Rewrites

1. Enable the module.
2. Go to `/admin/config/search/path/rewrite` (requires `administer dynamic path rewrites`).
3. Add a **path rewrite** mapping an entity-type route to a custom base path. For example rewrite the node canonical route so articles resolve at `/article/{node}` and blog posts at `/blog-post/{node}` (rewrites can vary per bundle).
4. Save. Rewrites are stored as `path_rewrite` config entities and are exportable.

## How it works
- `PathRewriteProcessor` implements both inbound and outbound path processing.
  - Inbound: `getPathByRewrite()` maps an incoming custom path back to the real system route.
  - Outbound: `getRewriteByPath()` maps a system path to the custom path when generating URLs.
- Results are cached (via `PathRewriteManager`) so repeated requests stay fast.
- The add/edit forms use the `/path-rewrite/autocomplete` endpoint to look up target router paths; its input is XSS-filtered and matched with an escaped `LIKE` against the `router` table.

## Notes
- **Tokens are not supported** by design — this avoids per-request overhead. For token-based aliases use Pathauto instead.
- Works with any entity type route, not just nodes.
