<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bamboo Twig - Path & Url adds a single Twig function, `bamboo_path_system`, that resolves the filesystem path of a module, theme, profile, theme engine, or core.

---

This submodule of Bamboo Twig registers `bamboo_path_system(type, name)` on the service `bamboo_twig_path.twig.path`, wrapping Drupal's extension path resolver (`extension.path.resolver->getPath()`). The `type` is one of `core`, `profile`, `module`, `theme`, or `theme_engine`, and `name` is the item's machine name (ignored for `core`). It returns the path relative to the Drupal root, or an empty string when the item is not found — handy for referencing a shipped asset by module or theme path from within a template.

---

- Reference a module-shipped image by path (`bamboo_path_system('module', 'my_module')`).
- Build an asset URL for a theme file (`bamboo_path_system('theme', 'olivero')`).
- Point to a JS or CSS file bundled with a module from a template.
- Locate a profile's path for including a shipped resource.
- Reference the core directory path in a template.
- Construct a relative `<img src>` to a module logo or icon.
- Link to a static SVG shipped inside a theme.
- Avoid hard-coding `modules/contrib/...` paths in markup.
- Resolve a theme engine path when needed.
- Build a path to a template-local partial asset.
- Reference a shipped font file by theme path.
- Point a background-image style to a theme asset path.
- Keep asset references correct regardless of where the module is installed.
- Locate a module's `images/` directory for an inline preview.
- Compose a documentation link relative to a module's path.
- Reference a demo/sample file that ships with a module.
- Build a favicon or manifest path from the active theme.
- Resolve paths dynamically instead of assuming an install location.
