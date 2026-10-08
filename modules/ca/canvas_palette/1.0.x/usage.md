A kit of ~39 styled Single Directory Components (SDC) for the Canvas / Experience Builder page builder, built around a design-wrapper "Section" component.

---

Canvas Palette gives site builders a ready-made library of front-end components — sections, columns, buttons, CTAs, heroes, media grids, galleries, carousels, sliders, tabs, accordions, sticky menus, quotes, stats, counters, countdowns, tiles, timelines, plus Webform and Views embeds — that are placed and edited visually inside the Canvas editor. Every component is a plain SDC (a `components/<id>/` folder with a `.component.yml`, `.twig` and optional co-located CSS/JS), so it renders on the published page and stays editable in the Canvas preview. The heart of the kit is the **Section** component: rather than bolting spacing and background controls onto every component, Section wraps any component (or group) and carries the margins, paddings, borders, background color/gradient/image/video/slideshow, overlay and a CSS grid/flex layout. To make all this usable, the module rewrites the Canvas component-inputs form — grouping props into collapsible `<details>`, drawing the box-model props as an inspector-style DOM box, attaching a Coloris color picker, turning bounded numbers into range sliders, and converting machine-name text fields (image style, webform, view) into selects. It also adds per-page "Page template" and "Background color" settings to Canvas pages, and ships `page--canvas--*.html.twig` templates other modules/themes can extend.

---

- Assemble landing pages visually in the Canvas editor from ready-made, front-end-rendered components.
- Wrap any component or group in a **Section** to control spacing, background and borders in one place.
- Edit a Section's margins/borders/paddings on an inspector-style DOM box where each field sits on the edge it controls.
- Give a Section a solid background color, a two-stop gradient, a background image, a background video, or a background image slideshow.
- Add a colour overlay with adjustable opacity over any Section background.
- Lay a Section out as a CSS grid (up to 6×6 cells) or a flexbox container with the usual justify/align/gap controls.
- Add call-to-action buttons with link, colours, hover colours, shape, size, alignment and a custom class (Basic button, CTA with up to two buttons).
- Build a hero banner with title prefix, image, overlay and up to two buttons.
- Open an accessible modal dialog from a styled trigger button (custom, no third-party library).
- Open an existing Webform inside a popup dialog from a styled button (Webform Popup).
- Embed an existing Webform on the page by picking it from a select of the site's forms.
- Embed an existing View + display, with optional slash-separated contextual filter arguments, access-checked before rendering.
- Show a single image with caption, link and optional GLightbox lightbox; auto-fill Width/Height from the picked image's intrinsic size.
- Lay out image grids (Images) and lightbox galleries (Image Gallery), with a shared image style and lightbox default that each item can override.
- Show single videos with an uploadable poster, and video galleries with a play overlay for YouTube/Vimeo/MP4/local media (GLightbox).
- Build collapsible accordions and no-jQuery tabbed content in several styles.
- Add sliders and carousels (Splide and tiny-slider) with autoplay, responsive per-breakpoint item counts and per-slide image overrides.
- Add an on-page sticky navigation menu with links and sublinks.
- Present pull quotes, stat rows, scroll-triggered count-up numbers, animated countdowns, linked tile grids and vertical timelines.
- Pick per-Canvas-page a whole-page template (Full width, Without Header, Without Header/Footer, Colorful, …) that swaps `page.html.twig`.
- Set a per-page background colour with an inline colour picker, painted onto the whole page.
- Extend the kit from your own module or theme: add component styles, register extra page templates via `hook_canvas_palette_page_templates_alter()`, or override a shipped `page--canvas--*.html.twig`.
