<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

| Permission | Machine name | Grants |
|---|---|---|
| Administer block Subtitle | `administer block subtitle` | Shows the **Subtitle** field on the block configuration form and lets the user set/change it. |

Defined in `block_subtitle.permissions.yml`. Checked in
`block_subtitle_form_block_form_alter()` via
`\Drupal::currentUser()->hasPermission('administer block subtitle')` — without it, the field is not
added to the form (and the entity builder is not registered), so the user cannot set a subtitle.

This permission only governs the **field**. Reaching the block configuration form at all still
requires core's `administer blocks` permission, so in practice a subtitle can only be set by someone
who already administers blocks; the separate permission lets you scope subtitle editing within that
group.
