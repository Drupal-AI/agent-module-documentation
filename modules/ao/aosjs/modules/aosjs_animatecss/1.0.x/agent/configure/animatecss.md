# AOS JS + AnimateCSS — how it works

No config, routes, or permissions of its own. It hooks the AOS JS UI admin forms.

## Route subscriber (`src/Routing/RouteSubscriber.php`)

Service `aosjs.route_subscriber` (tagged `event_subscriber`). In `alterRoutes()` it overrides the
`_form` default of three existing `aosjs_ui` routes:

| Route | New form class |
|---|---|
| `aosjs.settings` | `Drupal\aosjs_animatecss\Form\AosJsAnimateCssSettings` |
| `aosjs.add` | `Drupal\aosjs_animatecss\Form\AosJsAnimateCssForm` |
| `aosjs.edit` | `Drupal\aosjs_animatecss\Form\AosJsAnimateCssForm` |

## Form behavior (subclasses of the `aosjs_ui` forms)

Both call `parent::buildForm()` then adjust the animation UI based on `aosjs.settings`:

- If `options.library == 'animate'`:
  - `form['options']['animation']['#options'] = animatecss_animation_options()` (Animate.css catalog, from the `animatecss` module).
  - Forces AOS v3 `use_class_names` = TRUE and disabled.
  - Sets `animated_class_name` to `animated` when `animatecss.settings:compat` is true, else `animate__animated` (disabled field).
- Otherwise: falls back to `aosjs_animation_options()` and `aos-animate` class.

`AosJsAnimateCssSettings` also wires an AJAX wrapper (`#animation-options`) so the animation dropdown re-renders when the library selector changes.

## Install / uninstall (`aosjs_animatecss.install`)

- `hook_install()`: status message — enable AOS **v3** then choose Animate.css as the default library on the AOS settings page.
- `hook_uninstall()` (named `aosjs_animatecss_uninstall`): if `aosjs.settings:options.library == 'animate'`, restores AOS defaults — `library=aos`, `offset=120`, `delay=0`, `duration=400`, `easing=ease`, `advanced.animatedClassName=aos-animate`, `advanced.useClassNames=FALSE`.

## Requirement

Needs the separate `animatecss` contrib project (dependency `animatecss:animatecss`) for `animatecss_animation_options()` and `animatecss.settings`. Enable with `ddev drush en aosjs_animatecss -y` (pulls in `aosjs_ui` + `animatecss`).
