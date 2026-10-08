<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trinion Books (trinion_tp) — agent index

**Node-based UFMTP trading/ERP: sales & purchase documents, payments, stock, PDF generation and Frontol/CSV export.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends:** datetime, options, trinion_base, trinion_crm
- **Permissions:** many per-document `trinion_tp <type>` (restricted), plus `trinion_tp frontol`, `trinion_tp tovari`

**Routes:** settings `/admin/config/tp/settings` (`administer site configuration`); `/pdf/*/{node}` PDF builders; `/sozdaniye-*/{node}` document-creation controllers; `/utverdit/{node}/{op}` approval; `/admin/frontol/*`, `/tovari/skachat` exports; product autocomplete. **Access checkers:** utverdit_document, sozdanie_otgruzki, otpravit_schet. **Service:** `trinion_tp.helper` (`TrinionHelper`).

**Security:** all PDF/creation routes gated by bundle-specific `create <type> content` permission; export routes by dedicated perms; approval/shipment/invoice-send routes add custom access checkers. No anonymous or `access content`/`_access:TRUE` mutating endpoints observed.

See [api/documents.md](api/documents.md).
