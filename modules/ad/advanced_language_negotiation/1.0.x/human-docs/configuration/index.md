# Configuration

Advanced Language Negotiation plugs into Drupal's core language detection, so you
configure it there rather than on a separate form.

## Prerequisites

Make sure you have **more than one language** added under **Configuration →
Regional and language → Languages** (`/admin/config/regional/language`), and that
each language has the **domain** and/or **URL path prefix** you intend to use set
on its own configuration. The negotiation method combines those values, so they
need to be defined first.

## Enable the negotiation method

1. Go to **Configuration → Regional and language → Languages → Detection and
   selection** (`/admin/config/regional/language/detection`).
2. In the list of detection methods, enable the method this module adds, which
   determines the language from **domain and path prefix together**.
3. **Order matters.** Drupal tries enabled methods top to bottom and uses the
   first that resolves a language. Place this method where you want it to take
   effect relative to the other enabled methods (URL, session, browser, and so
   on).
4. Save.

## Verify

Visit your site on each configured domain and path-prefix combination and confirm
the active language matches what you expect. Because this is a beta release,
check the edge cases — a domain with no prefix, a prefix on the wrong domain — to
be sure the resolution behaves as intended before going live.
