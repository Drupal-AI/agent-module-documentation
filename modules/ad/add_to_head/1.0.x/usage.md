<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Add To Head lets site builders define named "profiles" of arbitrary HTML, CSS, or JavaScript that get injected into pages, scoped to specific paths and user roles.

---

The module stores an admin-editable list of **profiles** in the `add_to_head.settings` configuration object, each with a unique machine `name`, a block of raw `code`, a `scope`, and path/role visibility rules. At page-render time, `hook_page_attachments_alter()` appends every profile whose `scope` is `head` into `#attached['html_head']` (rendered early in the document `<head>`, before CSS/JS), and `hook_page_bottom()` appends every profile whose `scope` is `scripts` near the end of the page output. A third scope, `styles`, is defined in the schema and offered in the profile form but the corresponding `hook_css_alter()` implementation is an intentional no-op ("this does not work yet"), so CSS-scoped profiles do not currently render anywhere. Each profile's visibility is gated by two independent rules evaluated with core's block-visibility-style logic: a `paths` rule (`include`/`exclude` against a newline-separated list of Drupal internal paths, wildcards, and `<front>`, matched against the current path, its alias, and the raw `q` query) and a `roles` rule (`include`/`exclude` against a list of role IDs for the current user). Profiles are not config entities — they are a plain associative array keyed by the profile's own machine name inside one config object, resolved on admin edit/delete routes by a custom `ParamConverter`. Other modules can add or alter profiles programmatically via `hook_add_to_head_profiles_alter()` without touching the UI-managed config.

---

- Insert a Google Analytics or Google Tag Manager snippet into every page's `<head>`.
- Add a Facebook/Meta remarketing pixel that fires only on the front page.
- Drop a Google Search Console or Bing Webmaster verification `<meta>` tag site-wide.
- Add an Open Graph or Twitter Card `<meta>` tag override on a set of marketing pages.
- Inject a custom `<link rel="canonical">` tag on specific paths without editing a template.
- Add a third-party chat widget script (e.g. a support widget) at the bottom of every page.
- Load an A/B testing or personalization snippet only for anonymous (non-authenticated) visitors, via role exclusion.
- Show a cookie-consent banner script on all pages except an "embed" or "print" path.
- Add a custom favicon `<link>` tag without modifying the active theme.
- Insert a `<meta name="robots" content="noindex">` tag on a staging-only set of paths.
- Add Schema.org JSON-LD structured data markup to specific content paths.
- Inject a temporary maintenance/announcement banner script scoped to only the front page.
- Add a third-party heatmap or session-recording script (e.g. for UX research) sitewide.
- Insert a custom `<meta name="viewport">` override for a specific microsite section under one path.
- Load a web font `<link>` preconnect/preload hint into the head for performance tuning.
- Add debugging or QA instrumentation JavaScript visible only to users with an "administrator" or "QA" role.
- Insert a print stylesheet `<link>` tag scoped to a "print/*" path pattern.
- Add a translated or region-specific tracking pixel that only fires on paths under a language prefix.
- Drop in a security-related `<meta>` header (e.g. CSP report-only meta tag) for testing.
- Insert affiliate or partner tracking code that should only run on specific landing pages.
- Add a custom `<meta name="apple-mobile-web-app-capable">` tag for iOS home-screen behavior.
- Load a chatbot or live-support script only for authenticated "customer" role users.
- Insert a one-off holiday/seasonal banner script without a code deploy, removable by deleting the profile.
- Add vendor-required verification code (e.g. Pinterest, Yandex) as a head-scope profile.
- Use `hook_add_to_head_profiles_alter()` to ship a profile in a custom module's code instead of the UI, e.g. for version-controlled tracking snippets.
- Programmatically read all currently active profiles with `add_to_head_get_settings()` for auditing what scripts a site injects.
- Programmatically write profiles with `add_to_head_set_settings()` from a deployment script or configuration import routine.
- Restrict an experimental script to only the "administer add to head"-permitted staff by combining role visibility with a QA role.
- Quickly disable a third-party script sitewide by deleting or editing its profile from `/admin/config/development/add-to-head` without a code change.
- Stage multiple marketing pixels (Facebook, Google, LinkedIn) as separate named profiles so each can be toggled independently.
