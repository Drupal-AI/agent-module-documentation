<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# C2PA Sign — configuration & setup

## Install / enable

`composer require drupal/c2pa_sign` (pulls `jrglasgow/c2patool`), then `drush en c2pa_sign`.
`hook_install`/`hook_requirements` do NOT block install on a missing binary/cert (see
`c2pa_sign_requirements()` in `c2pa_sign.install`: the `install` phase returns early so the admin can
configure paths first). `hook_schema` creates table `c2pa_sign_certificate_uses`
(fields: `id` serial PK, `fingerprint` varchar unique, `count` int).

External prerequisites (not shipped): the `c2patool` executable (Rust binary from contentauth), and a
valid signing certificate + private key. Without both, signing silently no-ops and the status report
shows errors.

## Route & permission

Single route, `c2pa_sign.routing.yml`:

- `c2pa_sign.settings` — `GET/POST /admin/config/media/c2pa_sign`, form
  `Drupal\c2pa_sign\Form\SettingsForm`, requirement `_permission: 'administer site configuration'`.

No other routes. No `*.permissions.yml` (module defines no permissions of its own). Menu link
`c2pa_sign.settings` (parent `system.admin_config_media`).

## Config object `c2pa_sign.settings`

Schema: `config/schema/c2pa_sign.schema.yml`. Keys (as read across the code):

- `site` (mapping) — `name` (site/org name in manifests; falls back to `system.site` name),
  `claim_generator` (RFC 7231 user-agent string; enables the claim-generator block when set),
  `logo` (path or `public://`/`private://` URI; defaults to the theme logo — see
  `c2pa_sign_get_logo()`).
- `certificate_file_directory` (string) — directory scanned for `*.pem` files; each needs a sibling
  `<name>.key`. Read by `c2pa_sign_get_certs()`.
- `c2patool_binary_location` (string) — absolute path to the `c2patool` executable.
- `admin_page_load_cert_check` (boolean) — when true, `C2paSignSubscriber::onKernelRequest` runs
  `c2pa_sign_check_certificate_expiration()` on every request for users with
  `administer site configuration`.
- `assertions.upload` (boolean, default TRUE) — sign files on upload.
- `assertions.publish` (boolean, default TRUE) — sign referenced files when content is first
  published.
- `image_derivatives.add_manifests` (boolean, default TRUE) — sign image-style derivatives.
- `image_derivatives.add_when_original_does_not_have_manifest` (boolean, default FALSE) — add a
  manifest to a derivative even when the source image has none.

The `SettingsForm` writes every submitted value straight into config (`submitForm()` loops
`$form_state->getValues()`), so the form field tree matches these keys. `getEditableConfigNames()`
returns `['c2pa_sign.settings']`; `getFormId()` = `c2pa_sign_settings`.

## Certificate / key sourcing

`c2pa_sign_get_certs($directory)` (in `c2pa_sign.module`) builds the candidate list:

1. If env vars `C2PA_SIGN_CERT` and `C2PA_PRIVATE_KEY` are both set, a synthetic cert with
   `uri = 'ENVIRONMENT_VARIABLE'` is added.
2. If a directory is configured, it is scanned for `/.pem/` files via `FileSystem::scanDirectory()`;
   each `.pem` is matched to a `<name>.key` sibling.

Each candidate is validated by `Jrglasgow\C2paTool\Signer::validateCert()` (X.509 v3, KeyUsage
digitalSignature critical, EKU/basicConstraints rules, validity window, and a live key/cert
sign+verify round-trip). On a `CertificateValidationException`, a `CertificateValidateEvent` is
dispatched so other modules can override the verdict; otherwise the cert is skipped. Among valid
certs the one expiring **last** is chosen (`cert_to_use`). Validation results are memoized per
directory via `drupal_static`.

`SettingsForm::validateForm()` also verifies the directory exists, that a usable cert/key pair is
present, and that the binary path exists, is executable, and returns a version (auto-searching `$PATH`
via `Tool::searchBinary()` if the field is empty/invalid). Config overrides (from
`settings.php`/`settings.local.php`) are detected via `checkOverridden()` and shown as disabled
fields.

## Status / monitoring

- `hook_requirements` (`runtime`/`update`): reports the c2patool executable + version, and the active
  certificate details (issuer, subject, validity, algorithm — rendered by
  `c2pa_sign_certificate_info()`), plus expiry warnings.
- `c2pa_sign_check_certificate_expiration()` messages admins if no cert is usable or the active cert
  expires within one month. It is called from `SettingsForm::buildForm()`, from
  `hook_requirements`, and optionally on every admin request.
- Certificate usage is displayed as a count from `c2pa_sign_get_certificate_usage($fingerprint)`
  (reads `c2pa_sign_certificate_uses`).

## README setup notes

The README documents installing c2patool via `cargo install c2patool`, downloading the sample
`es256` cert/key pair, and pointing `certificate_file_directory` at the pair (trailing slash
required). It also mentions the separate `c2pa_sign_aws_kms` project for AWS KMS signing (not part of
this project; c2patool at this version cannot use external/remote signers directly).
