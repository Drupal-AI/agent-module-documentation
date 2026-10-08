# Configure Attach Library In Views

No settings form of its own (`configure` null). On install the module enables its display extender by
appending `library_in_views_display_extender` to `views.settings`'s `display_extenders`
(`hook_install`); `hook_uninstall` removes it. If the extender ever isn't active, re-save
`views.settings` with it in `display_extenders`.

## Set the library on a View display

1. Edit a View (`/admin/structure/views/view/<id>`).
2. In the display settings you'll find an **Attach Library** option (surfaced via the extender's
   `optionsSummary()`; the plugin is `no_ui` so it appears through the options summary, not as its
   own top-level row).
3. Enter library names in **`provider/library`** form — `provider` is the module/theme, `library`
   the entry in its `*.libraries.yml` (e.g. `mytheme/global`, `mymodule/slider`).
4. For multiple libraries, **comma-separate** them (`mymodule/a, mytheme/b`).
5. Set it on the **Default** display to have all displays inherit, or override per display.

## Where it is stored

```
views.view.<id>:
  display:
    <display_id>:
      display_options:
        display_extenders:
          library_in_views_display_extender:
            attach_library: 'mymodule/slider, mytheme/global'
```

Schema: `views.display_extender.library_in_views_display_extender` →
`attach_library.attach_library` (string).

## How it attaches (`ViewsAttachLibraryHook::viewsPreRender`)

`hook_views_pre_render()` reads the current display's
`display_options.display_extenders.library_in_views_display_extender.attach_library`, `explode(',')`,
`trim()`s each non-empty entry, and appends it:
`$view->element['#attached']['library'][] = trim($library);`. Drupal's asset system then loads the
library wherever the View renders. Library names are used verbatim — an invalid `provider/library`
simply won't resolve.
