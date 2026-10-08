Block Animate lets a site builder attach an Animate.css animation to any block by picking it from the block's configuration form, no CSS or preprocess code required.

---

Animate.css is a stylesheet of named keyframe animations — `fadeInUp`, `bounceIn`, `slideInLeft`, `zoomOut` and roughly seventy more. Using it in Drupal normally means adding the library, attaching it to the right pages, and getting the class names onto the right markup, which for a block means a preprocess hook or a template override. Block Animate does that plumbing: it bundles `animate.min.css`, adds an "Animate CSS" fieldset to every block's configuration form at Structure > Block layout, and stores your choice as a block third-party setting. When the block renders, `block_animate_preprocess_block()` attaches the bundled library and appends `animate__animated animate__<effect>` to the block's class attribute (plus `animate__infinite infinite` when the infinite-loop checkbox is on). Because the CSS ships with the module there is no external CDN origin added to the page. Two practical caveats: the stylesheet loads on every page that contains an animated block, and entrance animations fire on load rather than on scroll, so a block below the fold will have finished animating before a visitor reaches it — the module supplies the classes, not the intersection/scroll logic. There are no routes, permissions, Drush commands or settings page; everything happens through the standard block form, which is gated by the core "administer blocks" permission.

---

- Animate a block on page load without writing any CSS.
- Fade a block in with `fadeIn` / `fadeInUp` / `fadeInDown`.
- Slide a block in from a direction with `slideInLeft` / `slideInRight` / `slideInUp` / `slideInDown`.
- Bounce a block into view with `bounceIn` or one of its directional variants.
- Zoom a block in or out with `zoomIn` / `zoomOut` and their directional variants.
- Draw attention to a call-to-action block with `pulse`, `tada`, `shake` or `flash`.
- Apply a continuous looping animation by ticking the "infinite loop" checkbox.
- Choose the animation from a dropdown in the block UI instead of editing templates.
- Configure a different animation per block instance.
- Serve Animate.css locally (bundled) rather than pulling it from a CDN.
- Avoid adding a custom preprocess hook just to place a class name on a block.
- Standardise entrance animations across many blocks on a site.
- Export block animation choices with configuration (stored as block third-party settings).
- Set the animation via config/YAML by writing the `block_animate` third-party setting on a block.
- Remove an animation by selecting "-- No animation --" and re-saving the block.
- Add flip effects (`flipInX` / `flipInY`) or light-speed / rotate / roll / hinge effects to a block.
- Keep the animation choice with the block so it moves with configuration deployment.
- Animate menu, custom, views or system blocks alike — any block that goes through the block config form.
- Combine a decorative block animation with an existing theme without touching the theme's CSS.
- Prototype motion quickly in the admin UI before committing to a bespoke animation approach.
