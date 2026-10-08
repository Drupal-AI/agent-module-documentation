<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VVJC style plugin — `views_vvjc` (Carousel3D)

The whole module is one Views style plugin plus its template, tokens and help. There is no admin
settings form and no config object; every setting lives in each View's style options.

## Install / enable

```bash
composer require drupal/vvjc:^2.0   # pulls drupal/vvj_core:^2.0
drush en vvjc
```

Deps: `views`, `filter`, `vvj_core`. On a 1.x → 2.x upgrade, `vvjc.install`'s
`vvjc_update_10001()` runs during `drush updb` and auto-enables `vvj_core` (throws an actionable
`UpdateException` if `vvj_core` is not on disk). Help: `/admin/help/vvjc` (renders README.md; runs
it through the `markdown` filter if that module is enabled, otherwise `<pre>`-escaped).

## Using it

1. Create/edit a View. 2. Format → *Views Vanilla JavaScript 3D Carousel*. 3. *Show* can be Fields
**or** Content/entity rows (`requiresFieldsRow()` returns FALSE — v1 parity; the shipped example
uses `entity:node` teaser rows). 4. Configure the sectioned options form. 5. Save. A warning note
recommends ≤30 items for 3D performance (suppressed on the `vvjc_example` view).

Optional config `config/optional/views.view.vvjc_example.yml` installs on enable when its ID is
free — provides a default display, a page at `/vvjc-example` (gated `access administration pages`),
and a "Featured Articles" block, all over `article` teaser rows.

## The plugin — `Carousel3D` extends `VvjStylePluginBase`

`src/Plugin/views/style/Carousel3D.php`. `#[ViewsStyle(id: 'views_vvjc', theme: 'views_view_vvjc',
display_types: ['normal'])]`. The base (in `vvj_core`) supplies the standard sections; vvjc
overrides small hooks:

- `getModuleSlug()` → `'vvjc'`; `getCustomElementTag()` → `'vvjc-carousel'`.
- `supportsEnableCss()` → **FALSE** (no separate `vvjc-style` library; visuals ship in `vvjc.css`).
- `getDeeplinkReservedWords()` → `VvjcConstants::DEEPLINK_RESERVED_WORDS`
  (`carousel3d, carousel, slide, vvjc, vvj`).
- `getDeeplinkEnableDescription()` / `getDeeplinkIdentifierDescription()` — v1 wording.
- `definePatternOptions()` — declares defaults for the vvjc-specific options.
- `buildPatternSections()` — builds six `#type => details` sections: Dimensions, Behavior,
  Controls & Navigation, Accessibility, Style, Responsive. (Deep-link section comes from the base.)
- `buildLibraryList()` — appends `vvjc/vvjc__<breakpoint>` to the base library list.
- `validateOptionsForm()` — cross-field rule: **deep linking requires dots navigation**.
- `submitOptionsForm()` + `flattenFormValues()` — the sectioned form array is flattened back to the
  flat persisted option shape; re-adds `unique_id` (generated once, kept stable).
- `buildWarningMessage()` — the ≤30-items performance note with a link to edit the example view.

## Options (config schema `views.style.views_vvjc`, `config/schema/vvjc.schema.yml`)

Defaults come from `VvjcConstants`.

- **Dimensions:** `max_width` (string, one of 300–1000; default `500`), `large_screen_height`
  (100–550; default `400`), `small_screen_height` (100–500, no 550; default `350`), `perspective`
  (int px, min 0, step 10; `0` = auto, template falls back to 640).
- **Behavior:** `time_in_seconds` (autoplay ms: `0`=None or 2000–15000; default `5000`),
  `enable_pause_on_hover`, `enable_touch_swipe`, `enable_keyboard_nav` (bool, default TRUE).
- **Controls:** `show_navigation_arrows`, `show_play_pause`, `show_slide_counter`,
  `show_progress_bar` (disabled when interval=None), `show_dots_navigation` (bool, default TRUE);
  `scrollable_dots_width` (int px; `0`=off, else 120–700; shown only when dots on).
- **Accessibility:** `enable_screen_reader`, `pause_on_reduced_motion` (bool, default TRUE).
- **Style:** `background_color` (hex, default `#ffffff`), `background_color_opacity` (float 0.0–1.0
  step 0.1; default `0.7`), `disable_background` (bool, default FALSE).
- **Responsive:** `available_breakpoints` (string `576|768|992|1200|1400`; default `992`).
- **Deep link (base):** `enable_deeplink` (bool), `deeplink_identifier` (string, schema regex
  `^[a-z][a-z0-9-]*[a-z0-9]$`, max 20).
- `unique_id` (int) — auto-generated per instance.

## Rendering

`VvjcThemeHook` registers theme `views_view_vvjc` → `templates/views-view-vvjc.html.twig`. The
template emits the `<vvjc-carousel>` element with the options as `data-*` attributes, one
`.vvjc-item` per row (`{{ row.content }}`, already access-checked/rendered by Views), a nav bar
(arrows, play/pause, progress, counter, dots), SVG icons included from `svg/`, and CSS custom
properties (`--max-width`, `--perspective`, `--height-large/-small`).

`VvjcPreprocessHooks::preprocessViewsViewVvjc()` derives `background_rgb` (an `rgba()` string) from
`background_color` + `background_color_opacity` via a private `hexToRgb()` (integer `hexdec` parts,
so no injection), unless `disable_background`, then delegates row prep to
`ViewsThemeHooks::preprocessViewsViewUnformatted()`. `preprocessViewsView()` adds the legacy
`vvj-carousel` class on the `views_view` wrapper (v1 contract).

## Tokens

`VvjcTokenHooks` registers the `vvjc` token type (`needs-data: view`) and resolves `[vvjc:FIELD]`
(rendered HTML) / `[vvjc:FIELD:plain]` (plain text) by delegating to the shared
`vvj_core.token_resolver` (`->resolve('vvjc', $tokens, $data, $metadata, Carousel3D::class)`).
Values read from the **first row** of rendered View fields; use in header/footer/empty text areas
with *Use replacement tokens from the first row*. The resolver dependency is nullable (`@?`) so the
container compiles during the upgrade window before `vvj_core` is enabled.

## Libraries & upgrade contract (`vvjc.libraries.yml`)

`vvjc` (js `vvjc-carousel-element.js` + `vvjc.js`, css `vvjc.css`, depends on core + several
`vvj_core/*` libs), `vvjc-admin`, and five weight-202 breakpoint CSS libs
`vvjc__576/768/992/1200/1400`. v2 preserves the v1 contract: plugin id `views_vvjc`, theme hook
`views_view_vvjc`, template name, all option keys, library names, JS behavior key
`Drupal.behaviors.VVJCarousel`, `Drupal.vvjc.*` API, and all `.vvjc*` CSS classes. The outer tag
changed `<div>` → `<vvjc-carousel>` (selectors on `.vvjc` still match).
