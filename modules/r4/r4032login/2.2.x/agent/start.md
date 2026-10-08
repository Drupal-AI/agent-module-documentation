# r4032login — agent start

Redirect 403 to User Login. A kernel exception subscriber catches HTTP 403 (Access Denied)
and redirects anonymous users to the login page (default `/user/login`), optionally returning
them to the requested page after login. Authenticated users can be redirected elsewhere or
given a 404. No dependencies outside Drupal core. All behavior lives in the `r4032login.settings`
config object; UI at **Admin → Config → System → Redirect 403 to User Login**
(`/admin/config/system/r4032login/settings`); settings route `r4032login.settings.form`.

- Settings keys, the three config tabs, permission → [configure/settings.md](configure/settings.md)
- Alter the redirect URL/options via the `r4032login.redirect` event → [extend/subscriber.md](extend/subscriber.md)
