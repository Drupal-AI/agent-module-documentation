<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Redirect to Front redirects visitors away from the canonical page of selected content types (and bundles) to the site front page for the current language.

---

An event subscriber (`RedirectSubscriber`) listens on the kernel request at priority 28 — above Dynamic Page Cache (27) — and matches the current route against the canonical-route pattern `entity.<type>.canonical`. If the matched entity type (and, optionally, its bundle) is enabled in `content_redirect_to_front.settings`, the request is answered with a `TrustedRedirectResponse` to `/` in the active language. The front page itself is never redirected.

Two permissions govern the module: `access content_redirect_to_front form` guards the settings page at `/admin/config/content/content_redirect_to_front_settings`, and `skip redirecting to front for all content` lets trusted roles bypass the redirect and still view the canonical page (optionally shown a configurable warning message explaining why they can see it). Configuration is per entity type with optional per-bundle refinement: checking a type redirects all its bundles unless specific bundles are selected. Typical setup is enabling the module, granting the skip permission to editors/admins, and ticking the content types to redirect.

---

- Redirect a content type's node pages to the front page
- Redirect only specific bundles of an entity type
- Redirect all bundles of a type by checking the type alone
- Hide "landing" nodes whose canonical URL should not be reachable
- Keep editors able to view redirected content via the skip permission
- Grant the skip permission to a specific role
- Show a warning message to skip-permission users on redirected pages
- Customise the skip warning message text
- Redirect to the language-specific front page automatically
- Leave the front page itself unaffected
- Redirect non-node entity types that expose a canonical route
- Combine with menus so only intended pages are directly reachable
- Turn redirection on/off per type without uninstalling
- Restrict access to the settings form via its dedicated permission
- Review current redirect config via `content_redirect_to_front.settings`
- Temporarily disable a redirect by unchecking its type/bundle
- Use per-bundle settings to redirect some bundles but not others
