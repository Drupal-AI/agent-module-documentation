<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AnimateCSS Block integrates the Animate.css library with Drupal blocks, letting you assign an animation effect to any block.

---
Animate.css provides ready-made CSS entrance and attention animations (fade, bounce, zoom, slide, and more). This module extends the AnimateCSS project so those effects can be attached to blocks from Block layout, rather than hand-writing CSS classes or custom JavaScript per block.

A settings form at `/admin/config/user-interface/animatecss/settings/block` (permission `administer animate css block`) manages block-animation defaults, and the per-block configuration is added to the block edit form under Structure » Block layout. The `AnimateCssBlockHelperService` (injecting the AnimateCSS `animate_manager`, config, database, current user and time) registers block selectors and resolves stored animation ids from the `animatecss` table using a parameterized query. It requires the AnimateCSS base module (`animatecss_ui`) and core `block`.

Setup: install AnimateCSS and this module, set defaults on the block settings route, then edit any block and choose its Animate.css effect and timing.
---
- Add an Animate.css effect to a specific block
- Make a block fade in on load
- Make a block bounce for attention
- Apply a zoom entrance animation to a block
- Apply a slide-in animation to a block
- Set animation duration and delay per block
- Configure animation repeat/iteration for a block
- Manage default block-animation settings centrally
- Animate blocks without writing custom CSS
- Animate blocks without writing custom JavaScript
- Choose effects from the Animate.css catalog per block
- Restrict block-animation configuration to a permission
- Integrate block animation with the AnimateCSS admin UI
- Draw attention to a call-to-action block
- Add subtle motion to sidebar blocks
- Reuse the AnimateCSS library already on the site
- Configure animations from Structure » Block layout
- Keep animation styling consistent site-wide
- Apply entrance animations to hero/banner blocks
- Enhance UX with lightweight CSS animations
