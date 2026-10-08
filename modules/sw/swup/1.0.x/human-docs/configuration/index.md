# Configuration

Swup works with no configuration — everything on this page is **optional** and
requires the UI submodule. If you have not already, enable it:

```bash
drush en swup_ui -y
```

## Open the settings form

1. Log in as a user who can administer the site.
2. Go to **Configuration → User interface → Swup**, or navigate directly to
   `/admin/config/user-interface/swup/settings`.

## What you can configure

- **CDN provider** — choose which public CDN delivers the Swup.js library,
  either **unpkg** or **jsDelivr**. (If you installed the library locally, that
  local copy is used instead of the CDN.)
- **Plugins** — Swup ships with a large set of official plugins that you enable
  here as needed, including accessibility (screen-reader and focus management),
  preloading (hover-preload links for instant navigation), a head plugin (meta
  tag and asset updates), forms handling (AJAX form submissions), a progress
  bar, smooth scrolling, and a debug plugin for development. Turn on only the
  ones you want.
- **Theme restrictions** — limit Swup to specific themes, so transitions run on
  your public-facing theme but not elsewhere.
- **Path exclusions** — fine-tune exactly where Swup loads. Admin pages, edit
  forms, and AJAX operations are already excluded automatically; use this to add
  or adjust your own exclusions.

Save the form and reload a front-end page to see your changes take effect.

## Adding custom animations

Animations live in your theme's JavaScript, not in this form. If you want to
drive the transition yourself, initialise Swup in a Drupal behavior, for example:

```js
Drupal.behaviors.swupCustom = {
  attach: function () {
    if (typeof Swup !== 'undefined') {
      const swup = new Swup({
        containers: ['#main-content'],
        animationSelector: '[class*="transition-"]'
      });
    }
  }
};
```

Pair that with CSS transitions on the classes you target to control how the
content animates in and out.
