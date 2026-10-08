# Configuration

TVI works by intercepting the taxonomy term page and asking: *for this term, which
View should render it?* You answer that question at three levels — per term, per
vocabulary, or globally — and TVI resolves any conflict by a fixed precedence order.
All three levels are stored as configuration, so they export and deploy with
`drush config:export`.

## Prepare a View to use

TVI renders a View you already have. A convenient starting point is to **clone the
core `taxonomy_term` View** (its arguments are identical to what TVI passes), then
customize it. When building your own, make the View **argument‑aware** by adding a
**Taxonomy term ID (with depth)** contextual filter (and, if you want depth control, a
**Term ID depth modifier**) — TVI passes the term ID (and depth) to the View as
contextual arguments. The module recommends using a **block display** rather than a
page display for the View you point term pages at.

## Global default — `/admin/config/user-interface/tvi`

With the **Administer taxonomy views integrator** permission, open **Configuration →
User interface → Taxonomy Views Integrator**. Here you set the site‑wide default:

- **Disable default view** — if ticked, render **no** View by default, letting term
  pages fall through to plain taxonomy rendering.
- **Enable override** — turn on the global override so the View below is used for all
  term pages that don't have a more specific assignment.
- **View** and **View display** — the machine name of the View and the display to use.
  The defaults are the core `taxonomy_term` View, `page_1` display.

## Per vocabulary

Edit a vocabulary (**Structure → Taxonomy → *(vocabulary)* → Edit**). If you have the
**"Define view for vocabulary *(name)*"** permission, a *Taxonomy Views Integrator*
fieldset appears with:

- **Enable override** — use the View below for all terms in this vocabulary.
- **View** / **View display** — which View and display to render.
- **Inherit settings** — let child terms (and terms in the vocabulary) inherit this
  assignment.
- **Pass arguments** — pass all trailing URL arguments (after `/taxonomy/term/`) to the
  View; if off, the View only receives the term ID and term‑ID‑with‑depth.

## Per term

Edit a term. If you have the **"Define view for terms in *(vocabulary)*"** permission,
the same *Taxonomy Views Integrator* fieldset appears on the term form, with the same
fields as the vocabulary level (enable override, View, display, inherit, pass
arguments). A per‑term assignment is the most specific and wins over the others.

> **Note:** a per‑term or per‑vocabulary record is only created when you enable its
> override; unchecking the override deletes the record. TVI also cleans these records
> up automatically when a term or vocabulary is deleted.

## Precedence — which View wins

For each term, TVI resolves the View to render in this order (highest wins):

1. **Per‑term override** — the term's own assignment, if its override is enabled.
2. **Inherited override** — otherwise, a vocabulary override (with *inherit settings*
   on), then any parent‑term override (with *inherit settings* on).
3. **Global override** — otherwise, the global settings, if the global override is on.
4. **Core default** — otherwise, the core `taxonomy_term` / `page_1` View — unless
   **Disable default view** is set, in which case term pages fall back to plain
   taxonomy rendering.

If the resolved View is missing or disabled, TVI safely falls back to the default core
term view builder.

## Delegating access

The per‑vocabulary permissions let you hand specific editors control without giving
them the global settings form. For example:

```bash
drush role:perm:add editor 'define view for terms in tags'
```

grants the *editor* role the right to set a View on individual terms in the "tags"
vocabulary, while the global **Administer taxonomy views integrator** permission stays
restricted to administrators.
