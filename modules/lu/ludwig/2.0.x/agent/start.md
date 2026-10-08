# ludwig — agent start

Manual alternative to Composer: modules declare external PHP libraries in a `ludwig.json`
file; Ludwig downloads them into each module's `lib/` dir and autoloads PSR-4/PSR-0
namespaces. No dependencies. Config UI (the report): **Admin → Reports → Packages**
(`/admin/reports/packages`); route `ludwig.packages`, gated by core `access site reports`.

Note: 2.0.x has **no Drush command** and **no config settings** — downloading is done by
visiting the Packages report page.

- The Packages report + non-Composer download workflow → [configure/ludwig.md](configure/ludwig.md)
- Declare libraries in `ludwig.json` + how they get autoloaded (services) → [api/ludwig.md](api/ludwig.md)
