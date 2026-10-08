# Reports pages, permission, and service

There is **no settings page** (`configure` is null) and **no config entity**. This submodule is
two report controllers plus a permission.

## Routes / pages

| Route | Path | Controller method | Shows |
|---|---|---|---|
| `mailchimp_transactional_reports.dashboard` | `admin/reports/mailchimp_transactional` | `ReportsController::dashboard` | Volume chart (sent / bounced / rejected) from `getTagsAllTimeSeries()`. |
| `mailchimp_transactional_reports.summary` | `admin/reports/mailchimp_transactional/summary` | `ReportsController::summary` | Account/user summary from `getUser()`. |

A menu link under *Reports* (`system.admin_reports`) and two local tasks (Dashboard, Account
summary) point at these.

## Permission (and the routing typo)

- **Defined** in `mailchimp_transactional_reports.permissions.yml`:
  `view mailchimp transactional reports` (title "View Mailchimp Transactional reports",
  `restrict access: true`). This is the machine name you grant to a role.
- **Referenced** by both routes' `_permission`: `view mailchimp_transactional reports`
  (note the underscore between "mailchimp" and "transactional").

These two strings do not match, so the routes require a permission that no module defines →
access is denied to every role, and only user 1 (who bypasses access) can open the pages. Grant
the defined permission for role-based access to work only if you also patch the route requirement
to the defined spelling. Grant with:

```
drush role:perm:add <role> 'view mailchimp transactional reports'
```

## Service & data

`mailchimp_transactional_reports.service` → `ReportsService` (constructed with the base
`mailchimp_transactional` API client, `config.factory`, and the `cache.mailchimp_transactional`
bin). It exposes the reporting reads used by the controller; there is also a
`.test.service` variant wired to the test API. All report data comes from the **external**
Mailchimp Transactional API (cached in the module's cache bin) — there is no local data to
configure.
