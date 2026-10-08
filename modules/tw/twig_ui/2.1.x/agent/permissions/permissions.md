<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

All three are declared in `twig_ui.permissions.yml` and marked `restrict access: true`
(they grant powerful, security-relevant capabilities — writing Twig that renders in themes).

| Permission | Gates |
|---|---|
| `administer twig templates` | Full CRUD on `twig_template` entities: the collection `/admin/structure/templates`, add/edit/delete/clone forms, and the "prepare templates directory" route. This is also the entity's `admin_permission`. |
| `administer twig ui templates settings` | The global settings form `/admin/config/system/twig_ui` (`allowed_themes`, theme lists, CodeMirror config). |
| `load twig templates from file system` | The two AJAX endpoints (`twig_ui.template_list_load_ajax`, `twig_ui.template_load_ajax`) that read existing file-system templates into the editor. |

Security note: `administer twig templates` effectively lets its holder author template markup
that is rendered by the site's themes, so treat it as a trusted, developer-level permission
(hence `restrict access: true`).
