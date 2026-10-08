<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Link Fragment - agent index

Adds a validated 'Link fragment' (anchor) field to the menu link content form. Depends on
`menu_link_content`. No config/routes/permissions/services.

Key facts (`menu_link_fragment.module`):
- `hook_form_menu_link_content_form_alter()` adds `fragment` textfield (default from `options['fragment']`).
- Validate handler restricts to `^[A-Za-z0-9-_]+$` (no spaces/special chars).
- Submit handler merges `fragment` into the link entity's `link` options and saves -> URL gets `#fragment`.
- `hook_page_attachments()` attaches a library on admin routes only. Version dir `3.0.x`.
