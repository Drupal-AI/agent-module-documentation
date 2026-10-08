<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup — Access Unpublished Linked Nodes

## Prerequisites
- `access_unpublished` (provides the token entity + `access_unpublished.access_token_manager`).
- `linkit` (authors the `data-entity-uuid` links this module rewrites).

## Steps
1. Enable the module and its dependencies.
2. On the relevant text format(s), enable the **Access Unpublished Linked Nodes** filter. It is a reversible transform filter (weight 199) and should generally run late.
3. Go to `/admin/config/content/access-unpublished-linked-nodes` and tick the content types whose links should be rewritten. If nothing is configured, the module defaults to `landing_page` and `page`.
4. Grant reviewers the `access_unpublished node <bundle>` permission for each bundle they should be able to mint tokens for.

## How preview works
- A reviewer opens an unpublished node with a valid `?auHash=<token>` (an access_unpublished token).
- `hook_preprocess_html()` validates the token and, if valid, adds the `access-unpublished-pass` class and attaches the module library.
- The text filter validates the token again and rewrites `<a data-entity-uuid>` links that point at *unpublished* nodes so their `href` becomes that node's token URL — so clicking through keeps the preview session alive.
- With `embed_block` installed, embedded custom blocks render their latest revision during preview.

## Notes
- `roleChecks()` only runs the rewriting for users whose roles are all in `anonymous`, `authenticated`, `viewer`; other roles (editors) are skipped by design.
- The module never bypasses `access_unpublished`; an invalid/absent token means no rewriting and no draft exposure.
