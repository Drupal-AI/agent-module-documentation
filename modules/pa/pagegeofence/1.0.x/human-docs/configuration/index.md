# Configuration

Page Geofence is configured in two parts: a **module setting** that tells it which
request header carries the visitor's country, and one or more **geofence rules** that say
which pages are restricted, for which countries, and what happens to a blocked visitor.

> **Remember:** this is a soft, policy‑level control. Geo‑IP can be bypassed with a
> VPN/proxy, so don't rely on it to protect sensitive content — use real access control
> for that.

## Set the country request header

In the module settings, specify the exact **header name** that contains the visitor's
country code. This is what makes the module portable across hosting setups — common
values are:

- `HTTP_CF_IPCOUNTRY` (Cloudflare)
- `X-Country-Code` (a custom edge/proxy header)

Enter the header your infrastructure actually sends. Also confirm Drupal's **trusted
proxy** configuration so the header (and the client IP behind it) is trusted rather than
spoofable.

## Create a geofence rule

Open the geofence **rules collection** (route `entity.pagegeofence_rule.collection`) and
add a rule. For each rule you set:

- **Target page(s)** — the path the rule applies to. You can target a single page
  exactly, or a page **and its sub‑pages** (sub‑paths) using a wildcard, so a whole
  section can be covered by one rule.
- **Countries** — the list of countries/regions the rule concerns, matched against the
  code from your configured header.
- **Restriction type — allow or deny** — whether the selected countries are the *only*
  ones allowed to see the page, or the ones **denied** access. Choose the sense that
  matches your intent.
- **Response for blocked visitors** — either **redirect** the visitor to another URL
  (internal or external) or return a **403** access‑denied response.
- **Weight** — rules are evaluated in weight order, so ordering matters when more than one
  rule could apply to the same path. Put more specific or higher‑priority rules where they
  should win.
- **Justification / legal reasoning** — a note recording *why* the restriction exists.
  The module records this for documentation and compliance purposes.

## Logging

Every change to a restriction is written to a **time‑stamped log** — including whether it
was enabled or disabled, its scope, the affected countries, the restriction type and the
recorded reasoning. Review these logs when you need an audit trail of who changed what and
why.

## Save and test

Save the rule, then test it against an IP/country that should be blocked and one that
should be allowed. Because rules are processed by weight and default behaviour is "no
geofencing," take care that a broad rule doesn't accidentally block visitors you meant to
let through.
