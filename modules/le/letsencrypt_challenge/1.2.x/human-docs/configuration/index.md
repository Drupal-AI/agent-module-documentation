# Configuration

Configuration is deliberately tiny: there is one form with one job — hold the
challenge value that Let's Encrypt will come to fetch.

## Open the challenge form

1. Log in as a user with the **Administer Let's Encrypt challenge** permission
   (grant it under **People → Permissions** to a trusted administrator role — it
   controls what gets served at the public challenge path).
2. Go to **Configuration → Let's Encrypt Challenge**, or navigate directly to
   `/admin/config/letsencrypt_challenge/challenge`.

## The challenge value field

The form holds the **challenge response value** — the string your ACME client
prints during a manual run. Paste that exact value in and save. Drupal stores it
in **state** (not configuration), which is the right home for a short‑lived
token: it won't be written to a config export and won't travel between
environments by accident.

Once saved, both public routes serve that value:

- `/.well-known/acme-challenge` and
- `/.well-known/acme-challenge/{key}`

The `{key}` segment in the URL is accepted but not matched against anything — the
same stored value is returned regardless. That is exactly what the single‑token
manual flow needs; it is not built to answer several different tokens at once.

## The file‑based alternative

You do not *have* to use the form. If a file exists at
`public://letsencrypt_challenge/FILENAME` (that is,
`sites/default/files/letsencrypt_challenge/FILENAME`), the module returns the
contents of that file instead. This is handy with ACME clients — lego, for
example — that can write the challenge file into that directory themselves. Use
whichever path suits your workflow; the form is the manual, copy‑paste option and
the file is the automated‑client option.

## After validation

Once the certificate has been issued or renewed you can clear the value (save an
empty form) — it has served its purpose and the token is no longer meaningful.
Repeat the paste‑and‑save step the next time you renew.
