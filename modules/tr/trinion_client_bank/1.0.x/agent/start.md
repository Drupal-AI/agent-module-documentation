<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trinion client-bank (trinion_client_bank) — agent index
**Bulk-imports 1C Client-Bank payment exports and converts them into ERP payment documents.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends:** trinion_tp
- **Routes:** `/client-bank-import-payments` (import form, perm `trinion_client_bank client_bank`); `/sozdaniye-platezha/{node}` (AJAX convert, perm `trinion_client_bank sozdanie_platezha`, node bundle `trinion_payment_client_bank`).
- **Permissions:** `trinion_client_bank client_bank`, `trinion_client_bank sozdanie_platezha`.
- **Hooks:** `hook_entity_access` restricts view of `trinion_payment_client_bank` nodes to the permission holder; `hook_node_view` adds a related-docs view.

**Security:** Both routes permission-gated; the only external input is a manually uploaded `.txt` file (no outbound HTTP, no secrets, no callback). Uploaded file parsed with `iconv`/`preg_match_all`; nodes created via the entity API. No security findings.

See [configure/import.md](configure/import.md).
