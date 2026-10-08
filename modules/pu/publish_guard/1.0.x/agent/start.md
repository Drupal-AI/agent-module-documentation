<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Publish Guard (publish_guard) — agent index
**Warns about / blocks node publishing outside configured day+time windows, on the node form.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11 · PHP 8.1
- **Config route:** `publish_guard.settings` → `/admin/config/content/publish-guard` (`administer publish guard`)
- **Permissions:** `administer publish guard`, `bypass publish guard` (both restrict-access)
- **Service:** `publish_guard.checker` (`PublishGuardChecker`)

**Security / scope:** Enforcement is node-**edit-form only** (`hook_form_node_form_alter` + a `#validate` handler in block mode). It does NOT control viewing, and does NOT block programmatic/REST/JSON:API/migration saves or non-node entity forms — it is an accidental-publish safeguard, not an authorization control. See [configure/settings.md](configure/settings.md).
