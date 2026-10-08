# Configuration

CAPTCHA After has one thing to decide — **how many failed attempts to allow
before a CAPTCHA appears** — plus a couple of security points to confirm. Because
the module extends the CAPTCHA module, it is administered alongside CAPTCHA.

## Open the settings

1. Log in as a user with permission to administer CAPTCHA.
2. Go to **Configuration → People → CAPTCHA**
   (`/admin/config/people/captcha`), where the CAPTCHA module's settings — and
   CAPTCHA After's attempt threshold — are managed.

## The attempt threshold

The central setting is the number of unsuccessful submit attempts allowed before
a CAPTCHA is shown. Below the threshold, submissions proceed without a CAPTCHA;
once a visitor reaches it, the CAPTCHA appears on subsequent attempts.

Choose the value with the trade‑off in mind:

- **Lower is safer.** The attempts allowed before the CAPTCHA kicks in are also
  the automated attempts that get through unchallenged. A bot effectively gets
  that many "free" tries per whatever the counter keys on, so keep the threshold
  low enough to bound the abuse you are willing to tolerate.
- **Higher is friendlier** to legitimate users who mistype, but widens the gap a
  bot can exploit.

## Security points to confirm

- **Server‑side counting.** The attempt count must be tracked on the server, not
  in the browser. A count the client controls can be reset at will, which would
  defeat the protection entirely.
- **Keyed on something hard to reset.** Confirm the counter keys on IP address or
  session rather than something an attacker can trivially change between attempts,
  so the "free" attempts cannot simply be renewed.

## Save

Save the settings, then test a protected form: submit it wrongly enough times to
cross the threshold and confirm the CAPTCHA appears as expected before you rely on
it in production.
