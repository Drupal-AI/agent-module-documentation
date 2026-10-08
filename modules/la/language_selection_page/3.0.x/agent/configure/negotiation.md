# Configure (negotiation method + settings)

The module has **no settings page of its own package** — it is a language negotiation method, so you
turn it on in the core chain and then tune it on its own detail form. All values are stored in the
single config object `language_selection_page.negotiation`.

## Enable it in the negotiation chain

1. Go to `/admin/config/regional/language/detection` (route `language.negotiation`, the value of
   info.yml `configure`). You need **Locale** enabled and **more than one** language.
2. For the **Interface text language** type, enable **"Language Selection Page"** (negotiation
   plugin id `language-selection-page`).
3. **Position it near the bottom, just above "Default".** Put a real method (URL, Cookie, Session,
   Browser…) above it, otherwise every visitor lands on the splash page. The method only acts as a
   fallback: `getLangcode()` always returns `FALSE`, and the subscriber only redirects when no
   higher-priority method resolved a language.
4. Every enabled language must have a **URL prefix** (`/admin/config/regional/language/detection/url`).
   `hook_requirements` (`language_selection_page.install`) reports a warning per prefix-less language,
   and the `language_prefixes` condition **blocks** the redirect until all languages have one.

## The detail form

Route `language_selection_page.negotiation_selection_page` at
`/admin/config/regional/language/detection/language_selection_page`
(`_permission: administer languages`, form `NegotiationLanguageSelectionPageForm`). The old Drupal-7
path `/admin/config/regional/language/configure/selection_page` redirects here
(`LegacyDrupal7Redirect`). The form is assembled dynamically: each condition plugin that returns a
form element (`buildConfigurationForm`) contributes a section, and on submit each plugin's value is
written to config **under its plugin id**. Submitting redirects back to `language.negotiation`.

## Config keys — `language_selection_page.negotiation`

Schema: `config/schema/language_selection_page.schema.yml` (type `config_object`). The config keys are
the plugin ids of the form-bearing conditions.

| Key | Type | Default (config/install) | Meaning |
|---|---|---|---|
| `title` | string | `Language selection` | Page title (plugin `title`). |
| `path` | string | `/language_selection_page` | Path of the splash page (plugin `path`). Changing it rebuilds the dynamic route `language_selection_page`. Must start with `/`; cannot collide with an existing valid path, and cannot be the site front page (that would loop). |
| `type` | string | `standalone` | Operating mode (plugin `type`): `standalone` (module template only), `embedded` (inject the body as `{{ content }}` in the theme's page), `block` (render via the `language-selection-page` block instead of redirecting). |
| `blacklisted_paths` | sequence(string) | `/admin`, `/user`, `/admin/*`, `/admin*`, `/node/add/*`, `/node/*/edit`, `/node`, `/sites/default/files/*` | Paths (one per line, `*` wildcard, `<front>` allowed) where the redirect is **circumvented** (plugin `blacklisted_paths`). Matched against the path alias and the internal path. |
| `ignore_neutral` | boolean | `FALSE` | When TRUE, do not redirect on a page whose route entity is untranslatable / language-neutral (plugin `ignore_neutral`). |

## Set it from code

```php
$config = \Drupal::configFactory()->getEditable('language_selection_page.negotiation');
$config
  ->set('title', 'Choose your language')
  ->set('path', '/choose-language')
  ->set('type', 'standalone')          // standalone | embedded | block
  ->set('blacklisted_paths', ['/admin', '/admin/*', '/user', '/api/*'])
  ->set('ignore_neutral', TRUE)
  ->save();
// If you changed 'path', rebuild routes so the dynamic route picks up the new path:
\Drupal::service('router.builder')->rebuild();
```

Note the safety guard in the `path` condition: if `path` equals the site's `page.front`, the plugin
resets `path` to `/language_selection_page` and `system.site:page.front` to `/node` and shows an error,
to avoid an infinite redirect loop.

## Block mode

When `type` is `block`, no redirect happens; instead place the **"Language Selection Page block"**
(block id `language-selection-page`) in a region. The block's access is gated by the condition plugins
flagged `runInBlock=TRUE` (`path`, `path_is_valid`, `language_prefixes`, `blacklisted_paths`,
`ignore_neutral`). See [../plugins/condition.md](../plugins/condition.md).
