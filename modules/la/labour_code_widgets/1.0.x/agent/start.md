<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Labour code widgets (labour_code_widgets) — agent index

**Field type + formatter that embeds official French 'code du travail' widgets (code.travail.gouv.fr); admin toggles which widgets are enabled.**

- **Version:** 1.0.x (1.0.1) · **Core:** ^8.8 || ^9 || ^10 || ^11 · **PHP:** 7.4 · **Depends:** field
- **Field:** `LabourCodeWidgetsItem` (FieldType) + `LabourCodeWidgetsFieldFormatter` (FieldFormatter).
- **Configure:** `labour_code_widgets.status` → `/admin/structure/labour-code-widgets/status` (perm `administer labour_code_widgets`).
- **Service:** `labour_code_widgets.helper` (`LabourCodeWidgetsHelper`) — widget options/definitions + enabled state.
- **External library:** `https://code.travail.gouv.fr/widget.js` (client-side, async/defer).
- **Security:** admin route permission-gated; no server-side external calls (widget runs in the browser). Consideration: third-party script domain loaded on field pages (CSP/privacy). No code findings.

See [configure/widgets.md](configure/widgets.md)
