# slick — agent start

Responsive carousel/slider/gallery built on the Slick (or Accessible Slick) JS library +
Blazy. Core concept: reusable **optionset** config entities (`slick.optionset.*`) applied via
field formatters (`slick_image`, `slick_media`, `slick_file`, `slick_text`) or a text filter
(`slick_filter`). Admin UI lives in the **slick_ui** submodule. Needs the Slick JS lib under
`/libraries`. Sitewide settings: `/admin/config/media/slick/ui`.

- Optionsets, field formatters, sitewide settings → [configure/optionsets.md](configure/optionsets.md)
- Register skins (SlickSkin plugin type) → [plugins/skins.md](plugins/skins.md)
- Build a carousel in code (slick.manager service) → [api/api.md](api/api.md)
- Alter options/optionsets/settings via hooks → [hooks/hooks.md](hooks/hooks.md)
- Theme hooks & Twig templates → [theming/theming.md](theming/theming.md)
