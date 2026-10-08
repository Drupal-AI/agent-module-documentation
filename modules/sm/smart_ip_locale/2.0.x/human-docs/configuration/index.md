# Configuration

Smart IP - Language Negotiation Redirect does its work through Drupal's standard
language-negotiation screen. Before you start, make sure the **Smart IP** module
is installed and has a working geolocation data source, and that your site's
languages are already added.

## 1. Open the language detection settings

1. Log in as a user with the **Administer languages** permission (an administrator
   by default).
2. Go to **Administration → Configuration → Regional and language → Languages**
   (`/admin/config/regional/language`), then open the **Detection and selection**
   settings.

## 2. Enable the Smart IP detection method

In the list of detection methods for the interface language, tick **Smart IP
country code**. This is the method this module adds — it resolves the visitor's
country through Smart IP and picks the language you have mapped to it.

## 3. Order the detection methods

Detection methods are tried top to bottom, and the first one that yields a
language wins, so the order matters. The maintainers recommend:

**URL → Cookie → Smart IP country code**

Putting URL and Cookie above Smart IP means an explicit choice — a language-prefixed
URL or a remembered cookie — always takes priority over the IP guess, and the IP
detection only kicks in as a fallback for visitors who have not chosen yet. This
respects the general rule that geolocation should *suggest* rather than *force* a
language. Drag the rows into order and save.

## 4. Map countries to languages

Edit the module's configuration to add the **country-code → language** mapping:
for each country code you care about, choose the site language a visitor from that
country should get. Only the countries you map are routed; anyone whose country is
unmapped (or cannot be geolocated) falls through to the next detection method.

## Things to check afterwards

- **Trusted proxies.** If your site sits behind a load balancer, reverse proxy, or
  CDN, configure Drupal's trusted-proxy settings so Smart IP sees the real client
  IP rather than the proxy's. Without this the country lookup is meaningless.
- **Provide a switch-back path.** Make sure a language switcher (or equivalent) is
  available so visitors can override the detected language, and remember that the
  guess is a heuristic that VPNs and proxies will defeat.
- **Crawlers.** Be mindful that auto-routing by IP can confuse search-engine
  crawlers; the recommended URL-first ordering plus Language Cookie helps keep the
  behaviour predictable.
