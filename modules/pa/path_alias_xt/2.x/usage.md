<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extended Path Aliases automatically extends path aliases to include entity task tabs (like about-us/edit for node/123/edit) and lets aliases be used with wildcards in page specifications.

---

Extended Path Aliases extends Drupal's path aliasing so that alias coverage includes an entity's
task tabs — if `node/123` is aliased to `about-us`, then `node/123/edit` becomes `about-us/edit`, and
similarly for other local tasks. It also lets these aliases be used with wildcards in page-specification
contexts (e.g. `about-us*` for block visibility), which otherwise only match the raw system path. It
depends on core Path and is configured at `path_alias_xt.settings_form`; it provides its own
permissions.

Use it where clean aliases should extend to edit/manage tabs and where block-visibility or similar
path rules should match aliased URLs with wildcards. It is a routing/URL feature affecting alias
resolution and path matching; it does not change access — the edit tab is still governed by normal
permissions, this only makes its URL aliased.

---

- Alias entity tabs like about-us/edit.
- Extend aliases to local task paths.
- Match aliases with wildcards.
- Use about-us* in page specifications.
- Alias the edit/manage tabs.
- Depend on core Path.
- Configure at path_alias_xt.settings_form.
- Provide its own permissions.
- Make block visibility match aliases.
- Keep clean URLs on task tabs.
- Resolve aliased tab URLs.
- Not change access, only URLs.
- Match aliased URLs in path rules.
- Alias node/123/edit cleanly.
- Extend alias coverage.
- Use wildcards on aliased paths.
- Improve URL consistency.
- Alias local tasks.
- Support alias-based visibility.
- Handle tab-path aliasing.
