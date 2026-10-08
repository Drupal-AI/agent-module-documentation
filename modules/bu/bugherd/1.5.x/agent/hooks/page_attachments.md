# How the widget is attached (page_attachments)

Hooks live in `\Drupal\bugherd\Hook\BugherdHooks` (OOP `#[Hook(...)]` attribute class,
`@internal`). `bugherd.module` keeps procedural wrappers marked `#[LegacyHook]` for Drupal 10;
`bugherd.services.yml` sets `bugherd.skip_procedural_hook_scan: true` so D11+ uses only the
class. Implements `hook_help` (about text on `help.page.bugherd`) and `hook_page_attachments`.

## `pageAttachments(array &$attachments)`

Runs on every page build. Emits the widget only when all gates pass:

1. `$config = config('bugherd.settings')`; read `bugherd_project_key`.
2. **Return early** if the project key is empty **or** the current user lacks
   `access bugherd`.
3. **Return early** if `bugherd_disable_on_admin` is TRUE **and** the route is an admin route
   (`router.admin_context`→`isAdminRoute()`).
4. Build the reporter email: if `reporter_email_autofill` is TRUE and the user is **not**
   anonymous, load the current user entity and take `$user->getEmail()` (the current user's
   own email; never another account's).
5. Publish `drupalSettings`:
   ```php
   $attachments['#attached']['drupalSettings']['bugherd'] = [
     'bugherdconfig' => [
       'feedback' => ['tab_position' => $config->get('bugherd_widget_position')],
       'reporter' => ['required' => (bool) $config->get('email_required')],
     ],
     'project_key' => $project_key,
   ];
   // + reporter.email when autofilled; + feedback.<label_key> for each non-empty label override.
   ```
6. Attach the library and cache tag:
   ```php
   $attachments['#attached']['library'][] = 'bugherd/bugherd';
   $attachments['#cache']['tags'][] = 'bugherd';   // invalidated when settings are saved
   ```

## Client side (`js/bugherd.js`, library `bugherd/bugherd`)

`Drupal.behaviors.bugherd` runs once on the initial document (skips AJAX contexts). It reads
`drupalSettings.bugherd`, assigns `window.BugHerdConfig = settings.bugherd.bugherdconfig`, then
dynamically creates a `<script async>` whose `src` is
`https://www.bugherd.com/sidebarv2.js?apikey=<project_key>` and inserts it into the page. The
external sidebar script is served from bugherd.com by design.

Library declaration (`bugherd.libraries.yml`): `header: true`, `js/bugherd.js`, deps
`core/drupal` + `core/drupalSettings`.

## Integrator notes

- The project key is a **client-side, publicly visible** BugHerd project key (it ends up in a
  script URL any recipient of the page can read). Control exposure with the `access bugherd`
  permission, not by hiding the key.
- To vary attachment by path/context beyond the admin-route toggle, gate the `access bugherd`
  permission per role, or alter `#attached` in a later `hook_page_attachments_alter()`.
