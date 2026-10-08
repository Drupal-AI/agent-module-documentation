# Configuration

GSAP is configured in two places, both behind the single **Administer GSAP**
(`administer gsap`) permission: a **settings form** for platform‑wide options,
and an **animation collection** where each animation is created as a
configuration entity.

## The settings form

Go to **Configuration → Content authoring → GSAP**
(`/admin/config/content/gsap`). This is where you manage platform‑level options —
in particular which GSAP plugins are loaded and how. The guiding principle is
**on‑demand loading**: enable only the plugins a page actually needs so you don't
ship the entire GreenSock toolkit on every request. Save the form when you are
done; changes take effect on the next page load.

## The animation collection

Go to **Structure → GSAP** (`/admin/structure/gsap`) to see every animation you
have defined. This page offers the standard entity actions:

- **Add** — create a new animation.
- **Edit** — change an existing animation.
- **Delete** — remove one.

Because animations are configuration entities, they are exportable with your
site's configuration and move cleanly between environments.

### Creating an animation

Click **Add** and describe the animation you want. In broad terms an animation
entity captures:

- **A target** — the CSS selector on the page the animation should apply to.
- **An animation type** — a `to`, `from`, or `scrollTrigger` animation, matching
  GSAP's own vocabulary. `scrollTrigger` is the common case: the element animates
  as it enters the viewport.
- **The animation properties** — the values GSAP tweens (position, opacity,
  scale, and so on), along with timing such as duration, delay, and easing.

The front‑end script reads these entities and applies them with GSAP and
ScrollTrigger already attached, so a scroll‑triggered animation works with no
extra code. For the exact meaning of each GSAP property and easing curve, keep
the [GSAP documentation](https://greensock.com/docs/) alongside you — this module
exposes GSAP's own options rather than inventing its own.

## Attaching plugins from a theme or custom module

Site builders can do everything from the UI above, but front‑end developers can
also attach individual GSAP libraries directly. Declare the dependency in your
theme or module's `*.libraries.yml`, for example:

```yaml
my-custom-animations:
  js:
    js/my-animations.js: {}
  dependencies:
    - gsap/scrolltrigger
```

The libraries available to attach individually include `gsap`, `scrolltrigger`,
`flip`, `observer`, `scrollto`, `draggable`, `easel`, `motionpath`, `pixi`,
`text`, `drawsvg`, `gsdevtools`, `inertia`, `motionpathhelper`, `morphsvg`,
`physics2d`, `physicsprops`, `scrambletext`, `splittext`, `easepack`,
`customease`, `custombounce`, and `customwiggle`.

> **Licensing reminder:** MorphSVG, SplitText, DrawSVG, ScrambleText, Inertia and
> GSDevTools are GreenSock's paid "Club" plugins. Confirm you are licensed to use
> them before relying on them, regardless of whether the CDN URL happens to
> resolve.
