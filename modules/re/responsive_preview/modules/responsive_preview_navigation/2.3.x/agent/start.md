# responsive_preview_navigation — agent start

Submodule of **responsive_preview**. Puts the responsive-preview device controls into core's
Navigation **top bar** (region `Tools`) instead of the classic toolbar. Requires
`responsive_preview` + core `navigation`, and Drupal `^11.1`. No config, no own permissions, no
config schema. Part of project: `responsive_preview`.

How it works: a `#[TopBarItem(id: 'responsive_icons', region: Tools)]` plugin
(`Plugin/TopBarItem/ResponsiveIcons`) reuses the `responsive_preview` service's `getPreviewUrl()`;
when a preview URL exists it renders Desktop and Mobile `<button>`s with the same
`data-responsive-preview-*` attributes the parent JS reads, attaching libraries
`responsive_preview/drupal.responsive-preview` + `responsive_preview_navigation/drupal.responsive-preview-navigation`.
Access requires the parent's `access responsive preview` permission. The two device buttons are
**hardcoded** in the plugin (not `responsive_preview_device` config entities): Desktop = 1280×768
dppx 1 landscape, Mobile = 768×1280 dppx 2 portrait. Theme hook `responsive_preview_navigation`
(template `responsive-preview-navigation.html.twig`) renders the `#items`.

No separate solution docs — everything is above; see the parent's
[api/responsive_preview.md](../../../../2.3.x/agent/api/responsive_preview.md) for the shared service.
