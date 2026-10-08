<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate — configuration & the file-access model

Covers global settings, the signing secret and rotation, per-field gating, and how the deny half of the gate
works. Install with `drush en file_gate`. Admin UI at `/admin/config/media/file-gate`
(`file_gate.settings_form`, permission `administer file gate`).

![File Gate settings form](../../../../../../../screenshots/file_gate/1.10.x/settings-form.png)
![Lower settings sections](../../../../../../../screenshots/file_gate/1.10.x/settings-form-lower.png)

## Global config object: `file_gate.settings`
Schema `config/schema/file_gate.schema.yml`; defaults `config/install/file_gate.settings.yml`. Keys:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `download_secret` | string | `''` | Legacy whole-corpus signing/mint secret. **Ships empty on purpose** — inject from env in settings.php. |
| `secret_scopes` | sequence | `{}` | `secret_id → [field_storage_key, …]` allowlists for named secrets (exportable; values live in settings.php). |
| `ttl` | integer | `120` | Default signed-URL lifetime (seconds). |
| `disposition` | string | `attachment` | `attachment` or `inline` (see safe-MIME note below). |
| `flood_limit` / `flood_window` | integer | `50` / `60` | Per-IP mint/revoke/otp/grants rate limit. |
| `download_flood_limit` / `download_flood_window` | integer | `120` / `60` | Per-IP throttle on **denied** download attempts; `0` disables. |
| `require_acting_account` | boolean | `false` | Force every mint to name an acting `account`/`uid`. |
| `introspection_client_secret` | string | `''` | Used only by `file_gate_assurance` RFC 7662 introspection; env-injected. |

`SettingsForm` (`src/Form/SettingsForm.php`) edits `ttl`, `disposition`, both flood pairs,
`require_acting_account`, and `secret_scopes` (via a `id: field.a, field.b` textarea). It **does not** edit
secrets — it only reports presence (`GrantSigner::hasSecret()`), lists named secrets and their scope status, and
renders a 14-day dashboard (`FileGateMetrics::summary()`, needs dblog) plus a read-only gated-fields table
(`GatedFieldOverview::fields()`).

## The signing secret (never in config)
Resolved by `SecretRegistry` (`file_gate.secret_registry`, `SecretRegistryInterface`). Two shapes:

- **Legacy (whole corpus):** `$config['file_gate.settings']['download_secret'] = getenv('DRUPAL_FILE_GATE_SECRET');`
  in settings.php. Minted URLs carry no `k=`; `allowsField()` returns TRUE for every field.
- **Named (field-scoped):** `$settings['file_gate.secrets'] = ['s1' => getenv('…'), …];` plus a `secret_scopes`
  entry mapping `s1` to the field storage keys it may mint. A named secret **with a value but no scope can mint
  nothing** (fail closed) and is flagged on the settings page. Callers present it as Basic-auth
  `username=<secret_id>`, `password=<value>` (or `X-File-Gate-Secret-Id` + `X-File-Gate-Secret`). Minted URLs
  carry `k=<secret_id>` for redemption.

Presented credentials are compared with `hash_equals` (`SecretRegistry::resolveCredentials()`). Signing always
uses the current material; validation tries current then retired keys.

**Dual-key rotation grace** (`validationMaterials()`): retire old values in settings.php so live links keep
working during a rotation — `$settings['file_gate.previous_secrets'] = ['s1' => 'old'|['old1','old2']];` (named)
or `$settings['file_gate.previous_download_secrets'] = ['old', …];` (legacy). See `docs/SECRET_ROTATION.md`.

## Per-field gating
Gating lives on the **field storage** third-party settings (`field.storage.*.*.third_party.file_gate`):
`gated` (bool), `method` (plugin id, default `signed_url`), `method_settings` (per-method, schema `ignore`).
`file_gate_form_field_config_edit_form_alter()` (`file_gate.module`) adds a "File Gate" details fieldset to any
file/image field edit form (fields with a `uri_scheme` storage setting):

- "Gate access to these files" toggles `gated`; enabling **forces and locks `uri_scheme: private`**
  (`_file_gate_apply_field_gating()`).
- A method select renders the chosen method's `fieldSettingsForm()`; save runs `fieldSettingsSubmit()` /
  `fieldSettingsValidate()` (feature-detected on `GateMethodBase`).
- Validation refuses gating a field that already stores files on a non-private scheme (can't move existing data).

## The deny half — `hook_file_download`
`file_gate_file_download(string $uri)`:
1. Returns `NULL` for any non-`private` scheme (nothing to gate; public files never reach this hook).
2. Loads the file; returns `NULL` when `FileGateResolver::isGated()` is FALSE (ungated private files keep normal
   access, e.g. profile docs).
3. Returns `NULL` when the current account has **`bypass file gate`** (editors/operators keep admin-UI downloads).
4. Otherwise returns **`-1`** — a hard veto that overrides core's permissive private-file access.

`FileGateResolver` (`file_gate.resolver`) maps a file to its gate via core's `FileReferenceResolver`: it reads
each referencing field storage's third-party settings and, when several gated fields reference one file, applies
`METHOD_STRICTNESS` (assurance > otp > token > form > commerce > authenticated > referrer_lock > signed_url) so
the **strictest** gate wins unless a caller pins a `field` key.

## Public-scheme safety net
A gated field on a public scheme is the module's worst state (config claims protection that does not exist). It is
prevented, not silently ignored: the field form forces private; `GatedFieldSchemeValidator` /
`GatedFieldSchemeSaveSubscriber` (+ the `FileGateGatedFieldScheme` config constraint) reject that combination on
save/import; and `\Drupal\file_gate\Hook\FileGateRequirements` reports any site already in it on the status report.

## Permissions
- **`administer file gate`** (restricted) — the settings form + gated-field overview.
- **`bypass file gate`** (restricted, admin-implicit) — download gated files through `/system/files` without a
  minted grant. Grant only to trusted staff.

## Uninstall
`file_gate_uninstall()` drops the module's expirable key-value collections (token hashes, OTP rows, grant
inventory, redemption/kill-mark records) that core would otherwise leave behind.
