<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Two Context reaction plugins that let a site builder attach HTML/JS snippets or asset libraries to any page selected by a Context's conditions.

---

The **Inject HTML snippet** reaction (`AttachSnippet`) stores a free-form snippet and a placement (page top or bottom) and renders it via `Markup::create()` so the exact markup — including `<script>` — is output on every page the context matches. The **Attach library** reaction (`AttachLibrary`) attaches a named Drupal asset library instead. Both are configured inside the Context UI as reactions on a context, so scoping (which pages, roles, paths) is handled by the parent Context module's conditions.

Because `AttachSnippet` outputs its configured snippet as trusted markup with no filtering, it is by design an admin tool for injecting raw HTML/JS — the ability to add or edit these reactions is gated behind the Context module's "administer contexts" permission, which is already a highly privileged, effectively site-scripting capability. Grant that permission only to fully trusted roles, since a snippet reaction can place arbitrary JavaScript site-wide. The module defines no routes, services, or permissions of its own and makes no outbound/HTTP calls. Setup: create or edit a context, add the "Inject HTML snippet" or "Attach library" reaction, enter the snippet or library name, choose placement, and save.
---
- Inject a raw HTML snippet into pages matched by a context
- Add site-wide analytics or tag-manager script via a context
- Place a snippet at the top or bottom of the page
- Attach a custom Drupal asset library on specific pages
- Load extra CSS/JS only where a context's conditions match
- Add a third-party widget embed to a section of the site
- Scope injected markup by path, role or other context conditions
- Insert a verification meta/script tag on all pages
- Add a chat widget snippet to selected pages
- Attach a library to pages without editing a theme
- Inject structured-data / JSON-LD script blocks
- Add a cookie-consent script through a context reaction
- Place A/B testing snippets on targeted pages
- Toggle injected assets by enabling/disabling the context
- Reuse existing context conditions to target injection
- Add footer tracking pixels to matched pages
- Attach a library defined in a custom module or theme
- Centralize snippet management in the Context UI