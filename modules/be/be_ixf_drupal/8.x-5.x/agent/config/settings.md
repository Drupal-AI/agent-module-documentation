<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — be_ixf_drupal

Single config object: **`be_ixf_drupal.settings`**. Edited at `/admin/config/services/brightedge`
by `Drupal\be_ixf_drupal\Form\AdminForm` (route `brightedge.admin_form`, guarded by the
non-existent permission `administer` — see start.md; effectively admin-only). There is no config
schema (`config/schema/` does not exist), so this config is schema-less.

## Keys

| Key | Form widget | Values / default | Purpose |
|-----|-------------|------------------|---------|
| `capsule_mode` | select | `REMOTE_PROD_CAPSULE_MODE` (Production) or `REMOTE_PROD_GLOBAL_CAPSULE_MODE` (Production Global) | SDK env + page-independent flag. "Global" = one capsule for all pages (`get_global_capsule`); default = per-page (`get_capsule`). |
| `account_id` | textfield (required, maxlength 20) | BrightEdge account, `f000000ZZZ` form | Placed in the capsule API URL path. Not a secret credential. |
| `enable_storage_capsule` | checkbox | bool, default off | SCP 2.0 storage-capsule mode; switches default endpoint to `ixfc0-api.bc0a.com` and enables account-default-capsule fallback. |
| `api_endpoint` | textfield (optional) | e.g. `https://ixfN-api.bc0a.com`; app default `https://ixfd-api.bc0a.com` | Overrides the capsule API base. Only applied when non-empty. |
| `block_cache_max_age` | textfield (numeric, validated) | seconds, default `3600` | Cache lifetime for `IXFContentBlock` and the per-node redirect cache entry. |
| `canonical_host` | textfield (optional) | hostname | Overrides host used when building the normalized/canonical URL sent to BrightEdge. |
| `protocol` | radios | `http` / `https`, default `http` | Protocol for **canonical URL construction only** — it does not set the API fetch scheme (the fetch scheme comes from the `api_endpoint` URL, HTTPS by default). |

## Notes for agents

- The default install file `config/install/be_ixf_drupal.settings.xml` has the wrong extension
  (`.xml` on YAML) and is **not** imported. After enabling the module, set at least `account_id`
  manually, or the SDK fetches with account `0`.
- `capsule_mode` in the form only exposes the two Production values; the SDK also supports staging
  modes (`remote.staging.capsule`, `remote.staging.global.capsule`) but the module never sets them.
- The block plugin (`ixf_content_block`) has its own per-block config: `body_type`
  (`_body_open` / `body_1` / `Other`) and `featured_group` (the capsule feature-group ID, used when
  `body_type` is `Other`). Set these in Block layout, not in the module settings form.
- `protocol` defaulting to `http` only affects the canonical URL reported to BrightEdge; set it to
  `https` on TLS sites so the canonical URL matches.
