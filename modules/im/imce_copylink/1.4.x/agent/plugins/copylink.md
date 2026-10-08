<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `copylink` IMCE plugin

The module contributes exactly one plugin to IMCE's `ImcePlugin` plugin type. It does **not** define a
plugin type of its own — it discovers into imce core's type (dir `Plugin/ImcePlugin`, manager
`Drupal\imce\ImcePluginManager`, interface `Drupal\imce\ImcePluginInterface`, base
`Drupal\imce\ImcePluginBase`, annotation `Drupal\imce\Annotation\ImcePlugin`, alter hook
`imce_plugin_info`).

## PHP side — `src/Plugin/ImcePlugin/Copylink.php`

```php
/**
 * @ImcePlugin(
 *   id = "copylink",
 *   label = "Copy Link",
 * )
 */
class CopyLink extends ImcePluginBase {

  public function permissionInfo() {
    return array('copylink' => $this->t('Copy link'));
  }

  public function buildPage(array &$page, ImceFM $fm) {
    if ($fm->hasPermission('copylink')) {
      $page['#attached']['library'][] = 'imce_copylink/drupal.imce.copylink';
    }
  }
}
```

- **`permissionInfo()`** returns one IMCE permission, `copylink` (label "Copy link"). IMCE collects
  these from every plugin and renders a checkbox per directory on the IMCE profile form
  (`/admin/config/media/imce` → edit a profile → *Directories*). This is an **IMCE profile permission,
  not a Drupal permission** — there is no `imce_copylink.permissions.yml`, and it will not appear in
  `drush role:perm:list`. It is granted through the IMCE profile that a role is assigned, per folder.
- **`buildPage()`** is called by IMCE while assembling the file-manager page. It attaches the module's
  JS/CSS library **only if** the current user has the `copylink` permission in the active configuration
  (`$fm->hasPermission('copylink')` → `Imce::permissionInConf(...)`). No permission ⇒ the library is
  never attached and the button never appears.
- The other `ImcePluginBase` hooks (`alterProfileForm`, `validateProfileForm`, `processUserConf`,
  `alterJsResponse`) are **not** overridden — the plugin uses the empty base implementations.

## JS side — `imce_copylink.js` (library `imce_copylink/drupal.imce.copylink`)

Registered on IMCE's `init` event (`imce.bind('init', imce.copylinkInit = function () {...})`). It
re-checks `imce.hasPermission('copylink')` client-side, then adds a toolbar button:

```js
imce.addTbb('copylink', {
  title: Drupal.t('Copy Link'),
  permission: 'copylink',
  shortcut: 'Ctrl+Alt+C',
  icon: 'copylink',
  handler: function () { /* ... */ }
});
```

Handler behaviour:
- Picks the item to copy: with 0 selected it uses `imce.activeFolder` (the current directory); with 1
  selected it uses `imce.selection[0]`; with 2+ it shows "Only one link may be copied at a time" and
  returns.
- Before copying it calls `imce.validatePermissions([item], 'copylink', 'copylink')` (file-perm and
  subfolder-perm both `copylink`); on failure it shows "Copy link not authorized!".
- Copies **`item.getUrl()`** — the URL IMCE already computed for that item (absolute vs. relative is
  governed by IMCE's own *Common settings → Enable absolute URLs*; this module does not build the URL).
  The copy is done by putting the value in a hidden `<input>`, `.focus().select()`,
  `document.execCommand('copy')`, then removing the input and restoring focus. Requires a browser
  secure context (HTTPS/localhost).

## Icon — `imce_copylink.css` + `imce_copylink.svg`

The `icon: 'copylink'` maps to CSS class `.imce-ficon-copylink`, whose `:before` sets
`content: url(imce_copylink.svg)`.

## Extending

To add your own IMCE action, create `my_module/src/Plugin/ImcePlugin/MyThing.php` with an
`@ImcePlugin` annotation, extend `Drupal\imce\ImcePluginBase`, return your permission(s) from
`permissionInfo()`, and attach a JS library from `buildPage()` that calls `imce.addTbb(...)`. Rebuild
caches so the manager rediscovers the plugin. This module is a minimal, copyable example of that
pattern.
