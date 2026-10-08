A developer toolkit that generates and flushes Drupal image styles in bulk from YAML derivative-definition files, driven by Drush commands and a Twig helper.

---

Image Styles Builder is a code-first abstraction for managing image styles. Instead of clicking through the *Image styles* admin UI, a developer declares the desired styles and their effects in a `*.image_styles_builder_derivatives.yml` file shipped inside any enabled module. A custom YAML-discovery plugin manager (`DerivativeManager`) finds every such file, validates it, and turns each declared style into a value object. Two Drush commands then act on that collection: `isb:gen` creates the corresponding core `image_style` config entities (skipping any that already exist), and `isb:flush` deletes them again — giving a repeatable generate/rollback workflow that lives in version control. Styles are named `<suffix>_<style-id>` and each carries an ordered list of core image effects (scale, scale_and_crop, image_convert, crop, desaturate, rotate, etc.) with `width`, `height`, and arbitrary effect `data`. A Twig function `isb_image_styles('<derivative_id>')` returns the generated style machine names for a derivative so front-end templates can reference the whole collection without hard-coding names. The module has no UI, no routes, no permissions, and no configuration form — it is meant to be required (often as a dev dependency) and operated from the command line. It depends only on core `image`.

---

- Define dozens of image styles at once in a single YAML file instead of creating each by hand in the admin UI.
- Keep image-style definitions in version control alongside the module that needs them.
- Hand a front-end team a documented list of required styles and generate them all with one command.
- Run `drush isb:gen` in a build/deploy pipeline to provision image styles on a fresh environment.
- Roll back a batch of generated styles with `drush isb:flush` when a design changes.
- Interactively pick a single derivative to generate or flush from the Drush prompt (or choose "All").
- Group related styles under a named derivative (e.g. `default`, `hero`, `thumbnails`) with a shared `suffix`.
- Produce responsive-image candidate styles (multiple widths of the same aspect ratio) for a `responsive_image` mapping.
- Generate WebP variants by chaining a `scale_and_crop` effect with an `image_convert` effect (`extension: webp`).
- Chain multiple effects on one style (e.g. `scale_and_crop` then `image_scale`) in declared order.
- Create art-directed crops per aspect ratio (9:2, 16:10, 1:1, etc.) for different breakpoints.
- Skip re-creating styles that already exist so `isb:gen` is safe to re-run idempotently.
- Fetch a whole derivative's generated style names in Twig via `isb_image_styles('default')` for use in templates or preprocess.
- Avoid hard-coding image-style machine names in templates by resolving them through the derivative id.
- Standardize image-style naming across projects using a consistent `<suffix>_<id>` convention.
- Let multiple modules each ship their own derivatives file; the manager discovers and merges them all.
- Document image-style intent (label, suffix, per-style effects) in a human-readable YAML file.
- Use `image_convert` to enforce an output format for all derivatives of a style.
- Bootstrap a new project's image styles from a shared internal "starter" derivatives file.
- Regenerate styles after they were accidentally deleted, restoring them from the YAML source of truth.
- Provide QA/design with a reproducible set of image styles that matches the design system.
- Install as a dev dependency for local scaffolding, then export the generated styles as normal Drupal config.
