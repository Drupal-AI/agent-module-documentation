<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# synhelper — routes & pages

Defined in `synhelper.routing.yml`. All are read-only page/form controllers; none mutate content.

| Route | Path | Controller / form | Permission |
| --- | --- | --- | --- |
| `synhelper.settings` | `/admin/config/synapse/synhelper` | `Form\Settings` | `administer site configuration` |
| `synhelper.page` | `/admin/config/synapse` | `Controller\LogoPage::page` | `access content` |
| `synhelper.policy` | `/policy` | `Controller\PagePolicy::page` | `access content` |
| `synhelper.policy-lang` | `/policy/{lang}` | `Controller\PagePolicy::page` | `access content` |
| `synhelper.demo-page` | `/demo-page` | `Controller\PageDemo::page` | `access content` |
| `synhelper.test` | `synhelper/test-cookie` | `Controller\TestCookiePage::page` | `access content` |

## PagePolicy (`src/Controller/PagePolicy.php`)
`page($lang = FALSE)` returns 404 (`NotFoundHttpException`) unless `synhelper.settings:fz152` is enabled.
Picks a shipped template by language from a fixed map `['en' => assets/policy-en.html, 'ru' => assets/policy-ru.html]`,
defaulting to `en` for any other/unknown `$lang`, reads it with `file_get_contents()` and renders it as an
`inline_template` render element. `#context` passes only the current request host. `title()` returns a fixed
en/ru title. The rendered HTML comes from module-shipped static assets, not from request input.

## PageDemo (`src/Controller/PageDemo.php`)
Same fixed-map pattern for `content/demo-page-en.yml` / `content/demo-page-ru.yml`. Renders the decoded YAML
`body` as an `inline_template` only when `synhelper.settings:style-page` is enabled; otherwise renders empty.

## LogoPage (`src/Controller/LogoPage.php`)
Renders the Synapse SVG logo via `Utility\Logo::renderable()` (static SVG markup with a restricted
`#allowed_tags` list). Landing page for the `/admin/config/synapse` admin section.

## TestCookiePage (`src/Controller/TestCookiePage.php`)
Sets a one-year `synhelper=test` cookie scoped to `.<host>` and returns a `JsonResponse` echoing the cookie,
the host, and the current user's own id. Diagnostic helper for cookie-domain checks.

## Utility\RelativeInternalUrl (`src/Utility/RelativeInternalUrl.php`)
Guards config-provided links so only relative internal URLs are accepted: `isValid()`, `tryParse()` (wraps
`Url::fromUserInput()` and returns NULL on `InvalidArgumentException`), and `fromConfigOrDefault()` which
falls back to `/policy` when the stored value is empty or invalid. Used by the settings form validation and by
the hooks that render the FZ-152 / cookie links.
