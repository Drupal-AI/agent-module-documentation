# Configuration

VVJS has no admin settings page. Everything is configured through the **format
(style) options** of a view, in the Views UI.

## Turn it on for a view

1. Create or edit a view at **Structure → Views**.
2. Set **Format** to **Views Vanilla JavaScript Slideshow**.
3. Set **Show** to **Fields** — each result row becomes one slide.
4. For **hero mode**, the first field is the slide's background; place a field
   containing `<div class="vvjs-separator"></div>` between the background and the
   overlay content fields.
5. Open the format settings (the gear next to the format name), set the options
   below, and save.

## Option reference

### Timing and playback

- **Autoplay interval** — how long each slide shows, in milliseconds. Set to `0`
  to disable autoplay entirely.
- **Enable looping** — return to the first slide after the last.
- **Start index** — which slide (1-based) shows first.
- **Pause on hover** — pause autoplay while the mouse is over the slideshow.

### Navigation

- **Arrows** — previous/next arrow placement: none, on the sides (normal or big),
  or on top (normal or big).
- **Navigation** — the bottom navigation style: none, **dots**, or **numbers**.
- **Scrollable dots/numbers width** — a pixel width (0–700) for the dots/numbers
  strip when there are many slides.
- **Play/pause button**, **progress bar**, and **total slides counter** ("X of
  Y") — optional on-screen controls you can each toggle on.

### Animation and transitions

- **Animation** — the entrance animation for each slide: none, zoom, fade, or a
  directional slide (top/bottom/left/right).
- **Transition type** — how one slide replaces the next: **instant** or one of
  three crossfades (classic, staged, dynamic).
- **Transition duration** — crossfade length in milliseconds (200–2000).

### Interaction

- **Enable swipe** — touch/pointer swipe gestures (RTL-aware).
- **Enable keyboard** — arrow keys, Space, Home, and End.
- **Enable deep link** — give each slide a shareable URL hash (requires dots or
  numbers navigation).
- **Deep-link identifier** — the hash prefix, e.g. `gallery` produces `#gallery-3`
  (it's auto-lowercased with spaces turned to hyphens; reserved words are
  rejected).

### Hero mode

- **Hero slideshow** — enable hero mode, where the first field is the slide
  background and the remaining fields are overlaid content.
- **Overlay position** — one of twelve placements for the overlay content
  (full, middle, the four edges, and the four corners, plus top-middle and
  bottom-middle).
- **Overlay background color** — a hex color (`#RRGGBB`) for the overlay tint.
- **Overlay background opacity** — 0 to 1.

### Sizing and responsiveness

- **Minimum height** — the slideshow's minimum height (in vw, 1–200).
- **Max content width** — as a percentage (1–100).
- **Max width** — the maximum slideshow width in pixels (1–9999).
- **Available breakpoints** — which responsive breakpoint set to load: 576, 768,
  992, 1200, or 1400 px.

### Theming

- **Enable CSS** — load the bundled stylesheet. Turn it off if you want to style
  the slideshow entirely from your own theme.

Accessibility features — ARIA roles, the live-region announcer, keyboard
navigation, and automatic pausing when the tab is hidden, the slideshow is
scrolled off-screen, or the visitor prefers reduced motion — are always on and
need no configuration.

## Dynamic text with tokens

In a view's **header, footer, or empty** text area, tick **Use replacement tokens
from the first row**. Note that ordinary Twig tokens like `{{ title }}` don't work
here — use VVJS tokens instead:

| Instead of | Use |
|---|---|
| `{{ title }}` | `[vvjs:title]` |
| `{{ field_image }}` | `[vvjs:field_image]` |
| a plain-text value | append `:plain`, e.g. `[vvjs:title:plain]` |

Tokens read the **first row** of rendered fields only.

## Driving the slideshow from JavaScript (optional)

Custom code can control any slideshow through the `Drupal.vvjs.*` API, targeting a
slideshow by its deep-link identifier, a CSS selector, or an element reference —
for example:

```js
Drupal.vvjs.goToSlide('gallery', 3);   // jump to slide 3
Drupal.vvjs.nextSlide('gallery');      // advance
Drupal.vvjs.pause('gallery');          // pause autoplay
Drupal.vvjs.pauseAll();                // pause every slideshow on the page
Drupal.vvjs.getCurrentSlide('gallery');// → current slide number
```
