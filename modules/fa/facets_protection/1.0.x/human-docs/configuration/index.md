# Configuration

Facets Protection has three things to set up: the token's validity period on the
module's settings form, the look of the blocking pages (through theme templates),
and the permissions it provides.

## Token validity period

The core setting is how long a facet token stays valid. This is configured in the
backend on the module's settings form: shorter lifetimes force tokens to be
regenerated more often (tighter against crawlers replaying cached URLs), while
longer lifetimes are more forgiving of legitimate visitors who linger. Choose a
period that balances protection against the normal browsing rhythm of your real
visitors, and save.

Because the token has to be present on legitimate facet links for real visitors to
click through without hitting the blocking page, verify after changing the period
that ordinary faceted browsing still works end to end.

## Blocking pages

When a facet request arrives without a valid token, the module serves one of two
minimal blocking pages and returns HTTP **410 ("Gone")**:

- A **plain** page where the working links appear after about 2.5 seconds and can
  then be clicked.
- A **CAPTCHA‑style** page where a click triggers the forward.

Both are deliberately minimal to keep resource use low. You adapt their appearance
by **overriding the module's templates in your theme** — copy the relevant template
into your theme and adjust the markup there, then clear the cache.

## Permissions

The module registers its own permissions on **People → Permissions**
(`/admin/people/permissions`). Review them and grant them only to the roles that
should be exempt from or able to administer the protection, keeping anonymous
crawlers subject to the token check.

## Scope reminder

This protection stops bots that traverse **previously cached** facet URLs; it does
**not** stop bots crawling the site in real time. Treat it as interim protection
until facets can be migrated to Facets 3 exposed filters. For a different, more
aggressive approach, consider
[Facet Bot Blocker](https://www.drupal.org/project/facet_bot_blocker), which limits
the number of selectable facets instead.
