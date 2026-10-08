<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Label (entity_label) — agent index

**Per-bundle singular/plural labels with article variants, stored as third-party settings and exposed via tokens and a Twig function.**

- **Version:** 1.0.x (from `1.0.10`)
- **Core:** ^9 || ^10 || ^11
- **Service:** `twig.extension.entity_label` → Twig function `entity_label(entity, type)`.
- **API:** `entity_label_render($entity, $type)`; tokens `[<entity>:label:singular|plural|singular-definite-article|singular-indefinite-article|plural-definite-article]`.
- **Storage:** five `entity_label` third-party settings on each `ConfigEntityBundleBase`; config schema extended via `hook_config_schema_info_alter`.
- **Security:** no routes, permissions or external calls; editing labels rides existing bundle-edit access. Values are `strip_tags()`ed on render.

See [api/tokens-twig.md](api/tokens-twig.md).
