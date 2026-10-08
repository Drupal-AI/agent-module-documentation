# Architecture — the four plugins + theme hook

Media Crowdriff is a thin core-Media integration. It defines **no plugin *type*** of its own;
it *implements* core plugin types. Everything lives in `src/`.

## 1. Media source — `MediaCrowdriffSource`

`src/Plugin/media/Source/MediaCrowdriffSource.php`, `@MediaSource(id="media_crowdriff")`.

- `allowed_field_types = {"string_long"}`, `default_thumbnail_filename = "generic.png"`.
- `forms = { "media_library_add" = MediaCrowdriffMediaForm }` — the Media Library add form.
- `getMetadataAttributes()` returns `[]` (no extracted metadata).
- Implements `MediaSourceFieldConstraintsInterface::getSourceFieldConstraints()` → applies the
  `media_crowdriff` validation constraint to the source field.

## 2. Media Library add form — `MediaCrowdriffMediaForm`

`src/Form/MediaCrowdriffMediaForm.php` extends `media_library`'s `AddFormBase`.

- Renders one **"Embed Code"** `textarea` (`crowdriff_id`, required) described as "Copy and
  paste the code fragment from the embed dialog in Crowdriff."
- The Add button validates via `::validateCrowdriffId` (creates a media entity from the value
  and runs `$media->validate()`, surfacing any constraint violations) then submits via
  `::addButtonSubmit` → `processInputValues()`.

## 3. Validation constraint — `MediaCrowdriffConstraint` + validator

`src/Plugin/Validation/Constraint/`, `@Constraint(id="media_crowdriff")`.

- The validator reads the source field value, trims `/`, and:
  - empty → adds `emptyUrlMessage` ("The embed code cannot be empty.").
  - no match for `MediaCrowdriffEmbedFormatter::REGEX_PATTERN`
    (`/(cr-init__|cr__init-)[a-z0-9]{8,}/`) → adds `invalidUrlMessage`.

## 4. Field formatter — `MediaCrowdriffEmbedFormatter`

`src/Plugin/Field/FieldFormatter/`, `@FieldFormatter(id="media_crowdriff", field_types={"string_long"})`.

- `defaultSettings()` → `width: '100%'`, `height: '900px'`; `settingsForm()` exposes both as
  CSS-unit textfields; `settingsSummary()` prints "Iframe size: %width , %height.".
- `viewElements()` `preg_match`es the embed id out of the stored value (skips items with no
  match) and builds a `#theme => 'media_crowdriff'` render array with `#crowdriff` (the id),
  `#script` (the loader URL constant), `#title`, `#width`, `#height`.

## Theme hook + template

`media_crowdriff_theme()` registers the `media_crowdriff` hook (vars: `crowdriff`, `script`,
`title`, `width`, `height`). `templates/media-crowdriff.html.twig` emits just:

```twig
<script id={{ crowdriff }} src={{ script }} async></script>
```

where `script` is the constant `CROWDRIFF_SCRIPT_URL =
https://starling.crowdriff.com/js/crowdriff.js`. Crowdriff's loader then replaces the tag
with the live gallery client-side. `width`/`height` are passed to the template but the shipped
template does not wrap them in an element — sizing is effectively controlled by Crowdriff's
own embed markup / theme CSS.
