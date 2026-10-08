<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Trinion Books (trinion_tp) is a node-based trading/accounting engine implementing the UFMTP model: estimates, sales/purchase orders, invoices, shipments, goods receipts, payments and stock, plus PDF document generation.

---

Each document type is a node bundle (`zakaz_klienta`, `schet`, `otgruzka`, `poluchennyy_platezh`, `postuplenie_tovarov`, etc.). Controllers generate printable PDFs (`/pdf/*/{node}`), build creation forms that turn one document into the next in the chain (`/sozdaniye-*`), approve documents (`/utverdit/{node}/{op}`), and export product data to the Frontol POS and to CSV. Product autocomplete and price/stock lookups back the document forms. A `TrinionHelper` service (over the database) supplies helpers such as `getNextDocumentNumber()` and user-specific pricing used by trinion_cart.

Every PDF and document-creation route is gated by a bundle-specific `create <type> content` permission, and three custom access checkers guard approval, shipment creation and invoice sending; the settings form requires `administer site configuration`. Frontol/CSV export routes use dedicated `trinion_tp frontol`/`trinion_tp tovari` permissions. Setup requires trinion_base and trinion_crm and the associated content types/fields; most UI strings are Russian. Grant the fine-grained per-document permissions to the relevant staff roles.

---
- Generate a commercial-offer (kommercheskoe predlozhenie) PDF at `/pdf/kommercheskoe-predlogenie/{node}`.
- Generate a shipment (otgruzka) PDF at `/pdf/otgruzka/{node}`.
- Generate a UPD / invoice PDF for a shipment.
- Produce received- and sent-payment PDFs.
- Produce sales-order, supplier-order and goods-receipt PDFs.
- Create a sales order from an estimate via `/sozdaniye-zakaza-klienta/{node}`.
- Create a customer invoice from an order via `/sozdaniye-scheta-klienta/{node}`.
- Create a shipment from a sales order (with a custom access check).
- Create a supplier invoice or purchase order from related documents.
- Register received and sent payments through dedicated forms.
- Approve/unapprove a document with `/utverdit/{node}/{op}`.
- Autocomplete products and look up characteristic price/stock in forms.
- Export goods and services to Frontol POS and download the file.
- Export the product list to CSV at `/tovari/skachat`.
- Pick a product type before creating a new item (`/vibor-tipa-tovara`).
- Email an invoice to a customer via `/otpravit_schet/{node}`.
- Compute the next sequential document number via `TrinionHelper`.
- Provide user-specific product pricing consumed by trinion_cart.
- Restrict each document type with its own `create <type> content` permission.
- Configure module behaviour at `/admin/config/tp/settings`.
