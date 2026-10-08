<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Boncard client & operations

**`BoncardClient`** (`src/Client/BoncardClient.php`) — outbound calls to `endpoint` config + path:
| Method | Path | Signature prefix |
|---|---|---|
| checkBalance | `/api/v1/balance` | `BALANCE+terminalId+cardNumber` |
| paymentRequest | `/api/v1/payment` | `PAYMENT+trxRef+date+time+terminalId+cardNumber+amountMinor` |
| submissionRequest | `/api/v1/submission` | `SUBMISSION+...` |
| refund | `/api/v1/credit` | `CREDIT+...` |
| cancel | `/api/v1/reversal` | `REVERSAL+trxRef+terminalId` |

- `calculateSignature($payload)` = base64(hex2bin(hmac_sha256(`$payload+password`, `password`))) — the shared `password` config is the signing key.
- `postRequest()` uses `http_client_factory->fromOptions()` (default TLS verification) and posts JSON.
- `validate()` requires `status === 1`, else logs the extended error and throws `BoncardException`.

**Access:** `Access/BoncardOperationAccessCheck::access()` returns `$entity->access($operation, $account, TRUE)`; permissions in `commerce_boncard.permissions.yml` gate create/view/edit/cancel/refund/delete. No inbound callback route exists.
