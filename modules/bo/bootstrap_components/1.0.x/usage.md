Bootstrap Components is a lightweight library of 21 Bootstrap 5 Single Directory Components (SDC) plus a `to_attributes` Twig helper for Drupal 10/11.

---

Bootstrap Components provides a slim, dependency-free set of Bootstrap 5 UI components implemented as Drupal Single Directory Components (SDC). Each component (accordion, alert, blockquote, breadcrumb, button, card and card sub-parts, card group, card overlay, carousel, close button, dropdown, modal, nav, navbar, offcanvas, pagination, tooltip) is defined by a `*.component.yml` metadata file with typed props, named slots and variants, and a matching `*.twig` template that emits standard Bootstrap 5 markup. A single Twig extension (`AttributesToolTwigExtension`) registers a `to_attributes` filter and function that normalizes a space-separated class string, a sequential class array, or an associative attribute array into a `Drupal\Core\Template\Attribute` object so templates can reliably chain `.addClass()` / `.setAttribute()`. The module ships no routes, permissions, config, entities, blocks or PHP services beyond that Twig extension; components are pure theming constructs invoked from Twig, from other components (`include`), from the `component` render element, or from any SDC consumer (Layout Builder, UI Patterns, Storybook-style story consumers). It assumes Bootstrap 5 CSS/JS and Popper are already loaded by the active theme; only the accordion and carousel add small behavior JS via `libraryOverrides`.

---

- Add Bootstrap 5 alerts, cards, modals and buttons to a theme without pulling in a large component framework.
- Render an SDC from Twig via the `component` render element: `#type: component`, `#component: 'bootstrap_components:button'`, `#props: {...}`.
- Include one component inside another Twig template with `include('bootstrap_components:modal', {...})`.
- Build a modal dialog with title/body/footer slots plus centered, scrollable, static-backdrop, animation and fullscreen options.
- Display contextual alerts (primary/success/danger/warning/info/light/dark) with an optional heading and dismissible close button.
- Place styled buttons or button-styled links with size (`__sm`/`__lg`), outline and disabled variants.
- Compose cards using the `card`, `card_body`, `card_group`, `card_overlay` components with image/header/content/footer slots and horizontal layout.
- Add an image carousel with autoplay, captions and per-slide `carousel_item` children.
- Build collapsible accordions from `accordion` + `accordion_item`, optionally keeping multiple items open.
- Add a responsive navbar with brand text/image, color schemes, offcanvas and collapsible variants, plus `navbar_nav` menus.
- Render tab/pill navigation with the `nav` component (center/end/vertical alignment, custom content).
- Add pagination controls with sizing and alignment variants.
- Add dropdown menus with split buttons, directions, dark mode, headers, dividers and responsive alignment.
- Add an offcanvas panel with placement, backdrop and body-scrolling options.
- Add breadcrumbs, blockquotes with source alignment, tooltips and standalone close buttons.
- Normalize mixed attribute input in custom templates: `{{ 'alpha beta'|to_attributes }}`, `{{ ['a','b']|to_attributes }}`, or `{{ {class:['a'], id:'x'}|to_attributes }}`.
- Pass a normalized Attribute into a component slot/prop so downstream `create_attribute` / `.addClass()` calls stay consistent.
- Override or extend any component in a sub-theme (each `.component.yml` exposes a `libraryOverrides` hook for css/js).
- Preview components with the bundled `stories/*.story.yml` fixtures in an SDC story/preview consumer.
- Use components as building blocks inside Layout Builder or UI Patterns-style page building.
- Provide a smaller, easier-to-audit alternative to `ui_suite_bootstrap` when you only need core Bootstrap widgets.
- Keep markup consistent across a site by centralizing Bootstrap component structure in reusable SDC.
- Swap Bootstrap variants (color, size, outline) per instance via props rather than hand-writing class strings.
