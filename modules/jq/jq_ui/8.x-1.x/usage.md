<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
jQuery UI provides the jQuery UI library.

---

jQuery UI (jq_ui) **provides the jQuery UI library** — which core removed from Drupal — as an asset
library, so modules/themes that still depend on jQuery UI components can attach it. It ships the `jquery_ui`
library, in the jQuery UI package.

Use it as a compatibility dependency for code that still needs jQuery UI. It is a developer/library feature; it
provides the asset library only and has no content or access role. Note jQuery UI is **no longer actively
maintained** upstream — prefer modern alternatives for new code and use this only for legacy compatibility.
Depend on it and attach the library.

---

- Provide the jQuery UI library.
- Serve modules that still need jQuery UI.
- Attach jQuery UI components.
- Ship the jquery_ui library.
- Replace core's removed library.
- Provide an asset library.
- KNOW jQuery UI is no longer actively maintained.
- Prefer modern alternatives for new code.
- Use it for legacy compatibility.
- Have no content/access role.
- Attach the library.
- Handle jQuery UI.
- Provide the library.
- Configure nothing (library).
- Add jQuery UI.
- Depend on it.
- Handle the asset.
- Use jQuery UI.
- Provide compatibility.
- Provide jQuery UI.
