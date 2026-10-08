<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Entity Twig provides a media source whose content is a rendered Twig template.

---

Media Entity Twig provides a media source plugin that renders Twig templates — letting site builders create media entities whose output is a configurable Twig template (e.g. custom embeds, dynamic markup) rather than a file or oEmbed. It integrates with the Media Library.

Because it renders Twig, restrict who can configure the templates to trusted site builders (templates can contain markup/logic). Depends on core `image`, `media`, `media_library`, `path`, `system` (>=10.3), and `twig_field`; requires Drupal 10.3+.

---

- Provide a Twig-rendering media source.
- Render configurable Twig templates.
- Create template-based media.
- Support custom embeds/markup.
- Integrate with Media Library.
- Restrict template config to trusted builders.
- Note templates contain markup/logic.
- Depend on core `media` and `media_library`.
- Depend on `twig_field`.
- Require Drupal 10.3+.
- Build dynamic media.
- Configure media templates.
- Support custom media output
- Render markup as media
- Extend media sources.
- Provide flexible media.
- Handle template media.
- Support site builders
