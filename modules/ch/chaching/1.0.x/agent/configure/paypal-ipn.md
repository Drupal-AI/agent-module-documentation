<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cha-ching — PayPal IPN setup & feeds

## Configure
`/admin/config/services/chaching` (`chaching.admin`) → **Receiver email addresses**
(`chaching.settings:receiver_email`, an array). Only IPNs whose `receiver_email` is in this
list are stored.

## Point PayPal at the callback
Set the PayPal account's IPN notification URL to `https://<site>/paypal/ipn`
(legacy alias `/lm_paypal/ipn`). Both are POST-only, `_access: TRUE` (PayPal is anonymous).

### How writes are protected (why the open route is safe)
`ChachingController::ipn()` → `validate()` re-posts the exact payload to
`https://www.paypal.com/cgi-bin/webscr` (or sandbox when `test_ipn`) with `cmd=_notify-validate`
over HTTPS; the row is inserted only if PayPal returns `VERIFIED` **and** the receiver email
matches. Unknown fields are dropped to schema columns; table = `chaching_paypal_ipns`.

## Read feeds (`access chaching metadata`)
- `/v1/donations/{type}/{period}/{format}/{filter}` — `type` total|list, `period` mtd|1m|ytd|1y|all,
  `format` json|rss. JSONP via `?callback=` (rejected if it contains `\W`).
- `/graph/{period}` — jqPlot chart.  `/docs` — example URLs + sample JS.