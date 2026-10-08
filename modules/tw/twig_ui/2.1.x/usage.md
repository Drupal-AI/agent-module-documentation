<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig UI Templates lets you create and manage Twig templates from Drupal's admin UI, storing each as a `twig_template` config entity that overrides any file-based template with the same theme suggestion for the designated theme(s).

---

The module adds an admin interface at *Structure → Twig templates* (`/admin/structure/templates`) where each template is a `twig_template` config entity with a label, machine name, a **theme suggestion** (e.g. `node__article`), the **template code**, one or more target **themes**, and an enabled/disabled **status**. When a template is enabled, the `TemplateManager` service writes the code to a real `.html.twig` file under `public://twig_ui/<theme>/` (filename derived from the suggestion with underscores turned into dashes), and `hook_theme()` registers those files via `drupal_find_theme_templates()` so Drupal's theme system picks them up — overriding the equivalent theme/module template. Only one enabled template may exist per theme-suggestion + theme combination, enforced during form validation. A global settings form at *Configuration → System → Twig UI Templates* (`/admin/config/system/twig_ui`) controls which themes are selectable (`allowed_themes`: `all` or a `selected` list), which themes are pre-checked on new templates (`default_selected_themes`), and optional CodeMirror editor configuration (YAML) when the suggested `codemirror_editor` module is installed. Saving, disabling, or deleting a template flushes caches and rebuilds the kernel so template changes take effect immediately. The templates directory is protected with an `.htaccess`, and a runtime requirement warns if that directory is missing or unprotected. Access is governed by three restricted permissions.

---

- Override a core or theme template (e.g. `node__article.html.twig`) without touching the theme's codebase or a deployment.
- Create a one-off template override for a single theme suggestion straight from the admin UI.
- Prototype markup changes to a block, field, or view template live and iterate quickly.
- Maintain site-specific template overrides as exportable configuration (`twig_ui.template.*`) instead of files in version control.
- Apply the same template override to several themes at once by checking multiple themes on one entity.
- Restrict which themes editors may target by switching `allowed_themes` to `selected` and listing themes.
- Pre-select the themes that should be checked by default on every new template via `default_selected_themes`.
- Give non-developers a governed way to adjust presentation markup without shell or Git access.
- Temporarily disable a template override (toggle status off) without deleting it, reverting to the file-based template.
- Clone an existing Twig UI template as the starting point for a variant with the built-in Clone form.
- Edit template code with the CodeMirror editor (syntax highlighting, line numbers) by enabling `codemirror_editor`.
- Configure CodeMirror behavior per site (line numbers, buttons) through the settings form's YAML field.
- Load an existing file-system template's code into the editor as a starting point (the "load template" AJAX helper).
- Override templates for an admin theme (e.g. Claro) separately from the front-end theme.
- Ship template overrides between environments via config export/import.
- Enforce that only one active override exists per suggestion/theme so overrides never conflict.
- Provide emergency, hotfix-style markup changes on production when a code deploy is not possible.
- Build a small library of reusable presentational snippets managed centrally in config.
- Programmatically create or update templates from custom code using the `twig_template` entity storage.
- Read the active override for a theme via the `twig_ui.template_manager` service (`getTemplatesByTheme`, `templateExists`).
- Audit which theme suggestions are currently being overridden across all active themes.
- Keep template overrides out of the theme so theme updates never clobber custom markup.
- Grant a trusted "template administrator" role the `administer twig templates` permission while withholding global settings.
- Ensure a template file is removed automatically when the entity is disabled or deleted (no stale `.html.twig` left behind).
- Standardize a repeated markup change (e.g. adding a wrapper/class) across suggestions from one place.
