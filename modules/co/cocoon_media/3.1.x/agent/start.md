<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: cocoon_media

**What:** DAM integration with Cocoon (use-cocoon.nl) via SOAP; browse/import remote assets into the media library.

**Key files:**
- `src/CocoonController.php` — SOAP client + auth (`sha1(subdomain+user+requestId+secret)`), asset methods.
- `src/Controller/CMMController.php` — `getTagsAutocomplete()` JSON endpoint.
- `src/Form/CMMSettingsForm.php`, `src/Form/CMMAddMediaForm.php`.

**Routes:** settings + add-media are permission-gated; `cocoon_media.tag_autocomplete` is `_access: TRUE` (anonymous — returns Cocoon tag names, minor disclosure + unauthenticated SOAP cache-warm).

**Deps:** `media` + PHP SOAP ext. Secret key in config. TLS verification default-on.
