# SpamSpan (spamspan) 3.2.x

Email-address obfuscation for Drupal. Ships a text-format **filter** (`filter_spamspan`),
an **email field formatter** (`email_spamspan`), a **Twig filter** (`spamspan`), and a
**service** (`spamspan`). Depends only on core Filter. No permissions of its own
(uses core `administer filters`); no Drush commands.

- [configure/spamspan.md](configure/spamspan.md) — enable the filter on a text format, all
  8 filter settings, the `email_spamspan` field formatter, config schema, and the test page.
- [api/spamspan.md](api/spamspan.md) — the `spamspan` service, the `|spamspan` Twig filter,
  the `SpamspanInterface`/traits, and attached JS/CSS libraries for calling it from code.

`configure` route is core's **`filter.admin_overview`** (Text formats list) — SpamSpan has
no dedicated settings page; all options live on the per-format filter configuration.
