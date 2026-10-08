# Configure Easy Social (settings + placement)

All configuration is admin-only: every route below requires the permission `administer easy_social`
(`restrict access: TRUE`). There is one global form plus one form per network, each editing its own
config object. Machine names and keys are exact.

## Routes / forms

| Route | Path | Form class | Form id | Config object edited |
|---|---|---|---|---|
| `easy_social.settings` | `/admin/config/services/easy-social` | `EasySocialSettingsForm` | `easy_social_settings` | `easy_social.settings` |
| `easy_social.settings_twitter` | `/admin/config/services/easy-social/twitter` | `TwitterSettingsForm` | `easy_social_twitter` | `easy_social.twitter` |
| `easy_social.settings_facebook` | `/admin/config/services/easy-social/facebook` | `FacebookSettingsForm` | `easy_social_facebook` | `easy_social.facebook` |
| `easy_social.settings_linkedin` | `/admin/config/services/easy-social/linkedin` | `LinkedInSettingsForm` | `easy_social_linkedin` | `easy_social.linkedin` |
| `easy_social.settings_pinterest` | `/admin/config/services/easy-social/pinterest` | `PinterestSettingsForm` | `easy_social_pinterest` | `easy_social.pinterest` |
| `easy_social.settings_email` | `/admin/config/services/easy-social/email` | `EmailSettingsForm` | `easy_social_email` | `easy_social.email` |

The sub-forms appear as local tasks (tabs) on the settings page (`easy_social.links.task.yml`). The
form classes are `final` `ConfigFormBase` subclasses in `src/Form/`.

## Global settings — `easy_social.settings`

`EasySocialSettingsForm` builds its checkbox list from `easy_social_get_widgets()` (all defined
widgets), so the options are exactly the enabled widget hooks (default: twitter, facebook, linkedin,
pinterest, email).

| Key | Type | Meaning |
|---|---|---|
| `global.widgets` | sequence of strings | Machine names of the globally-enabled widgets. Values are stored keyed (e.g. `twitter: 'twitter'`); `easy_social_preprocess_easy_social()` runs them through `array_filter()`, so unchecked entries (falsy) are dropped. |
| `global.async` | boolean | "Load JavaScript asynchronously" (advanced fieldset). Passed to templates as `async`; note the actual async loader `_easy_social_add_js()` is dead code (its `drupal_add_js` call is commented out). |

If a widget is enabled in `global.widgets` but has no definition, `easy_social_preprocess_easy_social()`
throws `EasySocialException`.

Set from code:

```php
\Drupal::configFactory()->getEditable('easy_social.settings')
  ->set('global.widgets', ['twitter' => 'twitter', 'email' => 'email', 'facebook' => 0, 'linkedin' => 0, 'pinterest' => 0])
  ->set('global.async', TRUE)
  ->save();
```

## Per-network keys

Each network form writes plain scalars; the matching `hook_preprocess_HOOK` in `easy_social.module`
maps set values to `data-*` attributes rendered through Drupal's `Attribute` object (auto-escaped).

- **`easy_social.twitter`** (`TwitterSettingsForm`): `via` (string, `data-via`), `related` (string,
  `data-related`), `count` (`none`/`horizontal`/`vertical`, `data-count`), `hashtags` (string,
  `data-hashtags`), `size` (checkbox → `data-size` `large`/`medium`), `dnt` (checkbox → `data-dnt`),
  `lang` (select of ~40 codes). Rendered onto `<a href="https://twitter.com/share" class="twitter-share-button">`; JS from `easy_social/twitter`.
- **`easy_social.facebook`** (`FacebookSettingsForm`): `send`, `share`, `show_faces` (checkboxes →
  `data-send`/`data-share`/`data-show-faces`), `layout` (`button`/`button_count`/`box_count`),
  `width` (int px), `font` (select), `colorscheme` (`light`/`dark`), `action` (`like`/`recommend`).
  Also sets `data-href` from the current page URL. Renders `<div class="fb-like">`; JS from `easy_social/facebook` (SDK v13.0). Note `share` is saved/read but is **not** in `config/schema/easy_social.schema.yml`.
- **`easy_social.linkedin`** (`LinkedInSettingsForm`): `counter` (`top`/`right`/`none`, `data-counter`),
  `lang` (LinkedIn locale codes; drives an unused inline `___gcfg` snippet). Renders `<script type="IN/Share" data-url=…>`; JS from `easy_social/linkedin`.
- **`easy_social.pinterest`** (`PinterestSettingsForm`): `config` (`above`/`beside`/`none` — pin-count
  position), `image` (string), `description` (string). The shipped template is a static Pin-It anchor;
  JS from `easy_social/pinterest`.
- **`easy_social.email`** (`EmailSettingsForm`): `button_label` (visible text), `button_title`
  (`aria-label` tooltip), `subject`, `body`. Rendered as a pure `mailto:` link —
  `easy_social_preprocess_easy_social_email()` `rawurlencode()`s subject/body and appends the current
  page URL. No JavaScript and no third-party call.

## Showing the widgets (three placements)

1. **Block** — place block plugin `easy_social_block` ("Easy Social") in a region via Block Layout.
   `EasySocialBlock::build()` renders `#theme => 'easy_social'`. `easy_social_preprocess_block()` adds
   `role="complementary"` to the block wrapper.
2. **Display field** — `easy_social_entity_extra_field_info()` registers an extra display component
   `easy_social` (label "Easy Social widgets", hidden by default) on every bundle of `comment`, `file`,
   `node`, `taxonomy_term`, `user`. Enable it on **Manage display** (`.../display`); `easy_social_entity_view()`
   injects `#theme => 'easy_social'` when the component is visible. To extend the entity-type list, see
   [../hooks/widgets.md](../hooks/widgets.md).
3. **Direct render** — build `['#theme' => 'easy_social']` anywhere.

All three render the same `easy_social` theme hook, so which buttons appear is governed solely by
`easy_social.settings:global.widgets`; there is currently no per-block or per-field widget override
(the code has `@todo`s for contextual config).
