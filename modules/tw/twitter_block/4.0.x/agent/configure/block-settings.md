<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Twitter Block instance

Twitter Block has **no admin settings page** (`configure` route is `null`). All
configuration is per **block instance**. Add one at **Structure → Block layout**
(`/admin/structure/block`) → *Place block* → **Twitter block** (category "Twitter"),
choose a region, and fill the form. Editing requires core's `administer blocks` permission.

## Settings keys

Stored on the `block` config entity under `settings` (schema
`block.settings.twitter_block`). Defaults come from the plugin's
`defaultConfiguration()`.

| Key | Form group | Widget (`#type`) | Values | Default | Notes |
|---|---|---|---|---|---|
| `username` | (top) | `textfield` | screen name **without** `@` | `''` | **Required.** The account whose timeline is embedded. |
| `theme` | Appearance | `select` | `''` (Default) or `dark` | `''` | Widget color theme. |
| `link_color` | Appearance | `textfield` | 6-char hex **without** `#` (e.g. `abc123`) | `''` | Widget link color. |
| `border_color` | Appearance | `textfield` | 6-char hex without `#` | `''` | Widget border color. |
| `chrome` | Appearance | `checkboxes` | keys `noheader`, `nofooter`, `noborders`, `noscrollbar`, `transparent` | `[]` | Toggle widget chrome; checked keys become a space-separated `data-chrome`. |
| `related` | Functionality | `textfield` | comma-separated screen names | `''` | Suggested accounts to follow after interaction. |
| `tweet_limit` | Functionality | `select` | `''` (Auto) or `1`–`20` | `''` | Fix the timeline to N tweets. |
| `dnt` | Functionality | `checkbox` | boolean | `FALSE` | "Do Not Track" (`data-dnt=true`). |
| `width` | Size | `textfield` | px (180–520) | `''` | Widget width. |
| `height` | Size | `textfield` | px (min 200) | `''` | Widget height. |
| `language` | Accessibility | `textfield` | language code, maxlength 5 | `''` | Overrides auto-detected language; if empty, the current interface language is emitted as `lang`. |
| `polite` | Accessibility | `select` | `polite` or `assertive` | `''` | ARIA politeness (`aria-live`). |

`weight` also exists in the schema but is not exposed on the block form.

## Widget types used on the form

`textfield` (username, link_color, border_color, related, width, height, language),
`select` (theme, tweet_limit, polite), `checkboxes` (chrome), `checkbox` (dnt). The
Appearance / Functionality / Size / Accessibility groups are `details` fieldsets.

## Place a block with drush / PHP

There is no dedicated drush command; place blocks by creating a `block` config entity.
Only set the keys you need — the rest fall back to `defaultConfiguration()`.

```bash
drush php:eval '
\Drupal::entityTypeManager()->getStorage("block")->create([
  "id" => "twitter_drupal",
  "plugin" => "twitter_block",
  "region" => "sidebar_first",
  "theme" => \Drupal::config("system.theme")->get("default"),
  "settings" => [
    "id" => "twitter_block",
    "label" => "Drupal Tweets",
    "username" => "drupal",
    "theme" => "dark",
    "tweet_limit" => "5",
  ],
])->save();
'
```

Read a placed block's settings back:

```bash
drush php:eval '
$b = \Drupal::entityTypeManager()->getStorage("block")->load("twitter_drupal");
print_r($b->get("settings"));
'
```

Delete it: `drush php:eval '\Drupal::entityTypeManager()->getStorage("block")->load("twitter_drupal")->delete();'`
