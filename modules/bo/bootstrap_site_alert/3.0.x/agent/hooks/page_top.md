# Rendering: hook_page_top + dismiss JS

`bootstrap_site_alert_page_top(array &$page_top)` in `bootstrap_site_alert.module` is the only render
path — there is no block or controller. It runs on every response and injects render elements at
`#weight` 1000 (bottom of the page-top region). This is theme-independent; it only assumes the front
end provides Bootstrap `alert` CSS.

## Loop and gating

It reads `bootstrap_site_alert_count` from state and loops `i = 0 .. count-1`. An alert `i` is rendered
only when **all** of these hold:

1. `bootstrap_site_alert_active<i>` is truthy.
2. The current user has permission `view bootstrap site alerts`.
3. Admin rule: if `bootstrap_site_alert_no_admin<i>` is set, the current route is **not** an admin route
   (`\Drupal::service('router.admin_context')->isAdminRoute()`).
4. Path rule (`$page_match`): if `bootstrap_site_alert_exclude<i>` is set and `bootstrap_site_alert_only_paths<i>`
   is non-empty, the current path is tested with `path.matcher`:
   - Paths are lowercased; `<front>` is replaced with the site's configured front path
     (`system.site:page.front`).
   - The current path is resolved to its alias (unless it is the front page) before matching.
   - `matchPath($path, $paths)` decides the match; `bootstrap_site_alert_negate<i>` inverts it (show on
     every page **except** the listed ones).

## Markup

Built with an `inline_template`:

```
<div class="alert bs-site-alert {{ level }}" role="alert" ...>{{ message }}</div>
```

- `level` is the stored severity class (e.g. `alert-warning`); Twig autoescapes it.
- `message` is a render element `['#type' => 'processed_text', '#text' => ..., '#format' => <stored format>]`,
  so the body is run through the text format the editor selected on the config form.
- If `bootstrap_site_alert_dismiss<i>` is set, the wrapper gets inline `style="display:none;"` (to avoid a
  flash before JS hides it) and a close button
  `<button class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>`.

The visible element is keyed `bootstrap_site_alert<i>`; for dismissible alerts the JS assets are attached
under the un-indexed key `bootstrap_site_alert` (`#attached`), carrying the library and drupalSettings.

## Dismiss behavior (JS + cookie)

When any alert is dismissible, the hook attaches:
- Library `bootstrap_site_alert/dismissed-cookie` → `js/dismissed-cookie.js`
  (depends on `core/jquery`, `js_cookie/js-cookie`, `core/drupalSettings`).
- `drupalSettings.bootstrap_site_alert.dismissedCookie.key` = `bootstrap_site_alert_key` (the random
  token regenerated on each save).

`Drupal.behaviors.bootstrapSiteAlert` in `js/dismissed-cookie.js`:
- Reveals `.bs-site-alert` (sets `display:block`) **unless** the cookie
  `Drupal.visitor.bootstrap_site_alert_dismissed` already equals the current `key`.
- On clicking `.bs-site-alert .close`, it prevents default, sets that cookie to `key` (scoped to
  `drupalSettings.path.baseUrl`), and hides the alert.

Because `key` changes every time the form is saved, editing an alert makes visitors who previously
dismissed it see the new version again (their stored cookie no longer matches the fresh key).

## Libraries

| Library | Assets | Used for |
|---|---|---|
| `bootstrap_site_alert/dismissed-cookie` | `js/dismissed-cookie.js` (+ jquery, js_cookie, drupalSettings) | Dismiss handling on the front end. |
| `bootstrap_site_alert/bs-site-alert-form` | `css/form.css` | Spacing on the admin config form (attached in `buildForm`). |
