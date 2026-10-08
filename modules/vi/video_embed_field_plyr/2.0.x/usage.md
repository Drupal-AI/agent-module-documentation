Renders video-embed and core oEmbed fields through the bundled Plyr.js player instead of the provider's own default embed.

---

The module ships two field formatters. `PlyrEmbed` (formatter id `video_embed_field_plyr`) targets the contrib **Video Embed Field** field type: it asks that module's provider manager for the video id and embed data, then hands them to Plyr. `PlyrOembed` (formatter id `video_oembed_field_plyr`) targets **link / string / string_long** fields, but only applies when the field lives on a Media entity whose source is a core oEmbed source; it uses core's own oEmbed URL resolver and resource fetcher and only accepts video-type resources. Both share `PlyrSharedTrait`, which builds the per-instance Plyr configuration and attaches the libraries, so a site can move from contrib video fields to core Media without changing player. The default provider chrome (YouTube's or Vimeo's controls, branding and suggested-video overlays) is replaced by one lightweight custom player that is themeable with CSS and keyboard/screen-reader accessible. Player behaviour is configured per field display: autoplay, loop, reset-on-end, auto-hide controls, an individually toggleable set of control buttons (play, progress, mute, volume, settings, fullscreen, and more), a background-video mode that disables controls and force-loops muted, a YouTube no-cookie option, an optional RangeTouch enhancement for mobile sliders, and an IE11 polyfilled build. Rendering goes through the `video-embed-plyr.html.twig` / `video-oembed-plyr.html.twig` templates (with provider- and background-specific template suggestions), so themes can fully override the markup. Plyr 3.7.8 and RangeTouch 2.0.1 are bundled inside the module and served locally. Only YouTube and Vimeo are supported in practice; self-hosted MP4 is not implemented. The current release is 2.0.0-rc2 (a release candidate).

---

- Replace YouTube's player chrome with one custom, themeable player.
- Give Vimeo and YouTube videos a single consistent player interface.
- Style video controls with the site's own CSS.
- Improve keyboard and screen-reader accessibility of embedded video.
- Render core Media oEmbed video through Plyr on a link/string field display.
- Render Video Embed Field values through Plyr on a manage-display screen.
- Remove the provider's suggested-video overlays and branding.
- Choose exactly which control buttons appear (play, progress, mute, volume, settings, fullscreen, PiP, etc.) per display.
- Autoplay a video on load for a hero/banner region.
- Loop a short video and reset it to the start when it ends.
- Enable background-video mode: controls off, muted, auto-looping, click-to-play disabled.
- Use YouTube's no-cookie (`youtube-nocookie`) player domain.
- Add the RangeTouch library to improve range sliders on touch devices.
- Ship an IE11-compatible polyfilled Plyr build when legacy browser support is required.
- Keep the same player when migrating a site from Video Embed Field to core Media.
- Override the player markup per provider via Twig template suggestions (`video_embed_plyr__youtube`, `video_oembed_plyr__vimeo`, background variants).
- Serve the Plyr assets locally rather than from a CDN.
- Configure different player options for different view modes of the same field.
- Present a set of mixed-provider videos with identical controls across a listing.
- Merge extra Plyr JSON options (e.g. a local blank video, disabling the remote sprite) in a theme template override.
- Audit which video field displays use the Plyr formatters versus the default embed.
- Evaluate the 2.0.0-rc2 release candidate before committing it to production.
