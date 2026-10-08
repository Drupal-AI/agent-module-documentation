# Plugins — CKEditor 5 buttons & scheme access

Source: `src/Plugin/CKEditor5Plugin/*.php`, `js/plugins/ckeditor5/imce_private.ckeditor5.js`,
`imce_private.libraries.yml`, `imce_private.links.task.yml`, `imce_private.module`.

## The four plugins

Each is a PHP `@CKEditor5Plugin` annotation class extending `CKEditor5PluginDefault` (no PHP logic — the
behavior is in JS). Enable by dragging the toolbar item into a text format's CKEditor 5 toolbar at
*Admin › Config › Content authoring › Text formats and editors*.

| Drupal plugin id | Toolbar item | JS plugin | Opens IMCE at |
|---|---|---|---|
| `imce_private_image` | `imce_private_image` | `imceprivate.ImcePrivateImage` | private scheme (image) |
| `imce_private_link` | `imce_private_link` | `imceprivate.ImcePrivateLink` | private scheme (link) |
| `imce_private_public_image` | `imce_private_public_image` | `imceprivate.ImcePublicImage` | public scheme (image) |
| `imce_private_public_link` | `imce_private_public_link` | `imceprivate.ImcePublicLink` | public scheme (link) |

Shared library `imce_private/drupal.imce_private.ckeditor5` depends on `imce/drupal.imce.ckeditor5` and
`imce_private/drupal.imce_private.input`. The JS extends IMCE's `window.imceInput` and calls
`imceInput.ckeditor5PluginInit(editor, '<type>', label)`.

## Admin tabs & editor dialogs

- `imce_private.links.task.yml` adds "IMCE public" and "IMCE private" tabs (base route
  `system.admin_content`) linking to IMCE's `imce.page` with `scheme: public` / `scheme: private`,
  opening in a new tab.
- `imce_private_form_editor_link_dialog_alter` / `_editor_image_dialog_alter` →
  `imce_private_process_url_element()` adds the `imce-url-input` class + `data-imce-private-type`
  attribute and attaches `drupal.imce_private.input`, **only when `Imce::access()` returns TRUE**.

## Where access is enforced (important)

This module does **not** define permissions or gate file access. Browsing/reading a scheme is controlled
entirely by IMCE core:

- Route `imce.page` (`/imce/{scheme}`) uses `_custom_access:
  \Drupal\imce\Controller\ImceController::checkAccess`, which returns
  `AccessResult::allowedIf(Imce::access($currentUser, $scheme))`.
- `Imce::access($user, $scheme)` is true only if `Imce::userProfile($user, $scheme)` finds an IMCE
  configuration profile assigned to one of the user's roles **for that scheme** (managed at
  *Admin › Config › Media › IMCE*). No private profile for the role → no access to `private://`.
- Private file *downloads* additionally pass through Drupal's private-file delivery
  (`hook_file_download`); the README recommends the *Private files download permission* contrib module
  to define those rules.

Net effect: adding these buttons surfaces the private browser in the UI, but a user still cannot browse
or read private files unless IMCE core has granted their role a private-scheme profile server-side.
