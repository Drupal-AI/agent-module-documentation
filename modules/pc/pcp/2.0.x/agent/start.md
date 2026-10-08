<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Profile Complete Percentage (pcp) — agent index

A display-only engagement module. Shows the **logged-in user** a block with a progress bar for how
complete **their own** profile is, using account fields an admin marks as counting. Version
**2.0.0**, core `^9 || ^10 || ^11`. No hard dependencies beyond core `field`/`user`. No Drush
commands, no plugin types.

## What it actually is
- Provides one block, **"Profile Complete Percentage"** (plugin id `pcp_block`, *User* category).
- `PCPBlock::blockAccess()` → allowed for any **authenticated** user, forbidden for anonymous.
- `PCPBlock::build()` always loads the **current** user (`current_user`) — a viewer only ever sees
  their **own** completion; there is no per-user parameter and no cross-user disclosure.
- `getCacheMaxAge()` is **0** — data is recomputed on every request.

## Configuration
- Route `pcp.pcp` at `/admin/config/people/pcp`, form `PCPForm` (extends `ConfigFormBase`),
  permission **`pcp administer`**. Config object `pcp.settings` (schema provided).
- Settings: `profile_fields` (which `user` configurable fields count — checkbox list from
  `FieldConfigInterface` definitions on the `user` bundle), `field_order` (0 = random / 1 = fixed
  "next" field), `open_link` (0 = same window / 1 = new window), plus a hide-when-complete toggle.
  Note the form saves the hide flag as `hide_block_on_complete` while `config/install` ships the key
  `hide_pcp_block: 0` — the service reads `hide_block_on_complete`, so the shipped default key is
  effectively inert until the form is saved.

## Mechanism (`PcpService::getCompletePercentageData`)
1. Read configured `profile_fields`, `array_filter` them, and `array_intersect_key` with the user's
   real fields (drops deleted/stale config).
2. If none configured → returns `current_percent: 100`.
3. Count empty fields via `$user->get($field)->isEmpty()`; percent = round(completed*100/total);
   next percent assumes one more field filled.
4. `getNextField()` picks a suggested empty field: `array_rand()` when random, else `key()` (first).
5. Block renders `pcp_template` (progress bar + a "Filling out X will bring your profile to N%
   complete" link deep-linking to `/user/{uid}/edit#edit-{field}-wrapper`, target from `open_link`).
6. Block returns empty (`[]`) when total fields = 0, or when hide-on-complete is set and nothing is
   incomplete.

## Setup checklist
1. Enable the module; add custom fields to the user account at
   `/admin/config/people/accounts/fields`.
2. At `/admin/config/people/pcp` tick the fields that count and set the three options.
3. Place the **Profile Complete Percentage** block (User section) at `/admin/structure/block`.

## Practical cautions (non-security)
- Ticking **every** field makes 100% unreachable and the bar meaningless — curate a short list.
- A completion bar is a nudge; using it to extract genuinely optional/sensitive data (DOB, phone,
  photo) is a dark pattern where those fields are not actually needed.

## Deprecations
- `pcp_get_complete_percentage_data()` (in `pcp.inc`) is deprecated — use
  `\Drupal::service('pcp.pcp_service')->getCompletePercentageData($user)`.

## Security posture
Clean for its surface: the config route is permission-gated with a standard `ConfigFormBase`
(CSRF-protected) form; the block is authenticated-only and renders the current viewer's own data
only (no IDOR), with cache max-age 0. No security notes file.
