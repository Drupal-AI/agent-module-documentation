# Asset libraries

`gsap.libraries.yml` defines GSAP core and every GreenSock plugin as a Drupal asset library,
so a theme or module attaches only what it needs. Attach as `gsap/<name>`.

## Library list

| Library (`gsap/<name>`) | JS file (jsDelivr CDN) |
|---|---|
| `gsap` | `gsap.min.js` (GSAP core) |
| `flip` | `Flip.min.js` |
| `scrolltrigger` | `ScrollTrigger.min.js` |
| `observer` | `Observer.min.js` |
| `scrollto` | `ScrollToPlugin.min.js` |
| `draggable` | `Draggable.min.js` |
| `easel` | `EaselPlugin.min.js` |
| `motionpath` | `MotionPathPlugin.min.js` |
| `pixi` | `PixiPlugin.min.js` |
| `text` | `TextPlugin.min.js` |
| `drawsvg` | `DrawSVGPlugin.min.js` |
| `gsdevtools` | `GSDevTools.min.js` |
| `inertia` | `InertiaPlugin.min.js` |
| `motionpathhelper` | `MotionPathHelper.min.js` |
| `morphsvg` | `MorphSVGPlugin.min.js` |
| `physics2d` | `Physics2DPlugin.min.js` |
| `physicsprops` | `PhysicsPropsPlugin.min.js` |
| `scrambletext` | `ScrambleTextPlugin.min.js` |
| `splittext` | `SplitText.min.js` |
| `easepack` | `EasePack.min.js` |
| `customease` | `CustomEase.min.js` |
| `custombounce` | `CustomBounce.min.js` |
| `customwiggle` | `CustomWiggle.min.js` |
| `animations` | local `js/animations.js` (deps: `core/drupalSettings`, `gsap/gsap`, `gsap/scrolltrigger`) |

- All CDN entries point at `https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/…` with
  `{ preprocess: false, minified: true }` and `version: VERSION`.
- The plugin libraries do **not** declare `gsap/gsap` as a dependency, so attach `gsap/gsap`
  alongside any plugin you use (`gsap.registerPlugin(...)` in your own JS).
- The `animations` library is the module's own runtime that applies `gsap` config entities;
  you normally do not attach it directly (see [../configure/animations.md](../configure/animations.md)).

## Declaring the dependency from a theme/module

In `MYTHEME.libraries.yml`:

```yaml
my_animations:
  js:
    js/my-animations.js: {}
  dependencies:
    - gsap/gsap
    - gsap/scrolltrigger
```

Attach it (e.g. in a preprocess/hook or `#attached`):

```php
$variables['#attached']['library'][] = 'mytheme/my_animations';
```

Then GSAP and the named plugins are available as globals in your JS:

```js
gsap.registerPlugin(ScrollTrigger);
gsap.to('.hero-title', { opacity: 1, duration: 1 });
```

## Serving GSAP locally instead of the CDN

The definitions are CDN-only out of the box. A `composer.libraries.json` ships that installs
`greensock/gsap 3.13.0` as a `drupal-library` (add it to the project's composer merge/installer
config). To point the libraries at the local copy, override them — e.g.
`hook_library_info_alter()` rewriting each `js` path, or a `libraries-override` block in a
theme's `.info.yml`.

## Custom libraries

Admins can register extra libraries at the settings form; each becomes `gsap/<key>` with a
dependency on `gsap/gsap`. These are built dynamically by `hook_library_info_build()` and are
**not** auto-attached — depend on them like any other library. See
[../configure/settings.md](../configure/settings.md) and [../hooks/hooks.md](../hooks/hooks.md).
