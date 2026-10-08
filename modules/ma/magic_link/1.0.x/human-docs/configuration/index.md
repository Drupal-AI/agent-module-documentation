# Configuration

Magic Link has a small, focused settings form. The choices you make here — chiefly
the **link expiry** — are also security choices, so it is worth setting them
deliberately.

## Get the basics right first

Because the emailed link logs a user in, serve login over **HTTPS** and send mail
over a **secure (TLS) transport**. Email templates support tokens, so make sure
outbound email is configured before you rely on the feature.

## Open the settings form

Go to **Configuration → People → Magic Link**
(`/admin/config/people/magic-link`). You need permission to administer the
module's settings (an administrator by default).

## Link expiry

Set how long a magic link remains valid — for example `15m`, `1h`, or `24h`.
**Keep this short.** The expiry is the main limit on how long a leaked or
intercepted link is dangerous: once it passes, the token is rejected even if
someone still has the URL. Fifteen minutes to an hour is typical for real login
use; longer values are convenient for development but weaken security.

## Email template and tokens

Customise the email that carries the link. The template supports **tokens**, so
you can personalise the message (site name, user, the link itself, and so on).
Keep the link out of anywhere it might be logged or exposed in plaintext other
than the recipient's message.

## Default destination after login

Optionally set a **default destination** — where a user lands after a magic link
signs them in (for example the front page, their account, or a dashboard). If you
leave it unset, Drupal's normal post‑login behaviour applies.

## One‑time vs persistent links

Token state is held in a key‑value expirable store. Links are **one‑time** by
default. A persistent‑link mode exists (surfaced through the Drush command for
development); do not use long‑lived or persistent links for ordinary end‑user
login, since they weaken the single‑use protection.

## Save

Click **Save configuration**. Changes take effect immediately for subsequently
issued links.
