# Configuration

Configuration is provided by the **Inherit Link UI** submodule
(`inherit_link_ui`). If you enabled it, you manage inheritance rules — stored as
configuration entities — from a single admin screen. If you only enabled the main
module, there is no UI: you attach the library and apply the behaviour from code
instead, and this page does not apply.

## Open the management screen

Go to **`admin/config/inherit_link`**. You will see a list of existing
inheritance rules, including the defaults shipped by the submodule (for the
`.inherit-link` and `.node--view-mode-teaser` selectors). From here you can
**add**, **edit**, and **delete** rules.

## The options on a rule

Each inheritance rule describes one place where the whole-element click behaviour
should apply:

- **Main element** — the CSS selector for the container that should become
  clickable and that holds the link to inherit. For example,
  `.node--view-mode-teaser` to make every teaser clickable.
- **Link inside main element to inherit** — the selector for the actual link to
  extend, `a` by default. Set a more specific selector when the container has
  several links and you want a particular one to drive the whole-element click.
- **Prevent element** — an exception selector for elements that would otherwise
  match, so you can exclude them. For example `.cbox` to leave a colorbox/modal
  trigger alone.
- **Hide inherited click element** — hides the inherited link via JavaScript.
  The maintainers recommend hiding it with CSS instead where possible, but this
  option is available.
- **Auto detect external links and open in new window** — when the inherited
  link points to a different domain, this adds `target="_blank"` so external
  destinations open in a new window.

When there are multiple matching links inside a container, the behaviour extends
the **first** match only; the others continue to work as ordinary links.

## Save

Save the rule. Because the library attaches only when at least one rule exists,
your first saved rule is also what switches the feature on. Reload a page that
matches your **Main element** selector and confirm the whole element is clickable
while nested links still behave correctly.
