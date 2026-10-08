<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & trust model

## The one permission

`administer snippets` — declared with **`restrict access: true`** (`snippet_manager.permissions.yml`;
verified at runtime). It is the `admin_permission` of the `snippet` entity type and the single
requirement on **every** admin route (`snippet_manager.routing.yml`): create, edit, template/CSS/JS
edit, variables, duplicate, delete, enable/disable (the last two also carry `_csrf_token: TRUE`), and
the path-autocomplete controller.

## Why it is high-trust

A snippet's template is compiled as **Twig through core's `inline_template`** render element
(`SnippetViewBuilder::viewDefault()`, and `MiniSnippet::build()` for nested mini-snippets). That is the
standard, **non-sandboxed** Twig environment — the same one theme templates use. A snippet author can
also emit arbitrary CSS/JS to the page (`css`/`js` config → `SnippetLibraryBuilder`) and pull in
entities, views, blocks, menus and forms via variables. Practically, `administer snippets` is as
powerful as editing theme templates or running arbitrary PHP.

Consequence: grant `administer snippets` **only to trusted developers/site builders**, never to
content editors or any semi-trusted role. `restrict access: true` already makes Drupal warn on the
permissions form and withhold it from "trusted-but-not-fully" roles by default; keep it that way. The
`File` variable's own code comments make the same assumption explicitly ("intended for snippet
administrators who by definition are trusted").

## Rendering audience vs. authoring

Authoring is restricted, but **rendering is intentionally public where the author chooses**:

- A snippet's `view` access is granted to everyone once its `status` is enabled
  (`SnippetAccessControlHandler::checkAccess()`), so a snippet placed as a block, exposed as a page,
  or embedded in content renders for anonymous visitors — by the author's design.
- Snippet **page** exposure has its own access selector (`page.access.type`): `all` → `_access: TRUE`
  (public), `permission` → a chosen `_permission`, or `role` → chosen roles. This is the author's
  explicit choice per snippet (`RouteSubscriber::buildRoute()`).
- The `entity` variable has a **"Bypass access checks"** option (`bypass_access`) that renders a
  referenced entity ignoring its own view access — an intentional, admin-only toggle; be deliberate
  when combining it with a publicly-exposed snippet.

## No other permissions

The module defines no other permissions and no Drush commands. Block placement, layout building and
text-format configuration are gated by their respective core permissions as usual.
