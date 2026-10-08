<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTML Transformer (html_transformer) — agent index
**Plugin-based API that mutates HTML via a pipeline of `DOMDocument` transformer plugins.**

- **Version:** 2.0.x
- **Core:** ^10 || ^11
- **Service:** `Drupal\html_transformer\HtmlTransformerInterface` — `transform($doc, ?plugins, ?logger)`
- **Plugins:** `#[HtmlTransformer('id')]` + `HtmlTransformerPluginBase::transform(\DOMDocument)`
- **Submodules:** `html_transformer_examples`; `html_transformer_ui` (form `/html-transformer/transform`, perm `use html_transformer_ui`, restricted)
- Also ships a migrate process plugin.

**Security:** UI route gated by a restricted permission; transform output is shown in disabled textareas via Form API `#default_value` (escaped) — no XSS sink there. The transformer performs no sanitization (mechanical DOM tool); callers must filter output rendered to end users.

See [api/transform.md](api/transform.md)
