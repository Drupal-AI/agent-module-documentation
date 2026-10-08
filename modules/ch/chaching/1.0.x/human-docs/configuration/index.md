# Configuration

Cha-ching needs two things set up: which PayPal receiver email(s) to accept, and
pointing your PayPal account at the IPN callback. After that, you consume the read
feeds.

## 1. Set your accepted receiver email(s)

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Cha-ching**
   (`/admin/config/services/chaching`).
3. Enter one or more **Receiver email addresses** — the PayPal account email(s)
   that legitimately receive your donations.

Only IPNs whose `receiver_email` matches this allow-list are stored. This is a key
guard: it prevents someone from replaying or forging notifications aimed at a
different account into your register.

## 2. Point PayPal at the IPN callback

In your PayPal account's IPN settings, set the notification URL to:

```
https://<your-site>/paypal/ipn
```

(The legacy alias `https://<your-site>/lm_paypal/ipn` also works.) Both are
POST-only and intentionally open to unauthenticated callers, because PayPal is
anonymous — that's how IPN works.

### Why the open callback is safe

When an IPN arrives, `ChachingController::ipn()` re-posts the exact payload back to
PayPal (`https://www.paypal.com/cgi-bin/webscr`, or the sandbox when `test_ipn` is
set) with `cmd=_notify-validate`, over HTTPS with default TLS verification. A row
is inserted **only if** PayPal returns `VERIFIED` **and** the receiver email is on
your allow-list. Unknown fields are dropped; only columns in the module's schema
are stored (table `chaching_paypal_ipns`). So although the endpoint is public,
nothing is recorded unless PayPal itself confirms the payment.

## 3. Read the donation feeds

The read routes require the **`access chaching metadata`** permission — grant it to
the role(s) that should see the feeds (often anonymous, since the data is
non-personal amount/date aggregates only).

- **JSON / RSS feed:** `/v1/donations/{type}/{period}/{format}/{filter}`
  - `type` — `total` or `list`
  - `period` — `mtd` (month-to-date), `1m`, `ytd` (year-to-date), `1y`, or `all`
  - `format` — `json` or `rss`
  - JSONP is available via `?callback=` (the callback is rejected if it contains
    any non-word `\W` character)
- **Graph:** `/graph/{period}` renders a jqPlot chart.
- **API docs:** `/docs` shows example URLs and sample JavaScript.

Feeds are cache-tagged and invalidated when a new IPN is recorded, so a public
"donations so far" widget stays current without serving stale data.
