# Animate On Scroll — agent index

Thin integration of the third-party **AOS** JS library. Loads AOS on every page and runs `AOS.init()`;
you animate elements by adding `data-aos` HTML attributes. No config UI (`configure` null), no
permissions, no plugins, no Drush, no config schema, no Drupal dependencies.

- **Library requirement (manual `/libraries/aos` install), how attachment/init works, the `data-aos`
  attributes** → [theming/library.md](theming/library.md)

Key facts:
- `hook_page_attachments` attaches `animate_on_scroll/animate_on_scroll_lib` to all pages.
- Library loads `/libraries/aos/dist/aos.js` + `/libraries/aos/dist/aos.css` (deps: `core/jquery`,
  `core/drupal`, `core/drupalSettings`) and `js/script.js` (`Drupal.behaviors.aos` → `AOS.init()`).
- The AOS library is NOT bundled; download it into `/libraries/aos`. `hook_requirements` flags it on
  the status report if `libraries/aos/dist/aos.css` is missing.
