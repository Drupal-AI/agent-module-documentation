<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Headline Group (headline_group) — agent index

Core-only **composite field type**: one field storing **superhead** (kicker above), **headline**, and **subhead** (below), rendered as a **single semantic heading** with styled inner `<span>`s rather than stacked heading tags. Version **8.x-1.9**, `core_version_requirement: ^8.8 || ^9 || ^10 || ^11`. No dependencies, no permissions, no Drush, no config schema shipped.

## What it provides (plugins)
- **Field type** `headline_group` — `Drupal\headline_group\Plugin\Field\FieldType\HeadlineGroupItem`. Three text columns: `superhead`, `headline`, `subhead` (each `type: text`, `size: medium`, nullable). Each exposed as a `string` property.
- **Widget** `headline_complete` (default, label "Headline Group (all fields)") — fieldset with a textfield per enabled part (`HeadlineCompleteWidget`).
- **Widget** `headline_headline_only` (label "Headline only") — headline textfield only (`HeadlineHeadlineOnlyWidget`, empty subclass of `BaseHeadlineWidget`).
- **Formatter** `headline_default` (default, label "Headline Group (Complete)") — `HeadlineDefaultFormatter`.

## Field-instance settings (`defaultFieldSettings` / `fieldSettingsForm`)
- `include_superhead` — checkbox; value `include_superhead` shows the superhead input (default on).
- `include_subhead` — checkbox; value `include_subhead` shows the subhead input (default on).
- `title_behavior` — radios, one of:
  - `headline_is_blank` — headline is independent; no title interaction.
  - `headline_is_flexible` — **default**; if the editor leaves the headline empty, the parent entity title is copied in (`massageFormValues`), and the widget shows the title as placeholder/description.
  - `headline_is_title` — headline input is disabled and always overwritten with the parent entity title.

The constants live on `HeadlineGroupItemInterface` (`HG_BLANK`, `HG_OVERRIDE`, `HG_PROHIBIT`, `HG_SUPERHEAD`, `HG_SUBHEAD`).

## Parent-title resolution (`BaseHeadlineWidget::getParentTitle`)
Reads the parent entity's `label` key from: a normal entity form (`$form_state->getFormObject()->getEntity()`), an **Inline Entity Form** subform (`$form['#entity']`), or **Layout Builder** block forms (`AddBlockForm` / `UpdateBlockForm`) via the section-storage `entity` context. Layout Builder classes are imported but only exercised when Layout Builder is installed — a **soft dependency**, not declared in info.yml.

## Formatter output (`HeadlineDefaultFormatter::viewElements`)
Per delta, if any part is non-empty, emits an outer `html_tag`:
```
<{tag} class="{class}"[ id="{clean-css-id-of-headline}"]>
  <span class="{class}__super">{superhead}</span>   (if superhead + BEM)
  <span class="{class}__head">{headline}</span>
  <span class="{class}__sub">{subhead}</span>
</{tag}>
```
- **Display settings** (`defaultSettings` / `settingsForm`): `headline_group_tag` (select **allowlist**: `div`,`h1`–`h6`; default `div`), `headline_group_class` (textfield, default `headline-group`, maxlength 64), `headline_group_bem` (checkbox, default TRUE — inner classes become `class__super/head/sub`, else bare `super/head/sub`), `headline_group_anchor` (checkbox, default FALSE — adds `id` = `Html::cleanCssIdentifier($headline)`).
- The part text is the `#value` of a core `html_tag` element → rendered through **`Xss::filterAdmin()`** (admin-safe HTML allowed; `<script>`, event handlers, dangerous protocols stripped). See `security` review — **clean**.

## Other integration
- `headline_group.module` — `hook_help` renders README.txt (via Markdown module filter if present, else `<pre>`).
- `headline_group.tokens.inc` — declares a **non-standard** token type `headline_group` with tokens `headline` / `superhead` / `subhead`; `hook_tokens` reads `$data['headline']` etc., so a caller must pass those data keys. Not a normal entity-field token.

## Quirks / gotchas
- `HeadlineGroupItem::isEmpty()` **always returns FALSE** — the field is never considered empty, so a value row is always saved even when all parts are blank (the formatter still skips rendering when all three are empty).
- FieldType annotation has a stray `module = "field_monolith"` — cosmetic leftover; the real provider is `headline_group`.
- No `config/schema/*.yml` ships (field/formatter settings rely on core generic handling).

## Deeper docs
- `agent/fields/field-type.md` — full field type / widget / formatter reference and worked config.
