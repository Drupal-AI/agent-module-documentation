<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trinion Books — document routes

Document types are node bundles; routes are grouped by function. All are permission-gated.

## PDF generation (`create <type> content`)
`/pdf/kommercheskoe-predlogenie/{node}`, `/pdf/otgruzka/{node}`, `/pdf/upd/{node}`,
`/pdf/poluchennyy-platezh/{node}`, `/pdf/otpravlenniy-platezh/{node}`, `/pdf/zakaz-klienta/{node}`,
`/pdf/akt/{node}`, `/pdf/schet-postavshika/{node}`, `/pdf/schet/{node}`,
`/pdf/zakaz-postavshiku/{node}`, `/pdf/postuplenie-tovarov/{node}`. Node bundle is constrained per route.

## Document creation (chain one doc into the next)
`/sozdaniye-zakaza-klienta/{node}`, `/sozdaniye-scheta-klienta/{node}`, `/sozdaniye-otgruzki/{node}`
(custom access `access_check.trinion_tp.sozdanie_otgruzki`), `/sozdaniye-scheta-postavshika/{node}`,
`/sozdaniye-zakaza-postavschiku/{node}`, `/sozdaniye-postupleniya-tovarov/{node}`, `/sozdaniye-kp/{node}`.
Payment creation forms: `/poluchenniy-platezh-sozdanie`, `/otpravlenniy-platezh-sozdanie`.

## Approval & sending
`/utverdit/{node}/{op}` — `access_check.trinion_tp.utverdit_document` (broad bundle list).
`/otpravit_schet/{node}` — `access_check.trinion_tp.otpravit_schet` (email an invoice).

## Export
`/admin/frontol/vigruzka-tovarov[/save]` (`trinion_tp frontol`), `/tovari/skachat` CSV
(`trinion_tp tovari`), `/vibor-tipa-tovara` product-type picker.

## Helper service
`trinion_tp.helper` (`TrinionHelper`, injected `@database`): `getNextDocumentNumber(type)`,
`getPolzovatelskayaCenaTovara(product, harakteristika)` — user pricing reused by trinion_cart.
