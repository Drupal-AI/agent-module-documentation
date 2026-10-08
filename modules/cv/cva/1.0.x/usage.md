CVA exposes Twig's `html_cva` function (from `twig/html-extra`) inside Drupal templates so you can build reusable, variant-driven component class lists — the Class Variance Authority pattern — right in your `.html.twig` files.

---

The module does one focused thing: it registers the `html_cva` Twig function (shipped by the `twig/html-extra` package, Twig 3.12+) as a Drupal Twig extension, and it teaches Drupal's Twig sandbox to allow method calls on the `Twig\Extra\Html\Cva` objects that function returns. In a template you call `html_cva(base: ..., variants: {...})` to define a component, then call `.apply({...}, extra_classes)` on the result to compute the final `class` string for a given set of variant selections. It supports a `base` class, named `variants` (each a map of option → classes), `default_variant` values for options you do not pass, and `compound_variants` that add extra classes only when several options match together. Because the returned object is a real PHP object, the module also swaps in a `CvaTwigEnvironment` and a `CvaSandboxPolicy` so calling `.apply()` is not blocked by Drupal's Twig sandbox. It pairs naturally with Tailwind CSS, and with the optional `tailwind_merge` filter (from `tales-from-a-dev/twig-tailwind-extra`) to resolve conflicting utility classes. There is no admin UI, no configuration, no permissions, and no Drush commands — you enable it and use the function in templates.

---

- Build a reusable button component whose colour and size are selected per-render via `variants`.
- Generate Tailwind CSS class lists for alerts, badges, cards, and other UI atoms from a single Twig definition.
- Keep variant-to-class mapping in one place instead of scattering long `class="..."` ternaries across templates.
- Apply a `base` set of classes shared by every instance of a component.
- Switch a component's colour scheme (e.g. `blue`/`red`/`green`) by passing a single `color` variant value.
- Switch a component's size (e.g. `sm`/`md`/`lg`) by passing a single `size` variant value.
- Provide sensible fallbacks with `default_variant` so templates can omit options that rarely change.
- Add extra classes only when two options coincide using `compound_variants` (e.g. red + large ⇒ `font-bold`).
- Compose a component's variant classes with per-instance extra classes passed as the second `apply()` argument.
- Merge in dynamic classes coming from Drupal's `attributes`/`class` render variables.
- De-duplicate conflicting Tailwind utilities by chaining the `tailwind_merge` filter after `apply()`.
- Drive Single Directory Component (SDC) or theme-template styling from a shared variant vocabulary.
- Standardise a design system's tokens (colours, spacing, radii) as named Twig variants.
- Render status pills whose colour maps to a field value (e.g. workflow state ⇒ colour variant).
- Style Views fields or rows conditionally by mapping a value to a variant name.
- Build responsive component variants by naming breakpoints as variant options.
- Replace bespoke preprocess PHP that concatenates class strings with declarative Twig variants.
- Share one component definition across multiple templates by defining it in an included/embedded partial.
- Prototype Tailwind component libraries quickly without leaving the template layer.
- Keep markup and its class logic co-located for easier front-end review.
- Map theme settings or block configuration values onto component variants.
- Produce consistent class ordering (base, then variants, then compounds) for predictable diffs.
- Let front-end developers adjust component styling without touching PHP or clearing plugin caches.
- Enforce a closed set of allowed variant values, avoiding typo-prone free-form class strings.
- Combine with `html_classes` and other `twig/html-extra` helpers for richer class handling.
