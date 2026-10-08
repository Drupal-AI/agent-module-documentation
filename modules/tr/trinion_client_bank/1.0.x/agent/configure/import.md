<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Importing Client-Bank payments

## File format
A 1C "Client-Bank" export: Windows-1251 text, one or more blocks delimited by
`СекцияДокумент=...` … `КонецДокумента`. Recognised keys include Номер, Дата, Сумма,
Плательщик/Получатель (+ИНН/КПП/РасчСчет/Банк1/БИК/Корсчет) and НазначениеПлатежа.

## Steps
1. Grant `trinion_client_bank client_bank` to the import operator role.
2. Go to `/client-bank-import-payments`, upload the `.txt` export, submit.
3. For each block the form finds/creates the counterparty (`kompanii` node, matched
   by `field_tl_inn`) and its bank account term, then creates a
   `trinion_payment_client_bank` node unless an identical one already exists.
4. Open a created document and use `/sozdaniye-platezha/{node}` (a button/AJAX link)
   to generate the matching `otpravlennyy_platezh` / `poluchennyy_platezh` payment;
   the link is idempotent (re-running redirects to the existing payment).

## Notes
- Direction (incoming/outgoing) is decided by which side's INN matches an existing
  organization taxonomy term (`field_tp_inn`).
- Requires the `trinion_tp` field set and the `trinion_tp.helper` document-number service.
