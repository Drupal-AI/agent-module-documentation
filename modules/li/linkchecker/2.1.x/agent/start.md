# linkchecker — agent start

Extracts links from content on save and re-checks them on cron, reporting broken (404/error)
links. Stores each URL as a `linkcheckerlink` content entity (`linkchecker_link` table). No
required module dependencies. Settings UI: **Admin → Config → Content authoring → Link
checker** (`/admin/config/content/linkchecker`, route `linkchecker.admin_settings_form`).
Broken-links report: **Admin → Reports → Broken links** (`/admin/reports/linkchecker`).

- Choose fields/entities to scan, HTTP options, cron/queue checking, the report → [configure/linkchecker.md](configure/linkchecker.md)
- Services, plugin types (extractor + status handler), event, Drush → [api/linkchecker.md](api/linkchecker.md)
- Permissions → [permissions/linkchecker.md](permissions/linkchecker.md)
