<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sub-pathauto — agent index

Makes sub-paths of an alias resolve: with `/node/1` aliased to `/about-us`,
`/about-us/edit` → `/node/1/edit` (and back again outbound). One service, two settings,
one settings form. No permissions of its own, no plugins, no Drush, no hooks.

- **Settings (`subpathauto.settings`: `depth`, `redirect_support`), form route, drush recipes** →
  [configure/settings.md](configure/settings.md)
- **How the path processor works, priority, language prefixes, redirect fallback, testing it** →
  [api/path-processing.md](api/path-processing.md)

Key facts:
- Config object `subpathauto.settings` — `depth` (integer) and `redirect_support` (boolean).
- Form: `/admin/config/search/subpathauto` (route `subpathauto.admin_settings`), guarded by
  core's **`administer url aliases`** permission.
- Service `path_processor_subpathauto`, tagged `path_processor_inbound` **and**
  `path_processor_outbound`, both at priority `50`.
- `depth: 0` means **no limit** in code even though the form labels it "Disabled"; a missing
  / NULL `depth` disables processing altogether.
