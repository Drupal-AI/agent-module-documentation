Forces the admin/UI interface language (t() output) to English — or a per-user chosen language — on admin and configured wildcard paths, regardless of the URL's language prefix, without touching content translations.

---

Admin Language t() function Override decorates Drupal's `string_translation` service so that on matched paths every interface string is rendered in a forced language. It targets the workflow problem where editing a translation under a localized path prefix (e.g. `/fr-ca/node/123/edit`) also flips the whole administrative chrome — toolbar, buttons, field labels, form summaries — into that language. Because it intervenes only at string-translation time (not in the language negotiator or routing), the content language context is preserved, so multilingual fields still load, display, and save in their real language. Which paths are affected is fully configurable through a wildcard textarea (defaults include `/admin/*`, `/*/edit`, `/*/delete`, `/*/revisions`, `/*/layout`, `/*/translations`); any explicit `_admin_route` is also treated as matched. Each administrator can additionally pick their own preferred admin interface language on their user edit form; when they leave it at "site default", matched paths fall back to English. Requires core's Language module; configuration lives at `/admin/config/regional/admin-language-t-function-override` behind the `administer site configuration` permission.

---

- Keep the admin toolbar and menus in English while an editor works on a French or German translation of a node.
- Stop the node edit form's buttons and field labels from switching language when editing under a language-prefixed URL.
- Force English UI chrome on all `/admin/*` pages for a mixed-language editorial team.
- Let each administrator choose the interface language they personally prefer for back-end work via their user profile.
- Fall back to a consistent English admin UI for editors who have not set a personal preference.
- Standardize the language of screenshots and documentation captured from admin screens across a multilingual site.
- Reduce editor confusion on delete-confirmation pages (`/*/delete`) by keeping the confirmation UI in one language.
- Keep revision overview pages (`/*/revisions`) rendered in the chosen admin language.
- Keep Layout Builder admin UI (`/*/layout`) in a fixed interface language while laying out translated content.
- Keep the translation overview pages (`/*/translations`) in the admin's language rather than the target translation's language.
- Add or remove wildcard path patterns to broaden or narrow exactly where the override applies.
- Use `*` wildcards to match any language prefix (e.g. `/*/edit` matches `/fr-ca/…/edit`, `/de/…/edit`).
- Target a very specific content type's edit pages (e.g. `/fr-ca/brochures/*/edit`).
- Temporarily disable the whole override with the single "Enable" checkbox without uninstalling the module.
- Ensure onboarding and support staff always see admin screens in the same language regardless of the site's active URL language.
- Preserve content field values in their correct language even while the surrounding UI is forced to English.
- Give translators a stable, single-language admin surface so only the content area changes language.
- Provide a per-user English admin experience on a site whose default language is not English.
- Normalize the admin interface language for QA and automated review of translated content.
- Avoid rewriting the global language negotiator just to keep the admin UI in one language.
