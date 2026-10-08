<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Codepen Field (codepen) — agent index
**A Codepen embed field type with widget and embed/URL formatters for placing CodePen pens on entities.**

- **Version:** 8.x-1.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends on:** field
- **Configure:** `/admin/config/media/codepen` (`codepen.settings`, permission `administer codepen`, `restrict access: true`).
- **Field type:** `codepen` (`CodepenItem`); **widget:** `codepen` (`CodepenDefaultWidget`); **formatters:** `codepen_embed`, `codepen_url`.
- **Theme:** `codepen_embed` (`templates/codepen-embed.html.twig`); Feeds target under `src/Feeds/Target`.

**Security:** Only route is the permission-gated admin settings form; no anonymous or mutating endpoints. Front-end embeds load CodePen's external embed script (third-party-embed privacy applies). See [configure/field.md](configure/field.md).
