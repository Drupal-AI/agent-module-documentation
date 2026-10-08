<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SVG Upload Sanitizer strips scripts and other active content out of SVG files as they are uploaded, closing one of the more reliable stored-XSS routes into a Drupal site.

---

SVG is XML, and XML that browsers execute: an `.svg` file can carry `<script>`, event handlers, `<foreignObject>` with embedded HTML, and external references. Serve one from the same origin as the site — which a public file field does — and opening it runs the attacker's JavaScript with the site's cookies. This is why allowing SVG uploads without sanitisation is a well-known mistake, and why `enshrined/svg-sanitize` exists: an allow-list-based cleaner that removes everything not on its list of safe elements and attributes. This module hooks that library in at the file-entity layer via `hook_file_insert()` — the code lives in `src/HookHandler` and `src/Helper`, wired by `svg_upload_sanitizer.services.yml`. Because it acts on the `File` entity rather than one field or form, it cleans SVGs from every managed-file upload path: file and image fields, the media library, Webform, and the REST/JSON:API file resource. The clean happens in place on the stored file the first time it is saved, so what gets served later is the sanitised version. Installation is the usual Composer + enable (`composer require drupal/svg_upload_sanitizer`, then enable the module); it pulls in `enshrined/svg-sanitize ~0.22` and depends on core `file`, PHP 8.1+ and core `^10 || ^11`. There is no settings form, permission or route. It runs with the library's defaults; if you need to change how SVGs are cleaned — for example to strip references to remote files with `removeRemoteReferences(TRUE)` — decorate the `svg_upload_sanitizer.sanitizer.svg` service (the README shows the exact YAML). Two limits worth knowing: it only sees files uploaded through Drupal, so anything placed on disk by migration, rsync or a direct file-API write is unaffected; and the strongest complementary control remains serving user-uploaded files from a separate domain, which removes same-origin execution regardless of file content.

---

- Allow SVG uploads without stored XSS risk.
- Strip scripts from an uploaded logo.
- Remove event handlers from vector artwork.
- Sanitise SVGs in a media library.
- Let editors upload icons safely.
- Reduce risk on a public file field.
- Remove external references from an SVG.
- Meet a penetration-test remediation item.
- Clean SVGs at the point of upload.
- Support an icon-upload workflow.
- Protect a site with anonymous uploads.
- Complement extension and MIME validation.
- Allow designers to supply SVG assets.
- Reduce reliance on manual SVG review.
- Sanitise SVGs uploaded via a webform.
- Keep SVG support without disabling it wholesale.
- Harden a media library for untrusted contributors.
- Clean SVGs imported during a migration.
