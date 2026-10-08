<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# disable_author — agent orientation

Hides the node-form "Authoring information" fieldset for configured roles via `hook_form_alter` (`$form['author']['#access']=FALSE`).

- Config: `/admin/config/disable_author/settings` (perm `administer site configuration`); config `disable_author.settings` key `disallowed_roles`.
- NOTE: UI-hide only, NOT access control — authorship still changeable via REST/programmatic paths. No security enforcement claimed.
- No DB/external calls. Sound.
- Read: `disable_author.module`.
