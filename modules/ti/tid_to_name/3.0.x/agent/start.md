# Term ID to Name — agent index

A one-function Twig extension. No config, permissions, schema, Drush, or routes (`configure` null);
no module dependencies beyond core taxonomy at runtime. Enable it and use the function in any template.

- **The `tn(tid)` Twig function — signature, behaviour, multilingual handling** →
  [api/twig.md](api/twig.md)

Key facts:
- Service `tid_to_name.twig_extension` (`src/TidToNameTwigExtension.php`), tagged `twig.extension`.
- `{{ tn(123) }}` → translated term name for the current language, or `''` when the TID is invalid
  (non-numeric / ≤ 0) or the term/translation is missing.
