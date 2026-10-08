<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Progressive Accessibility Widget (progressive_accessibility_widget) — agent index

**A GDPR-compliant accessibility toolbar (font size, dyslexia font, contrast, reading guide, enlarged cursor) exposed as a Drupal block; no third-party requests.**

- **Version:** 1.0.x  •  core: `^10 || ^11`  •  package Accessibility.
- **Block:** `progressive_accessibility_block` (`ProgressiveAccessibilityBlock`), one setting `widget_icon` (validated path / stream-wrapper URI; absolute local paths rejected).
- **Theme/library:** `asw_widget` theme hook; library loads `/libraries/progressive-accessibility-widget/dist/` (Sienna) JS/CSS + a local CSS override. External library **not bundled** (>=1.0.3), installed via Composer Merge Plugin or manual download; `hook_requirements()` flags a missing JS file at runtime.
- **No routes, permissions, or services.** Placement/config gated by core block-admin permission.
- **Security:** client-side only, no third-party network calls, no custom endpoints; icon path validated (rejects absolute local paths). No security findings.
