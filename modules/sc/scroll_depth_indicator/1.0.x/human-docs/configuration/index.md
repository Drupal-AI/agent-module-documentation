# Configuration

Scroll Depth Indicator provides a settings form where you decide how the indicator
is attached to the page and where it should appear. Sensible defaults are provided,
so you only need to change these if the defaults do not suit your theme.

## Element placement

Choose **how** the indicator is attached to the page. The options are:

- **Element** *(default)* — attach the indicator directly to a specific HTML
  element.
- **Class** — target elements using a CSS class.
- **ID** — attach to a unique ID in the DOM.

## Custom selector

Specify the **exact selector** (the element, class or ID) where the indicator
should be placed. The default selector is the **Header**, which keeps the indicator
visible without obstructing page content. Change this if your theme's markup calls
for a different anchor point.

## Content-type restriction

Control **where** the indicator appears by selecting the specific content types it
should show on (for example Articles, Blog Posts or News). Limiting it to the
content types that actually need it avoids loading the indicator on pages where it
adds nothing, which keeps things relevant and performant.

## Styling

The indicator works across any Drupal theme and ships with CSS you can override in
your own theme to match your brand's colours and style. Because it reads its
configuration through Drupal's config API and only appends itself where needed, its
impact on page load is minimal.
