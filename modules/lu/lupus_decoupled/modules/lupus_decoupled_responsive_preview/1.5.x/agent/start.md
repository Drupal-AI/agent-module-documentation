<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled Responsive Preview (lupus_decoupled_responsive_preview) — agent index

Submodule of **lupus_decoupled**. Points **Responsive Preview** at the decoupled front end instead
of Drupal's own rendering. Version **1.5.1**. Core `^10 || ^11`.

Default behaviour on a decoupled site is misleading — it previews rendering visitors never see.

**Verify the preview URL reaches a front end that can render unsaved/unpublished content** (front-
end preview mode + an authenticated request). A responsive preview showing the *published* version
of a draft is worse than none, because it looks authoritative.