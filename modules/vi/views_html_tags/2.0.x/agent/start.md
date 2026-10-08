<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views HTML Tags (views_html_tags) — agent index

A single admin settings form that widens the **HTML element** dropdowns core Views offers in a
field's *Style settings* ("Customize field HTML" and "Customize field and label wrapper HTML"). It
does this by editing one core config value — `views.settings:field_rewrite_elements` — the shared
list of wrapper elements every Views field's rewrite/style UI reads from. There is **no Views plugin,
service, or field handler here**: the whole module is one `FormBase` (`ViewsHtmlTagsSettings`) at
`/admin/config/user-interface/views-html-tags`, a permission, a menu link, and install/uninstall
hooks. Enter a comma-separated list of tag names (e.g. `div,span,article,time`); the form lowercases
each for the config key and uppercases it for the label, then writes the map back to
`views.settings`. Submitted text is allowlist-validated to `^[a-zA-Z0-9,]+$`, so only bare
alphanumeric tag names (no attributes, angle brackets, or spaces) can be stored.

- **Depends on:** core `views` (info.yml `dependencies: drupal:views`). README also assumes Filter/User/System (all core).
- **Core:** `^10.3 || ^11`. **Package:** Views. **Version:** 2.0.3.
- **Settings page / configure route:** yes — `views_html_tags.settings` (`configure` in info.yml points here).
- **Permissions:** one — `administer views html tags`.
- **Drush:** none. **Services:** none. **Plugin types:** none. **Config schema:** none (its own `views_html_tags.settings` keys ship no schema).
- **Own config keys:** `views_html_tags.settings:views_html_tags_default` (snapshot of the pre-install element list), `views_html_tags.settings:views_html_tags_temp` (optional seed applied on install). The live list it edits is core's `views.settings:field_rewrite_elements`.

## What you'd do → where
- Add/edit the wrapper-element list; understand the form, validation, and config mapping → [`agent/configure/settings.md`](configure/settings.md)

## Key facts (real machine names)
- **Route:** `views_html_tags.settings` → path `/admin/config/user-interface/views-html-tags`, `_form: \Drupal\views_html_tags\Form\ViewsHtmlTagsSettings`, `_permission: 'administer views html tags'`.
- **Form class:** `Drupal\views_html_tags\Form\ViewsHtmlTagsSettings` (form id `views_html_tags_settings`), `src/Form/ViewsHtmlTagsSettings.php`.
- **Permission:** `administer views html tags` (`views_html_tags.permissions.yml`).
- **Menu link:** `views_html_tags.settings` under `system.admin_config_ui` (`views_html_tags.links.menu.yml`).
- **Helper:** `views_html_tags_get_default()` (`views_html_tags.module`) — returns core `views.settings:field_rewrite_elements` as a comma-joined string for the form default value.
- **Core config it writes:** `views.settings:field_rewrite_elements` (map of `tag => LABEL`).
- **Own config keys:** `views_html_tags.settings:views_html_tags_default`, `views_html_tags.settings:views_html_tags_temp` (no schema file).
- **Install/uninstall:** `hook_install` snapshots the current element list into `views_html_tags_default` and, if `views_html_tags_temp` is set, applies it to `views.settings` (`views_html_tags.install`).
- **No security surface.**
