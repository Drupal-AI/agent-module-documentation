<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pages Restriction Access lets you list "restricted page | target page" pairs; when a visitor lands on a restricted path they are redirected to its target, unless they hold a bypass role or a session bypass was set for that page.

---

Configuration lives in one config object, `pages_restriction.settings`, edited at
`/admin/config/development/pages-restriction/settings` (route `pages_restriction.settings`,
permission `administer site configuration`). The main setting `pages_restriction` is a
textarea of one `restricted-path|target-path` mapping per line; `keep_parameters` (checkbox)
preserves query parameters on the redirect target; and `bypass_role` is a list of roles that
skip all restrictions. A kernel `REQUEST` event subscriber (`PagesRestrictionSubscriber`,
priority 215/210) runs on every request: it resolves the current path to its alias, and if a
logged-in user has a bypass role it returns early; otherwise, if the current alias matches a
restricted path (and no session bypass exists for it), it issues a `RedirectResponse` to the
mapped target (optionally with query parameters) and stops propagation. A companion service,
`pages_restriction.session_service` (`PagesRestrictionSessionService::setBypass($path)`),
records a path in the `pages_restriction_bypass` session array so a user who legitimately
reached a target can then be allowed onto the restricted page once. There is **no config
schema shipped**, no permissions of its own, and no Drush; the module is just the settings
form, the subscriber, a small path helper, and the session bypass service. A typical use is a
"thank you" page that should only be reachable right after submitting its form.

---

- Redirect visitors away from a "thank you" page unless they just submitted the related form.
- Force users off a confirmation/success page to the form that produces it.
- Keep a post-purchase or post-signup page from being deep-linked or bookmarked.
- Map several restricted pages to their respective entry pages in one textarea.
- Preserve URL query parameters through the redirect (enable "Keep Parameters").
- Let administrators (or any chosen role) bypass all page restrictions.
- Grant a one-time session bypass so a user can view a page right after the allowed step.
- Protect a download/asset landing page that should only follow a gated action.
- Redirect anonymous users away from pages meant for a specific flow.
- Send users who skip a multi-step flow back to the correct step.
- Guard a "payment complete" page against direct access.
- Configure restrictions entirely through the admin UI (no code).
- Apply restrictions site-wide via a kernel request subscriber (runs early, before routing output).
- Redirect to a target that carries the original query string for tracking (UTM, etc.).
- Allow editors/QA to reach restricted pages by giving their role a bypass.
- Use path aliases: matching is done against the current path's alias.
- Prevent regular authenticated users from reaching internal confirmation pages.
- Route users from a legacy URL to a canonical entry page.
- Combine bypass roles with session bypass for flexible access rules.
- Set up conversion-only pages that require the preceding funnel step.
- Manage all restriction rules in a single, deployable config object (`pages_restriction.settings`).
