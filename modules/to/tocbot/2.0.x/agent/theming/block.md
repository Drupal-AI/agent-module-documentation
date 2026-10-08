# The Tocbot TOC block (`tocbot_block`)

`Drupal\tocbot\Plugin\Block\TocbotBlock`, admin label **"Tocbot TOC"**. This is the module's only
render surface — placing it is how the TOC appears.

## What it renders

```php
return [
  '#markup' => '<div class="js-toc-block"></div>',
  '#attached' => [
    'library' => ['tocbot/drupal.tocbot', TocbotHelper::getLibrary()],
    'drupalSettings' => ['tocbot' => $options],
  ],
];
```

- Outputs a single empty `<div class="js-toc-block">` — the default `toc_selector`, so by default
  the TOC renders **inside the block itself**. (Point `toc_selector` at a different element in your
  theme if you want the list elsewhere.)
- Attaches two libraries: `tocbot/drupal.tocbot` (the init JS + CSS, depends on
  `core/drupal`, `core/once`, `core/jquery`) and either the CDN or local Tocbot library from
  `TocbotHelper::getLibrary()`.
- Builds `$options` by copying **every** `tocbot.settings` key to its camelCase Tocbot option
  (`TocbotHelper::getSettingsOptions()`), passed to JS as `drupalSettings.tocbot`.

## Placement

Place **Tocbot TOC** at *Structure → Block layout* into a region (a sidebar is typical), or create a
`block.block.*` config entity with `plugin: tocbot_block`. It has no special block settings beyond
the standard visibility conditions. For it to actually build a list, the page must contain a
container matching `content_selector` with at least `min_activate` matching headings.

## JS init (`js/tocbot-init.js`)

`Drupal.behaviors.tocbot` runs once per `contentSelector`:

1. If `createAutoIds` is on, it slugs each heading's text into an `id` (deduping collisions).
2. Counts headings under `contentSelector` (excluding `ignoreSelector`).
3. If a `tocSelector` element exists **and** heading count `>= minActivate`, it:
   - adds `extraBodyClass` to `<body>` (when set),
   - resolves `fixedSidebarOffset: 'auto'` to the sidebar's computed `offsetTop`,
   - coerces the numeric options to integers,
   - calls `tocbot.init(options)`.

So no TOC is drawn on pages with too few headings, no matching content container, or no rendered
`.js-toc-block` (i.e. the block not placed / not visible on that page).

## Theming the output

The generated list uses the configurable class names (`toc-list`, `toc-list-item`, `toc-link`,
`is-active-link`, `is-collapsed`, `is-collapsible`, `is-position-fixed`). Style those in your theme,
or set `extra_link_classes` / `extra_list_classes` to add your own. Base styles come from the
module's `css/tocbot-style.css` (in the `tocbot/drupal.tocbot` library).
