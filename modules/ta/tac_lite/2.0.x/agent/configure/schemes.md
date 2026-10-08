<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure vocabularies, schemes & grants

Admin UI: **Configuration → People → Access by Taxonomy** (`/admin/config/people/tac_lite`,
route `tac_lite.administration`, permission `administer tac_lite`). Each scheme has its own tab
at `/admin/config/people/tac_lite/scheme_<n>` (dynamically routed from `tac_lite_schemes`).

## Everything is in one config object: `tac_lite.settings`

| Key | Meaning |
|---|---|
| `tac_lite_categories` | sequence of vocabulary ids whose terms control access (null = unconfigured) |
| `tac_lite_schemes` | number of schemes (1–7) |
| `tac_lite_storage_type` | `tid` or `uuid` — how terms are stored in grants (**the key the code reads**; the install file ships a mislabeled `schemes_storage_type: tid`, default is `tid`) |
| `tac_lite_config_scheme_<n>` | per-scheme settings: `name`, `perms` (subset of `grant_view`/`grant_update`/`grant_delete`), `unpublished` (bool), `term_visibility` (bool), and `tac_lite_create` (bool, from the submodule) |
| `tac_lite_grants_scheme_<n>` | role-default grants: `[role_id][vocab_id] => [term ids]` |

There is **no `tac_lite.scheme.N` config object** despite the `tac_lite.scheme.*` schema stub —
`SchemeForm` writes everything into `tac_lite.settings`. Read a scheme with
`SchemeForm::tacLiteConfig($n)` (which also supplies defaults: realm `tac_lite_scheme_<n>`,
empty perms, etc.).

```bash
drush cget tac_lite.settings
drush cget tac_lite.settings tac_lite_config_scheme_1
```

## Per-user grants

Beyond role defaults, grant specific terms to one user on the **"Access by taxonomy"** tab of
their account edit page (`/user/{user}/tac_lite`, `UserAccessForm`). These are stored via the
**user.data** service under module `tac_lite`, key `tac_lite_scheme_<n>` — not in config.

## Setup order (and the mandatory rebuild)

1. Create a vocabulary of access terms and attach it to node types (a term-reference field).
2. Select that vocabulary in `tac_lite_categories` on the settings tab.
3. Configure each scheme: pick `perms`, associate roles/terms, optionally per-user grants.
4. **Rebuild node access permissions** (`/admin/reports/status` → "Rebuild permissions", or
   `node_access_rebuild(TRUE)`). Schemes do nothing until the grants table is rebuilt.

## Key semantics

- tac_lite **grants** access; it never revokes. Hide content with core permissions first, then
  reveal it with tac_lite.
- Grant id `0` is a fallthrough so untagged nodes stay visible.
- `term_visibility` on a scheme filters which **terms** a user can see (tag clouds, forms) via a
  `taxonomy_term` query alter; the scheme's `grant_view` perm is about **node** visibility.
