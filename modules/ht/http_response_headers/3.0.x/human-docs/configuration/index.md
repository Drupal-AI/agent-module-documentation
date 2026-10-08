# Configuration

Everything happens on one screen: **Configuration → System → HTTP Response Headers**
(`/admin/config/system/response-headers`). You need the **Administer HTTP response
headers** permission.

## The header list

The list shows every header the module knows about — the ten shipped defaults plus
any you add. Each row has links to **enable**, **disable**, **edit**, and **delete**
it. Disabled headers are ignored completely, so toggling a header off is the quick
way to remove its effect without deleting your configuration (handy per environment).

## Adding or changing a header

Click **Add response header** (or **Edit** on an existing one) and fill in:

- **Label** — a human-friendly name for your own reference (for example
  "Clickjacking protection").
- **Machine name / ID** — an internal identifier, generated from the label.
- **Description** — optional notes about what the header is for.
- **Name** — the **actual HTTP header** to send, such as `X-Frame-Options` or
  `Strict-Transport-Security`.
- **Value** — the header's value, such as `SAMEORIGIN` or
  `max-age=31536000; includeSubDomains`.
- **Visibility** — optional conditions that scope where the header applies (see
  below).

Make sure the header is **enabled**, and save. From then on the header is sent on
matching responses.

## Removing a header the site already sends

This is the counter-intuitive but useful part: to **strip** a header that Drupal or
PHP emits — such as `X-Powered-By` (which reveals your PHP version) or `X-Generator`
(which advertises Drupal) — create an **enabled** entry whose **Name** matches that
header and whose **Value is left empty**. When the value is empty, the module removes
the header from the response rather than adding it. The shipped `x_powered_by` and
`x_generator` defaults already work exactly this way — enable them to hide those
headers.

## Visibility conditions

The **Visibility** section uses the same condition plugins that Drupal blocks use:
request path, user role, content type, language, and so on. When you set conditions,
**all** of them must pass for the header to be applied (they combine with AND logic).
Leave visibility empty and the header applies everywhere. This lets you, for example,
send a strict header site-wide but disable it on admin pages, or apply a header only
on a particular content type's pages.

## The ten shipped defaults

Enabling the module installs these header configurations, ready to enable and tune:

| Config | Header | Typical use |
|---|---|---|
| `access_control_allow_origin` | `Access-Control-Allow-Origin` | CORS |
| `content_security_policy` | `Content-Security-Policy` | Restrict script/style sources |
| `public_key_pins` | `Public-Key-Pins` | Certificate pinning (legacy) |
| `referrer_policy` | `Referrer-Policy` | Privacy of the Referer header |
| `strict_transport_security` | `Strict-Transport-Security` | Force HTTPS (HSTS) |
| `x_content_type_options` | `X-Content-Type-Options` | Stop MIME sniffing |
| `x_frame_options` | `X-Frame-Options` (SAMEORIGIN) | Clickjacking protection |
| `x_generator` | `X-Generator` (empty ⇒ removed) | Hide that Drupal generated the page |
| `x_powered_by` | `X-Powered-By` (empty ⇒ removed) | Hide the PHP version |
| `x_xss_protection` | `X-Xss-Protection` | Legacy browser XSS filter |

Because each header is a configuration entity, you can export your chosen set and
import it on other sites to standardise your security headers.

## Ordering note

The module applies its headers late in the request (after most other code has run),
so if you configure the same header name here that another layer sets, your value
generally wins.
