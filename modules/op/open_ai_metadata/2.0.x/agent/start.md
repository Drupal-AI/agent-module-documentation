<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Open AI Metadata (open_ai_metadata) — agent index

**Uses the OpenAI chat-completions API to generate meta descriptions / body content for nodes from the node title.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10
- **Depends:** none (calls OpenAI)
- **Configure:** `/admin/config/open_ai_metadata` (route `open_ai_metadata.admin_settings`).

**Surface:** `MetadataConfigForm` (endpoint/token/model/temp/max-tokens), `MetadataSettingsForm` (per content type), `MetadataContentForm` modal at `/metadata/content/form/{fieldName}`, `MetadataSettingsController`. Token stored in **state** (not config).

**Security (reviewed — sound):** outbound Guzzle uses **default TLS verification (on)** — no `verify=>false`; endpoint is admin-config behind an admin permission (no low-priv SSRF). Quirk: routes reference custom permissions (`Administer Open AI Metadata`, `Access Open AI Metadata Content Type Settings`) that **no `permissions.yml` defines**, so they fail closed to uid 1. Content is sent to OpenAI — review provider data handling.
