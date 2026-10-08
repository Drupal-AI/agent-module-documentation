# Configure — moderation_dashboard

## Settings form

- **Route:** `moderation_dashboard.settings` (the `configure` route in `*.info.yml`).
- **Path:** `/admin/config/people/moderation_dashboard`.
- **Permission:** `administer site configuration`.
- **Menu:** also linked under Admin → People index (`user.admin_index`) as "Moderation Dashboard".
- Form class: `Drupal\moderation_dashboard\Form\SettingsForm` (a `ConfigFormBase`).

Config object `moderation_dashboard.settings` (schema `moderation_dashboard.schema.yml`) has
exactly two boolean keys:

| Key | Default | Effect |
|---|---|---|
| `redirect_on_login` | `true` | After a user logs in via the user-login form, redirect them to their moderation dashboard — but only if they have `use moderation dashboard`, at least one moderated content type exists (`has_moderated_content_type` condition), and the login had no explicit `?destination`. |
| `chart_js_cdn` | `false` | `false` = load Chart.js from a locally installed library (recommended); `true` = load it from a CDN. `hook_requirements()` warns at `/admin/reports/status` when this is off and no local Chart.js library is found. |

### Read / write with drush

```bash
drush cget moderation_dashboard.settings                       # show both keys
drush cget moderation_dashboard.settings redirect_on_login     # single key
drush cset moderation_dashboard.settings redirect_on_login false -y
drush cset moderation_dashboard.settings chart_js_cdn true -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('moderation_dashboard.settings')
  ->set('redirect_on_login', FALSE)
  ->set('chart_js_cdn', TRUE)
  ->save();
```

## The dashboard page itself

The dashboard is **not** the settings form — it is a Views page:

- Route `view.moderation_dashboard.page_1`, path **`user/%user/moderation-dashboard`**.
- Rendered through the `moderation_dashboard` **user view mode** using **Layout Builder**.
- The layout is the module's `moderation_dashboard` layout plugin ("Moderation Dashboard
  Layout", regions `left` / `middle` / `right`, template `moderation-dashboard.html.twig`).

### Customise the dashboard (no code)

Enable Views UI, then edit the user account display for the moderation dashboard view mode:

```
/admin/config/people/accounts/display/moderation_dashboard
```

There you add / remove / re-order blocks in the Layout-Builder layout. The building blocks
available include the four shipped Views and the two custom blocks
(`moderation_dashboard_activity`, `moderation_dashboard_add_links`) — see
[api/moderation_dashboard.md](../api/moderation_dashboard.md). The module intentionally
ships **no update hooks**, so any Layout-Builder / Views customisation you make is preserved
across module updates.

## Chart.js library

For the activity chart, either install `nnnick/chartjs` locally (into `libraries/chart.js/`
or `libraries/chartjs/`) or set `chart_js_cdn: true`. `hook_library_info_alter()` picks the
correct internal library variant automatically based on what it finds on disk; the CDN
variant is `moderation_dashboard/chart.js.external`.
