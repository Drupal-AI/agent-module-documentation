# Configuration

UIkit Components adds an admin settings page for its components. Note that most of
the module's power is meant for *theme developers* — the render elements and the
documented API in `uikit_components.api.php` — so the settings page is a small
part of the picture.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Open the module's settings page from the admin menu — it is registered as the
   module's `configure` route (`uikit_components.admin`) and appears with a local
   task link in the UIkit administration area.

The page holds the module-level options for how its components behave. Because
these options track the version of the module and the UIkit base theme you are
running, review each field on the form and adjust it to match how you want menus
and other components rendered (for example, whether menus render as standard
navigation, as off-canvas menus, or as dropdowns).

Save the form with **Save configuration**; changes apply on the next page load.

## Where the real work happens

For anything beyond the settings page, the module is driven from code rather than
the UI:

- **Rendering a menu as a UIkit component** is done in your theme's templates and
  preprocess code using the render elements and helpers this module provides.
- **Extending or integrating** with the module is documented in
  `uikit_components.api.php` inside the module directory — read it before writing
  theme code, since that is where the intended extension points live.

If you are only site-building (not theming), enabling the module and setting your
UIkit theme is usually all you need; the settings page is there for fine-tuning.
