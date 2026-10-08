<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# localgov_content_access_control — agent start

**Config-only** LocalGov Drupal module that turns `workbench_access` into a ready-made, section-based
editorial access model. The module's own `.module` is empty — **all enforcement lives in
`workbench_access`**, not here.

On install it ships: an "Access Control" taxonomy vocabulary, a `localgov_access_control` node field on
the LGD Subsite/Service content types, a taxonomy-based `site_section` workbench_access scheme, and a
"Devolved Editor" role. `hook_install()` grants `use workbench access` / `access workbench` /
`view workbench access information` to all roles except anonymous and authenticated.

Assign editors to sections at `/admin/config/workflow/workbench_access`. Vocabulary is hierarchical
(parent term → child access). Depends on `workbench` + `workbench_access`.

Security note: this module ships config only; if you need to audit the actual access gate, review the
`workbench_access` module — that is where accessCheck/grant logic runs.
