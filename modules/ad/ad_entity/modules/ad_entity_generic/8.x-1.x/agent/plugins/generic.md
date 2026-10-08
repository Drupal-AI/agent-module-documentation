<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The generic ad type, its JS view, and the loader queue

## Install & enable

```bash
drush en ad_entity_generic -y
```

Requires `ad_entity`. No permissions or routes of its own. `ad_entity_generic_install()` clears
ad_entity's cached plugin definitions so the new `generic` plugins register.

## AdType: `GenericType`

`src/Plugin/ad_entity/AdType/GenericType.php` — `@AdType(id = "generic", label = "Generic slot")`,
extends `Drupal\ad_entity\Plugin\AdTypeBase`.

`entityConfigForm()` adds three fields to the Advertising entity form (stored in the entity's
`ad_entity_generic` third-party settings; schema `ad_entity.ad_entity.*.third_party.ad_entity_generic`):

| Field | Key | Notes |
|---|---|---|
| Identifier | `id` | Required textfield (`#size 20`). Used as the container DOM id (made unique per render). |
| Display format | `format` | Required textfield. Emitted as the `data-ad-format` attribute; your loader reads it. |
| Default targeting | `targeting` | Textfield (`#maxlength 2048`). Free-form `key: value, key: value2` pairs parsed by `TargetingCollection`. |

`entityConfigSubmit()` trims the targeting input, parses it with
`TargetingCollection::collectFromUserInput()`, and stores it as
`setThirdPartySetting($provider, 'targeting', ['targeting' => $targeting->toArray()])` (or `NULL`
when empty). The schema types `targeting` as `ignore`.

## AdView: `GenericJsView`

`src/Plugin/ad_entity/AdView/GenericJsView.php` —
`@AdView(id = "generic", label = "Generic ads via JavaScript", library = "ad_entity_generic/view",
requiresDomready = FALSE, container = "html", allowedTypes = {"generic"})`, extends `AdViewBase`.

- `build($entity)` → `['#theme' => 'ad_entity_generic_js', '#ad_entity' => $entity]`.
- `entityConfigForm()` adds a `disable_initialization` checkbox (bound to the entity's
  `disable_initialization` property) so a slot can be skipped by the automatic collector and
  initialized manually.

## The rendered container

`hook_theme()` registers `ad_entity_generic_js`; `template_preprocess_ad_entity_generic_js()` reads
the entity's `ad_entity_generic` settings and builds a `Drupal\Core\Template\Attribute`:

- `id` = `HtmlId::getUnique($settings['id'])` (uniquified),
- class `adtag`,
- `data-ad-format` = `$settings['format']`.

Template `templates/ad-entity-generic-js.html.twig` is just `<div{{ attributes }}></div>` — an
empty container. All attribute values pass through Drupal's `Attribute`/Twig escaping, so the
module never prints ad markup itself; the slot starts empty and is filled by JS.

## The JavaScript loader queue

`ad_entity_generic/base` (`js/generic.base.js`, loaded in the header) initializes
`window.adEntity.generic = {toLoad: [], toRemove: [], loadHandlers: [], removeHandlers: []}` and
defines `load(ad_tags)` / `remove(ad_tags)` that call each registered handler. A default `queue`
handler pushes any not-yet-consumed tags onto the global `toLoad` / `toRemove` arrays.

`ad_entity_generic/view` (`js/generic.view.js`) registers `ad_entity.viewHandlers.generic`. Its
`initialize(containers, …)` builds, for each `.adtag` element, an `ad_tag` object:

- `id`, `el`, `name` (machine name), `format` (from `data-ad-format`),
- `targeting` (per-slot targeting merged with `slotNumber`, `onPageLoad`, and `personalized` from
  `ad_entity.usePersonalization()`),
- `done(success, isEmpty)` — call this when your loader finishes; it flips CSS classes
  (`initialized`/`empty`/`not-empty`), sets `isLoaded`, and triggers `adEntity:initialized`.

It then calls `ad_entity.generic.load(ad_tags)`. `detach()` collects tags and calls
`ad_entity.generic.remove(ad_tags)`.

To integrate a real ad server, register your own handler on `adEntity.generic.loadHandlers`
(unshift to run first), `shift()` the tags you own, load the creative, and call
`ad_tag.done(true, isEmpty)`. See the `ad_entity_generic_example` submodule for a complete example.

## Page attachment

`ad_entity_generic_page_attachments()` attaches `ad_entity_generic/base` on non-admin routes when
`AdEntityUsage::getCurrentlyUsedAdViewPlugins()` reports a `generic` plugin in use. The optional
global page-targeting `<script>` is documented in [../config/page-targeting.md](../config/page-targeting.md).
