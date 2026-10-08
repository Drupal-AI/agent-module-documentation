# Configuration

Access Filter's rules are **configuration entities**, managed from a rule
collection page. Because they are configuration, they export with the rest of
your site config and can be deployed between environments.

## Open the rule collection

1. Log in as a user with the **`manage access filters`** permission.
2. Go to **Configuration → People → Access Filter**, or navigate directly to
   `/admin/config/people/access_filter`.

This page lists every access-filter rule you have defined, and is where you add,
edit, reorder and delete them.

## Building a rule

Each rule decides whether requests from a given set of IP addresses are allowed
or denied. In practice you use rules in two broad shapes:

- **Allowlist** — permit only known, trusted addresses (for example your office
  network or a VPN range) and deny everything else. This is how you keep a
  staging or pre-launch site private, or lock the admin area to known networks.
- **Blocklist** — permit the public generally, but deny specific addresses or
  ranges (for example an abusive scraper or a range you want cut off).

You can express single addresses and ranges, and combine multiple rules to build
the policy you need.

## Order matters

Rules are evaluated as an ordered list, so the sequence determines the outcome
when more than one could match a request. Arrange them so the intended decision
wins — a narrow "allow this address" rule generally needs to sit ahead of a broad
"deny everything" rule for an allowlist to work.

## After saving

- Rules take effect immediately for new requests.
- Test from an address that *should* be allowed and one that *should* be blocked
  before you rely on the policy — and remember that behind a proxy the addresses
  the module sees depend on the `reverse_proxy` settings covered in
  [Installation](../installation/index.md).
- Because rules are configuration, you can export them (`drush config:export`) and
  deploy the same policy to another environment.

## A note on where to enforce this

Access Filter is genuinely useful when you cannot configure the web server or CDN,
or when the rules must ship with the site's configuration. But where you *can*
enforce IP restriction at the CDN or web-server level, that is stronger: it runs
before PHP starts, cannot be bypassed by an application bug, and keeps working
even if Drupal fails to boot. Consider Access Filter one layer of a defence, not
the only one.
