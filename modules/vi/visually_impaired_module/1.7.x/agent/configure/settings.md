# Configure Visually Impaired Support

## Settings form

- Route `visually_impaired_module.settings` → `/admin/config/user-interface/visually_impaired_module`,
  permission `administer site configuration` (`VISettingsForm`, a `ConfigFormBase`).
- One field: **Select Visually Impaired Theme** — a `select` of all *enabled* themes
  (`theme_handler->listInfo()`, filtered to `status`). The chosen machine name is saved to config.

## Config

```
visually_impaired_module.visually_impaired_module.settings:
  visually_impaired_theme: <theme_machine_name>   # e.g. 'visually_impaired_theme' or 'olivero'
```

Note the doubled segment in the config name (`visually_impaired_module.visually_impaired_module.settings`).
There is **no config/schema** shipped for it. Set it with Drush:

```bash
ddev drush config:set visually_impaired_module.visually_impaired_module.settings visually_impaired_theme olivero -y
```

## The switch (blocks + cookie)

Place either block via Block layout (`/admin/structure/block`):

| Block id | Class | Button does | Cookie set |
|---|---|---|---|
| `visually_impaired_block` | `VIBlock` → `VISpecialForm` | "Visually impaired site version" | `visually_impaired=on` |
| `normal_block` | `NormalBlock` → `VINormalForm` | "Normal site version" | `visually_impaired=off` |

Both blocks expose one config option **Block style** (`block_style` radios): `0` = Text, `1` = Image
(default `1`). It only toggles a CSS class (`vi-special-block-image`/`-text`,
`vi-normal-block-image`/`-text`) on the rendered form. Cookies are set with
`setcookie(name, value, 0, '/')` — a host-wide session cookie, no expiry, not `HttpOnly`/`Secure`.

## Theme negotiation

`Theme\ThemeNegotiator` (service `theme.negotiator.visually_impaired_module`, tagged priority 10):

- `applies()` returns TRUE for every route.
- `determineActiveTheme()` returns the configured `visually_impaired_theme` **only when**
  `$_COOKIE['visually_impaired'] === 'on'` **and** the route is **not** an admin route
  (`router.admin_context->isAdminRoute()`). Otherwise it returns nothing and Drupal falls back to
  the default theme. So admin pages always keep the admin/default theme.

## Page-cache variation

`VisuallyImpairedModuleServiceProvider::alter()` swaps the class of core's
`http_middleware.page_cache` to `StackMiddleware\MyCache`. `MyCache::getCacheId()` builds the
anonymous page-cache id from `<cookie value> : <scheme+host+request-uri> : <request format>`, so the
normal and visually-impaired renderings of a URL are cached separately. This override replaces core's
default cache-id logic entirely (it keys on the raw cookie plus URL rather than core's cache contexts).

## Page attachment

`hook_page_attachments` always attaches the `visually_impaired_module/visually_impaired_module`
library (`css/visually_impaired_module.css` plus jQuery/cookie deps) on every page.
