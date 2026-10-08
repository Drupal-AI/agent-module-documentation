<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EtherAPI — pay form & status callback

Controller `Drupal\etherapi\Controller\Pages::pages($page_type)`, route `/etherapi/{page_type}` (`_permission: access content`).

## `pay`
`/etherapi/pay?pay_id=<id>` loads the payment; if it exists and `status == 'new'`, renders `\Drupal\etherapi\Form\PaymentForm`, else 404. Read-only display of amount/address.

## `status` (etherapi.net server-to-server callback)
Steps (all must pass or it 404s / prints `Sign wrong`):
1. If `config.REMOTE_ADDR` non-empty, `$_SERVER['REMOTE_ADDR']` must be in that newline list.
2. POST body must contain `etherapi.net` (falls back to raw `php://input` JSON).
3. Loads payment by `$_POST['tag']`; `$_POST['token']` (default `ETH`) must equal `payment->currency`.
4. Computes `sha1(implode(':', [type,date,from,to,(token if !=ETH),amount,txid,confirmations,tag, trim(apiKey)]))` where `apiKey = config.keys[currency].key`, and compares strictly to `$_POST['sign']`.
5. On match: appends POST to `payment->data`, sets `paytime`, status `pay`, `update()`s, calls `basket->paymentFinish($nid)`, fires `hook_etherapi_api_alter`, then `exit('OK')`.

**Operator note:** fill both the API key (for every currency) and the IP allow-list.
