# Configuration

Domain Google Analytics has one configuration page where you enter a Google
Analytics tracking code for each of your domains.

## Open the configuration page

1. Log in as an administrator.
2. Go to **Configuration → System → Multidomain Google Analytics**, or navigate
   directly to `/admin/config/system/multidomain-google-analytics`.

## Enter a tracking code per domain

The form is organised around the domain records you created in the Domain module.
For each domain you get a field to hold that domain's Google Analytics code:

- **Domain** — each of your configured domains is listed, so the tracking code is
  scoped per domain.
- **Google Analytics code / measurement ID** — paste the tracking code (or
  measurement ID) for that domain's Analytics property. This value is ordinary
  configuration, not a secret credential.

Fill in a code for each domain you want to track and click **Save**. Domains you
leave blank simply have no tracking added.

## Verify

Load a page on one of the configured domains and view the page source. You should
see the Google Analytics code you entered for *that* domain — and, on another
domain, its own code. If you see the same code everywhere or the wrong one, check
that page caching is varying per domain (see the note below).

## A caution about caching and consent

- **Cache per domain.** Because the tracking code is embedded in the rendered
  page, a page cached for one domain must not be served to another with the wrong
  measurement ID. Confirm your caching varies by domain so one site's traffic is
  never attributed to another site's property.
- **Consent per domain.** If your domains are in different jurisdictions, review
  consent/cookie requirements separately for each — a single site-wide consent
  setup may not satisfy every domain's rules.
