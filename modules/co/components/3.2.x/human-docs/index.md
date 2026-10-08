# Components — manual setup guide

**Components** (`components`) lets themes and modules register arbitrary folders
of Twig templates as named **Twig namespaces** — so you can reference a template
as `@mynamespace/box.twig` from anywhere. Out of the box Drupal only exposes each
extension's own namespace pointing at its `templates/` folder; Components removes
that restriction so you can organize a component library however you like and
point namespaces wherever you want. It depends only on Drupal core.

Alongside the namespaces, it adds a small set of Twig helpers for working with
render arrays directly inside templates: a `template()` **function** that renders
a theme hook or template as a render array (with full preprocessing and
theme-suggestion support), and `set`, `add`, and `recursive_merge` **filters**
for reading and modifying deeply-nested render-array values. Namespaces can be
adjusted at runtime with `hook_components_namespaces_alter()`, and
`hook_protected_twig_namespaces_alter()` controls which namespaces are allowed to
be redefined.

This is a **developer/theming building block**, not a site-builder feature. It
has **no admin UI, no permissions, and no configuration form** — everything is
declared in code, in a theme's or module's `.info.yml`. It works the moment you
enable it; there is nothing to click. It's a foundational piece for
component-driven development, design systems, and pattern libraries, and it
complements (rather than replaces) core Single-Directory Components.

This guide is written for a **human** setting things up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Components has no settings page. You use it entirely from code, as
described below.

## How to use it

### Register a namespace in `.info.yml`

In any theme's or module's `<name>.info.yml`, add a `components: namespaces:` map.
Paths are relative to the extension (the theme or module):

```yaml
components:
  namespaces:
    fusion:
      - components/fusion
```

You can list multiple paths under one namespace; they are searched in order. The
module's own default namespace is `components`, and a theme may reuse it because
the module sets `allow_default_namespace_reuse: true`. Rebuild caches after
editing `.info.yml`.

### Reference templates by namespace

Once registered, reference the template as `@fusion/box.twig` from any Twig file —
via `include`, `embed`, `extends`, or the `template()` function below:

```twig
{% include '@fusion/box.twig' with { title: 'Hello' } %}
```

### Twig `template()` function

`template(name, key=value, ...)` returns a **render array** for a template name or
theme hook, after Drupal's normal preprocessing and theme suggestions. Named
arguments become `#key` variables. Pass a bare template name or theme hook —
namespaced (`@…`) names are not allowed here:

```twig
{% set list = template('item-list.html.twig',
     title = 'Animals', items = ['lemur', 'weasel']) %}
```

### Twig filters (operate on render arrays)

- **`recursive_merge(array)`** — merges the given array into the element:
  `{{ form|recursive_merge({'element': {'#attributes': {'placeholder': 'Label'}}}) }}`
- **`set(at, value)`** — replaces a deeply-nested value by dotted path:
  `{{ form|set('element.#attributes.placeholder', 'Label') }}`
- **`add(at, value)` / `add(at, values=[...])`** — appends to a nested key (for
  example adding a CSS class):
  `{{ form|add('element.#attributes.class', 'new-class') }}`

### Alter namespaces from a module (optional)

Two hooks let a module adjust namespaces at runtime —
`hook_components_namespaces_alter()` to add or change namespace paths for the
active theme, and `hook_protected_twig_namespaces_alter()` to unprotect
namespaces so they can be redefined. See the sibling
[`agent/`](../agent/start.md) docs for hook signatures and examples.
