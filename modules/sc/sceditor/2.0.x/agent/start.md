<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SCEditor (sceditor) — agent index

**Registers the SCEditor JS library as a Drupal text-editor plugin for BBCode/(X)HTML editing.**

- **Version:** 2.0.x
- **Core:** ^9 | ^10 | ^11
- **Package:** Other
- **Plugin:** `@Editor` id `sceditor` (`src/Plugin/Editor/ScEditor.php`). Attaches library `sceditor/sceditor`.
- **Assets:** `sceditor.libraries.yml` loads SCEditor CSS/JS from jsDelivr CDN (pinned `@latest`) + local `js/sceditor.js`; depends on `core/jquery`.
- **Config:** assign the editor to a text format at `/admin/config/content/formats`.

**Security:** the plugin declares `is_xss_safe = FALSE` and `supports_content_filtering = FALSE` — an honest posture that defers all sanitization to the text format's filters, so a sanitizing filter (Limit allowed HTML / BBCode) MUST remain enabled on any format exposed to untrusted roles. Note: frontend library is loaded from an external CDN at unpinned `@latest`, so the exact editor version is not locked by the module.
