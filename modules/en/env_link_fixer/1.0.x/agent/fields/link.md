<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link field widget & formatter

Both target the core **`link`** field type. Select them on a bundle's *Manage form display* (widget)
and *Manage display* (formatter).

## Widget: `env_link_fixer_link_widget`

Class `\Drupal\env_link_fixer\Plugin\Field\FieldWidget\EnvLinkFixerLinkWidget`
(`src/Plugin/Field/FieldWidget/EnvLinkFixerLinkWidget.php`), extends core `LinkWidget`. Label
*"Link widget (Env)"*.

- Overrides only `getUserEnteredStringAsUri($string)`. It calls the parent, then compares
  `parse_url($base_url, PHP_URL_HOST)` (global `$base_url`) with `parse_url($uri, PHP_URL_HOST)`.
- If the entered URL's host equals the **current site's** base-URL host, it strips everything up to and
  including `$base_url`, so the value is **stored relative**. This runs at save time (data is
  normalized on entry). It uses the live base URL, not the config mapping, and it does not honor the
  `env_link_fixer_disabled()` flag.

## Formatter: `env_link_fixer_link_formatter`

Class `\Drupal\env_link_fixer\Plugin\Field\FieldFormatter\EnvLinkFixerLinkFormatter`
(`src/Plugin/Field/FieldFormatter/EnvLinkFixerLinkFormatter.php`), extends core `LinkFormatter`. Label
*"Format links (Env)"*.

Extra settings (`defaultSettings()`, on top of core LinkFormatter settings):

| Setting | Type | Meaning |
|---|---|---|
| `local_domains` | textarea (string) | Domains considered local, one per line (or the `hostname|domain` storage format). Empty -> falls back to the standard mapping. |
| `force_relative` | checkbox | When on, convert matching absolute URLs to relative/internal at display time. |

`settingsSummary()` adds *"Local domains will be made relative"* when `force_relative` is on.

### `buildUrl(LinkItemInterface $item)` — display-time conversion

1. If `env_link_fixer_disabled()` -> defers to `parent::buildUrl()`.
2. Only acts when `force_relative` is set **and** the URL is **not routed** (`$url->isRouted()` is
   false — internal/routed links are skipped).
3. Resolves the local-domain list: `env_link_fixer_domains_to_strip()` (standard mapping) when
   `local_domains` is empty, else `env_link_fixer_domains_to_strip('', env_link_fixer_convert_storage_to_array($local_domains))`.
4. If `parse_url($url->getUri(), PHP_URL_HOST)` is in that list, it rebuilds the URL with
   `Url::fromUserInput()` on the path portion, sets `external = FALSE` and `setAbsolute(FALSE)`, and
   re-attaches the original `query` (parsed) and `fragment` so they are preserved.
5. Finally re-applies core's optional `rel` / `target` options, then returns the `Url`.

The conversion only changes what is rendered; the stored field value is untouched.
