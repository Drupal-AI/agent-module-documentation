<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nodeletter (nodeletter) — agent index
**Sends content nodes as newsletters through Mailchimp, recording each send as a `nodeletter_sending` entity.**

- **Version:** 2.0.x (2.0.0-beta1)
- **Core:** ^9 || ^10 || ^11
- **Package:** mail
- **Depends on:** node, mailchimp, field
- **Configure:** `nodeletter.admin_settings` (`/admin/config/services/nodeletter`)
- **Key routes:** `entity.node.nodeletter` (`/node/{node}/nodeletter`, `_entity_access: node.update` + `_nodeletter_enabled` + `_node_published`); per-type settings + admin settings (`administer site configuration`); sendings collection (`view nodeletter_sending entity`).
- **Services:** `nodeletter` (NodeletterService), `plugin.manager.nodeletter_sender`, two access checks (`_nodeletter_enabled`, `_node_published`).
- **Submodule:** `nodeletter_blocks` — sending form as a block.

**Access:** Node form is gated (node.update + published + type-enabled); admin routes permission-gated.

See [configure/setup.md](configure/setup.md)
