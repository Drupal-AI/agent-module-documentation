Custom Page Title overrides the rendered page title on administrator-chosen paths through a single settings form of path-to-title rules.

---

The module adds one admin form (`/admin/config/custom-page-title/custom-page-title-settings`, under Configuration → System, guarded by `administer site configuration`) that stores an ordered, weighted table of rules in the `custom_page_title.settings` config object under the `custom_page_table` key. Each rule holds an enabled checkbox (`status`), one or more path patterns (`pages`, one per line, using Drupal's path-matcher syntax such as `/node/1`, `/hello-world`, or `/node/*`), a replacement `title` (max 60 characters), a drag-and-drop `weight`, and — when the core `language` module is installed or the site is multilingual — a set of `language` checkboxes limiting the rule to selected languages. At runtime `custom_page_title_preprocess_page_title()` (in `custom_page_title.module`) reads the config, resolves the current path and its alias via `path.current` / `path_alias.manager`, and for each enabled rule whose `pages` pattern matches (and whose language filter, if any, includes the current language) replaces `$page['title']` with the configured title. Rules are evaluated in table order, so a later matching rule wins. The form validates that each non-wildcard path starts with `/`, is not duplicated within a row, and resolves to an existing route/alias. The module ships no permissions, services, entities, plugins, or Drush commands; uninstalling it deletes the config object.

---

- Give the front page a marketing title different from the site name without touching site configuration.
- Set a distinct `<title>`/heading on a specific node (e.g. `/node/42`) that you cannot easily edit.
- Override the title of a path-aliased page such as `/about-us` by matching its alias.
- Apply one title to a whole section using a wildcard pattern like `/products/*`.
- Rename the title shown on a core or contrib route (e.g. `/user/login`) for branding.
- Provide a cleaner title for a view page whose default title is auto-generated.
- Change the title on a taxonomy term page for a campaign landing experience.
- Differentiate titles per language on a multilingual site by ticking only the relevant language checkboxes.
- Show an English-only title override while leaving other translations untouched.
- Maintain several title overrides in one place with drag-and-drop ordering to control precedence.
- Temporarily disable a title override by unchecking its Enabled box, keeping the rule for later.
- Batch multiple path patterns in a single rule by listing several paths, one per line.
- Correct an awkward auto-generated title on a search or listing page.
- Localize the title of a shared page for a specific launch or event.
- Keep title overrides in exported configuration so they deploy with the site.
- Quickly A/B different page titles for SEO by editing the replacement title text.
- Set a friendlier title on an admin-facing utility page for internal users.
- Override the title on a webform or contact page path.
- Give a consistent title to several campaign URLs that share a path prefix via a wildcard.
- Remove a stale title by deleting its row with the per-row Remove button.
- Preview a title change on staging (config is exportable) before pushing to production.
- Apply a title only when a rule's languages match, leaving default behavior on other languages.
