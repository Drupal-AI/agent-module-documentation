<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# C2PA Sign (c2pa_sign) — agent index

Signs supported media assets with C2PA "Content Credentials" (provenance manifests) by driving the
`c2patool` binary through the `jrglasgow/c2patool` PHP library and a site-configured certificate/key
pair. Signs on file upload, on content publication, and on image-derivative generation.

- Package: C2PA. Core: `^10 || ^11`. License: GPL-2.0-or-later.
- Composer require: `jrglasgow/c2patool:^0.5.1` (the PHP wrapper for the external `c2patool` CLI).
- No Drupal module dependencies; no permissions.yml; no plugin types; no libraries.yml.
- Optional/soft integrations detected in code: `image` (ImageStyle/ImageEffect), `node`, `focal_point`
  (image-effect class names), and the separate `c2pa_sign_aws_kms` project (mentioned in README).

## What it provides

- Config: `c2pa_sign.settings` (schema in `config/schema/c2pa_sign.schema.yml`). Settings form
  `Drupal\c2pa_sign\Form\SettingsForm` at route `c2pa_sign.settings`
  (`/admin/config/media/c2pa_sign`, permission `administer site configuration`).
- Menu link `c2pa_sign.settings` under System > Config > Media (`c2pa_sign.links.menu.yml`).
- Service `c2pa_sign.event_subscriber` = `EventSubscriber\C2paSignSubscriber` (kernel REQUEST cert
  check; kernel RESPONSE image-derivative signing).
- DB table `c2pa_sign_certificate_uses` (`hook_schema` in `c2pa_sign.install`): per-fingerprint sign
  counter. `hook_requirements` reports c2patool + certificate status.
- Procedural signing pipeline in `c2pa_sign.module` (entity hooks + manifest builder + signer).
- Four alterable events in `src/Event/`: `ManifestCreateEvent`, `CreateToolEvent`, `PreSignEvent`,
  `CertificateValidateEvent`.

## Entity hooks (where signing is triggered)

- `hook_entity_presave` on `file` → `c2pa_sign_presave_file()` — signs new uploads (assertion
  `drupal.c2pa_sign.upload`) when `assertions.upload` is on.
- `hook_entity_insert` / `hook_entity_update` on `node` (and any `ContentEntityBase`) →
  `c2pa_sign_postsave_content_entity()` — signs referenced files on first publish (assertion
  `drupal.c2pa_sign.publish`) when `assertions.publish` is on.
- Kernel RESPONSE (`C2paSignSubscriber::onKernelResponse`) — signs `image.style_public` /
  `image.style_private` derivatives when `image_derivatives.add_manifests` is on.

## Solution docs

- Configuration, routes, settings keys, certificate/key + c2patool setup, status report:
  [agent/config/settings.md](config/settings.md)
- Signing pipeline, manifest assembly, events, certificate handling & DB table:
  [agent/api/signing.md](api/signing.md)
