# Twig Attributes — agent index

Adds an `add_attr` / `with_attr` Twig filter that sets HTML attributes on elements inside a
render array from a template — no override or preprocess needed. Also augments a few core
field templates so they accept attributes. No config, permissions, schema, or Drush.

- **Filter signature, arguments, merge/override behavior, supported core templates, examples**
  → [api/filters.md](api/filters.md)

Key facts:
- Twig extension `src/TwigExtension.php` (priority 100); filters `add_attr` and `with_attr`
  (alias) both call `addAttributes()`.
- Core templates wired up in `twig_attributes.module`: `image_formatter` &
  `responsive_image_formatter` (`image_attributes`, `link_attributes`), `file_link`
  (`link_attributes`).
