<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Disable Language lets you switch off one or more of a site's configured languages for anonymous/front-end visitors while keeping the language, its content, and its translations fully intact in the backend.

---

Disable Language adds a per-language "Disable language" flag (plus an optional "redirect language") to Drupal's normal language edit form at `/admin/config/regional/language`. The flag is stored as a third-party setting on each `configurable_language` config entity (`third_party_settings.disable_language.disable`), so nothing about the language entity itself changes — it is simply marked. Once a language is disabled the module removes it from the language switcher block, strips its `hreflang` alternate links from page `<head>`, and drops its URLs (and alternate URLs) from Simple XML Sitemap output. Visitors who request a page in a disabled language are redirected to a fallback: by default the front page, or the per-language "redirect language", except for a configurable allow-list of routes (`redirect_override_routes`) that instead redirect to themselves in an accessible language — password reset and the user edit form are pre-configured so reset links keep working. Two permissions gate the behaviour: `view disabled languages` lets privileged users (e.g. translators, admins) still see and use disabled languages, and `create content in disabled language` keeps the language available in content-form language selects. This makes it a staging tool for translations that are not ready for the public yet. Note the module cannot cleanly invalidate caches, so you must clear caches after changing its settings, and you should never disable every language or you can lock yourself out.

---

- Hide a work-in-progress translation from the public while translators keep editing it in the backend.
- Launch a multilingual site with only some languages live and reveal the rest later, without deleting or re-importing content.
- Remove a language from the front-end language switcher block without unconfiguring the language.
- Stop search engines from indexing an unfinished language by stripping its `hreflang` alternate links from the page head.
- Exclude a disabled language's URLs from the Simple XML Sitemap so crawlers never discover them.
- Let admins and translators (with `view disabled languages`) preview a disabled language while anonymous users are redirected away.
- Redirect visitors who hit a disabled-language URL to a chosen fallback language instead of the site front page.
- Keep password-reset and user-edit links working in a disabled language via the `redirect_override_routes` allow-list.
- Add your own routes to the redirect override list so specific pages resolve to themselves in an accessible language rather than the front page.
- Exclude certain paths from the disabled-language redirect entirely using the built-in request-path condition.
- Soft-launch a regional/marketing language for a limited internal audience before going public.
- Temporarily take a language offline during a large re-translation or migration without losing its content.
- Prevent editors without permission from authoring new content in a not-yet-public language (language dropped from content-form language selects).
- Allow trusted editors to still create content in a disabled language by granting `create content in disabled language`.
- Stage a site relaunch where new languages are all configured up front but disabled until the launch date.
- Keep a deprecated language's existing content reachable to admins while removing it from public navigation.
- Run acceptance testing on a translation in production behind the `view disabled languages` permission before making it public.
- Disable a language for the front end while continuing to run imports/migrations that populate its translations.
- Avoid the SEO penalty of half-translated pages by hiding the language until translation coverage is complete.
- Provide a reversible "off switch" for a language: flip the flag back off to re-enable it instantly (after a cache clear).
- Present a cleaner language switcher to visitors by hiding rarely-used or incomplete languages.
- Coordinate a phased rollout where different languages go live on different dates by toggling each language's flag.
- Protect an internal-only language (e.g. an editorial working language) from ever appearing to anonymous visitors.
- Combine with content-moderation workflows so a language stays hidden until its translations reach a published state.
