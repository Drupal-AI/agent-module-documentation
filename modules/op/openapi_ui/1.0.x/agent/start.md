<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# openapi_ui — agent start

**Framework only.** Defines the `openapi_ui` plugin type + an `openapi_ui` render element for
embedding an interactive OpenAPI/Swagger explorer. Ships **no** renderer plugins itself — the
concrete UIs live in separate projects `openapi_ui_swagger` and `openapi_ui_redoc` (neither
installed here). Enabling `openapi_ui` alone therefore registers **zero** renderer plugins.
No config form (`configure` = null), no permissions, no Drush, no config schema, no dependencies.

- Write a renderer plugin (the `openapi_ui` plugin type) → [plugins/renderers.md](plugins/renderers.md)
- Embed docs with the `openapi_ui` render element, route param converter & alter hook → [api/render-element.md](api/render-element.md)

Key names: manager service `plugin.manager.openapi_ui.ui`; discovery dir `Plugin/openapi_ui/OpenApiUi`;
annotation `@OpenApiUi(id, label)`; interface `Drupal\openapi_ui\Plugin\openapi_ui\OpenApiUiInterface`
(`build()`); base class `…\Plugin\openapi_ui\OpenApiUi`; render element `#type => 'openapi_ui'`;
param-converter service `openapi_ui.parm_parser` (param type `openapi_ui`); alter hook `hook_openapi_ui_alter`.
