<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Remote Options — agent index

An **options/select field widget whose choices come from a remote REST endpoint**. Version **1.1.x**.
Core `^8 || ^9 || ^10`. No hard deps. Alter hook: `hook_content_remote_options__options_alter()`.

Security: reviewed, NOT SSRF. The fetched URL is `$options['endpoint']` from **field configuration** (set by a
site builder with field-admin rights), not a request/user-supplied value; the fetch is server-side via
`\Drupal::httpClient()->get()` with Guzzle defaults (TLS verification NOT disabled — no `verify => false`).
Responses cached per entity/bundle/field/language. See
`src/Plugin/Field/FieldType/ListRemoteOptionsItem.php::executeRequest()`.
