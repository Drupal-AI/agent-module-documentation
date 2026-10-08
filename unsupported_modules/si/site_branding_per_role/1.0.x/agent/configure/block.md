<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Site Branding Per Role block

## Place the block
Add **Site branding per role block** to a region (Block layout). All configuration is on the block form — there is no separate settings page or permission.

## Options (`blockForm`)
- **Site logo / Site name / Site slogan** checkboxes (`access_site_logo`, `access_site_name`, `access_site_slogan`) — toggle each branding element. Descriptions link to Appearance/Theme and Site Information settings when the user can reach them.
- **All roles** fieldset: one **required** textfield per role (from `user_role_names()`), stored as `logo_link[<role>]`.

## Validation (`blockValidate`)
Each role URL must:
- match `^[#?/]+` (start with `#`, `?`, or `/`) **or** equal `<front>`, and
- pass `PathValidatorInterface::isValid()`.
Otherwise a form error is set for that role.

## Runtime link resolution (`getCurrentRoleLink`)
Precedence for the current viewer:
1. `administrator` role → its link.
2. `anonymous` → its link.
3. authenticated **plus** another role → the first non-`authenticated` role's link.
4. plain `authenticated` → its link.
5. fallback `<front>` (rendered as `/`).

The result is prefixed with `base_path()` and passed to the template as `#link`.

## Rendering & cache
`build()` outputs `site_logo` (`theme_get_setting('logo.url')`), `site_name` and `site_slogan` (from `system.site` config) as a `site_branding_per_role_block` themed array. `getCacheTags()` merges `system.site` cache tags so name/slogan edits invalidate the block.
